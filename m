Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283209AbRK2Mq6>; Thu, 29 Nov 2001 07:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283206AbRK2Mqs>; Thu, 29 Nov 2001 07:46:48 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:7 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S283208AbRK2Mqk>; Thu, 29 Nov 2001 07:46:40 -0500
Date: Thu, 29 Nov 2001 15:46:11 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [CFT][PATCH] /proc/interrupts fixes
Message-ID: <20011129154611.A13470@jurassic.park.msu.ru>
In-Reply-To: <Pine.GSO.4.21.0111221823480.853-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0111221823480.853-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Thu, Nov 22, 2001 at 06:36:44PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2001 at 06:36:44PM -0500, Alexander Viro wrote:
> 	Patch works on x86 and should work on every architecture where
> it manages to build.  Hopefully - all of them.  IOW, I've done the
> conversion for all architectures, but there could be typos.  Patch
> is very straightforward - see yourself.

Is /proc/interrupts now allowed only on s390, x86 and mips? ;-)
Also, typeof(x == y) is int, so (void *)(*pos == 0) on 64-bit
platforms produces a compiler warning.
With appended patch this compiles and works fine on alpha.
Thanks for cleaning up the /proc mess!

Ivan.

--- 2.5.1p3/fs/proc/proc_misc.c	Thu Nov 29 13:01:23 2001
+++ linux/fs/proc/proc_misc.c	Thu Nov 29 15:06:51 2001
@@ -318,7 +318,7 @@ static int partitions_read_proc(char *pa
 
 static void *single_start(struct seq_file *p, loff_t *pos)
 {
-	return (void *)(*pos == 0);
+	return NULL + (*pos == 0);
 }
 static void *single_next(struct seq_file *p, void *v, loff_t *pos)
 {
@@ -561,9 +561,7 @@ void __init proc_misc_init(void)
 		entry->proc_fops = &proc_kmsg_operations;
 	create_seq_entry("mounts", 0, &proc_mounts_operations);
 	create_seq_entry("cpuinfo", 0, &proc_cpuinfo_operations);
-#if defined(CONFIG_ARCH_S390) || defined(CONFIG_X86) || defined(CONFIG_ARCH_MIPS)
 	create_seq_entry("interrupts", 0, &proc_interrupts_operations);
-#endif
 #ifdef CONFIG_MODULES
 	create_seq_entry("ksyms", 0, &proc_ksyms_operations);
 #endif

