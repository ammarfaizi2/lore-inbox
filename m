Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267166AbTGOLAJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 07:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267168AbTGOLAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 07:00:09 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:13713 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S267166AbTGOLAE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 07:00:04 -0400
Date: Tue, 15 Jul 2003 13:14:48 +0200 (MEST)
Message-Id: <200307151114.h6FBEmim011191@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: torvalds@osdl.org
Subject: [PATCH][2.6.0-test1] make clean should remove usr/initramfs_data.S
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A 2.6.0-test1 kernel build leaves a temp file in usr/,
initramfs_data.S, that make clean doesn't remove.
This is ugly. Fixed in the patch below.

/Mikael

--- linux-2.6.0-test1/usr/Makefile.~1~	2003-07-11 00:08:29.000000000 +0200
+++ linux-2.6.0-test1/usr/Makefile	2003-07-14 13:54:56.800296448 +0200
@@ -3,7 +3,7 @@
 
 host-progs  := gen_init_cpio
 
-clean-files := initramfs_data.cpio.gz
+clean-files := initramfs_data.cpio.gz initramfs_data.S
 
 $(src)/initramfs_data.S: $(obj)/initramfs_data.cpio.gz
 	echo "	.section .init.ramfs,\"a\"" > $(src)/initramfs_data.S
