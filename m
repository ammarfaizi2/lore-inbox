Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265133AbTLKUP5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 15:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265222AbTLKUP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 15:15:57 -0500
Received: from holomorphy.com ([199.26.172.102]:65510 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265133AbTLKUPv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 15:15:51 -0500
Date: Thu, 11 Dec 2003 12:15:42 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: hd@cavy.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test11-wli-2
Message-ID: <20031211201542.GP19856@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>, hd@cavy.de,
	linux-kernel@vger.kernel.org
References: <20031211052929.GN19856@holomorphy.com> <20031211201213.GA12438@chiara.cavy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031211201213.GA12438@chiara.cavy.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Dec 10 2003, William Lee Irwin III wrote:
> > Successfully tested on a Thinkpad T21 
> [....]

On Thu, Dec 11, 2003 at 09:12:13PM +0100, Heinz Diehl wrote:
> Compiling -wli-2 fails showing this:
> 
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
>  fs/built-in.o(.text+0x29e6a): In function proc_task_readdir':
>  : undefined reference to __cmpdi2'
>  fs/built-in.o(.text+0x29e7d): In function proc_task_readdir':
>  : undefined reference to __cmpdi2'
>  make: *** [.tmp_vmlinux1] Error 1
> Greetings, Heinz.

Looks like I dropped this by misake (originally sent in by Hugang):


-- wli


diff -prauN wli-2.6.0-test11-32/fs/proc/base.c wli-2.6.0-test11-33/fs/proc/base.c
--- wli-2.6.0-test11-32/fs/proc/base.c	2003-12-04 08:15:58.000000000 -0800
+++ wli-2.6.0-test11-33/fs/proc/base.c	2003-12-05 01:48:55.000000000 -0800
@@ -1673,12 +1673,13 @@ static int proc_task_readdir(struct file
 	struct inode *inode = dentry->d_inode;
 	int retval = -ENOENT;
 	ino_t ino;
+	unsigned long pos = filp->f_pos;  /* avoiding "long long" filp->f_pos */
 
 	if (!pid_alive(proc_task(inode)))
 		goto out;
 	retval = 0;
 
-	switch (filp->f_pos) {
+	switch (pos) {
 	case 0:
 		ino = inode->i_ino;
 		if (filldir(dirent, ".", 1, filp->f_pos, ino, DT_DIR) < 0)
