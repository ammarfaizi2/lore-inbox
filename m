Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266169AbTGIVv4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 17:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266168AbTGIVv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 17:51:56 -0400
Received: from palrel13.hp.com ([156.153.255.238]:55698 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S266169AbTGIVvx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 17:51:53 -0400
Date: Wed, 9 Jul 2003 15:06:30 -0700
From: David Mosberger <davidm@napali.hpl.hp.com>
Message-Id: <200307092206.h69M6UFX003197@napali.hpl.hp.com>
To: torvalds@transmeta.com
Cc: sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: .incbin patch
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Reply-To: davidm@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Would you mind applying the attached small patch (originally by H.J. Lu)?
It's the last thing that keeps your tree from building directly for ia64.

Sam said he would submit the patch to you, but this was over a week
ago.  I tried to contact Sam, but it looks like his mailbox is full
(probably on vacation).

As I recall, the only objection to this patch came from Russell King,
since it would force ARM to upgrade to a reasonably recent version of
binutils, but he (grudingly) agreed to the change.

Thanks,

	--david

===== usr/Makefile 1.6 vs edited =====
--- 1.6/usr/Makefile	Sun Mar  9 13:47:41 2003
+++ edited/usr/Makefile	Tue Jul  8 10:29:19 2003
@@ -5,11 +5,9 @@
 
 clean-files := initramfs_data.cpio.gz
 
-LDFLAGS_initramfs_data.o := $(LDFLAGS_BLOB) -r -T
-
-$(obj)/initramfs_data.o: $(src)/initramfs_data.scr \
-			 $(obj)/initramfs_data.cpio.gz FORCE
-	$(call if_changed,ld)
+$(src)/initramfs_data.S: $(obj)/initramfs_data.cpio.gz
+	echo "	.section .init.ramfs,\"a\"" &gt; $(src)/initramfs_data.S
+	echo ".incbin \"usr/initramfs_data.cpio.gz\"" &gt;&gt; $(src)/initramfs_data.S
 
 # initramfs-y are the programs which will be copied into the CPIO
 # archive. Currently, the filenames are hardcoded in gen_init_cpio,
===== usr/initramfs_data.scr 1.1 vs edited =====
--- 1.1/usr/initramfs_data.scr	Mon Nov  4 14:04:41 2002
+++ edited/usr/initramfs_data.scr	Tue Jul  8 10:29:19 2003
@@ -1,4 +0,0 @@
-SECTIONS
-{
-	.init.ramfs : { *(.data) }
-}
