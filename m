Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265228AbTLKUSL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 15:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265229AbTLKURu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 15:17:50 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:40693 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S265228AbTLKUQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 15:16:07 -0500
Date: Thu, 11 Dec 2003 21:20:48 +0100
From: Heinz Diehl <hd@cavy.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test11-wli-2
Message-ID: <20031211202048.GA13608@chiara.cavy.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20031211052929.GN19856@holomorphy.com> <20031211201213.GA12438@chiara.cavy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031211201213.GA12438@chiara.cavy.de>
Organization: private site in Mannheim/Germany
X-PGP-Key: Use PGP! Get my key at http://www.cavy.de/hd.key
User-Agent: Mutt/1.5.5.1i (Linux 2.6.0-test11-wli1 i586)
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:99c799a891397f4941698a2afa7903da
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Dec 11 2003, Heinz Diehl wrote:

>  fs/built-in.o(.text+0x29e6a): In function proc_task_readdir':
>  : undefined reference to __cmpdi2'
>  fs/built-in.o(.text+0x29e7d): In function proc_task_readdir':
>  : undefined reference to __cmpdi2'
>  make: *** [.tmp_vmlinux1] Error 1

Seems -wli-2 still needs the fix someone posted some days ago for -wli-1:

--- fs/proc/base.c	(revision 3)
+++ fs/proc/base.c	(working copy)
@@ -1673,12 +1673,13 @@
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

-- 
# Heinz Diehl, 68259 Mannheim, Germany
