Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261352AbSJQKyt>; Thu, 17 Oct 2002 06:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261357AbSJQKyt>; Thu, 17 Oct 2002 06:54:49 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:54509 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261352AbSJQKys>; Thu, 17 Oct 2002 06:54:48 -0400
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] 2.5.42: remove capable(CAP_SYS_RAWIO) check from
 open_kmem
References: <87smza1p7f.fsf@goat.bogus.local>
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Date: Thu, 17 Oct 2002 13:00:24 +0200
Message-ID: <87bs5tba9j.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de> writes:

> In drivers/char/mem.c there's open_port(), which is used as open_mem()
> and open_kmem() as well. I don't see the benefit of this, since
> /dev/mem and /dev/kmem are already protected by filesystem
> permissions.
>
> mem.c, line 526:
> static int open_port(struct inode * inode, struct file * filp)
> {
> 	return capable(CAP_SYS_RAWIO) ? 0 : -EPERM;
> }
>
> If anyone knows, why this is done this way, please let me
> know. Otherwise, I suggest the patch below.

I haven't got a convincing answer against this patch, so far. The
patch applies to 2.5.43 as well.
Linus, please apply.

Regards, Olaf.

--- a/drivers/char/mem.c	Sat Oct  5 18:44:55 2002
+++ b/drivers/char/mem.c	Sun Oct 13 13:59:25 2002
@@ -533,15 +533,12 @@
 #define full_lseek      null_lseek
 #define write_zero	write_null
 #define read_full       read_zero
-#define open_mem	open_port
-#define open_kmem	open_mem
 
 static struct file_operations mem_fops = {
 	llseek:		memory_lseek,
 	read:		read_mem,
 	write:		write_mem,
 	mmap:		mmap_mem,
-	open:		open_mem,
 };
 
 static struct file_operations kmem_fops = {
@@ -549,7 +546,6 @@
 	read:		read_kmem,
 	write:		write_kmem,
 	mmap:		mmap_kmem,
-	open:		open_kmem,
 };
 
 static struct file_operations null_fops = {
