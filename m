Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbVKWS2B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbVKWS2B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 13:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbVKWS2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 13:28:01 -0500
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:11180 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S932126AbVKWS2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 13:28:00 -0500
Date: Wed, 23 Nov 2005 19:29:37 +0100 (CET)
From: Bodo Eggert <7eggert@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][RFC] Makefile: Add modules-collect target
Message-ID: <Pine.LNX.4.58.0511231915340.5759@be1.lrz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I frequently (but not frequently enough) compile kernels on one machine 
that are to be used on another machine. If It needs modules, I will need a 
way to collect all modules that need to be transfered into a directory.
Usurally I'll want INSTALL_MOD_PATH=somedir make modules_install, but I
keep forgetting the name of the variable. I suppose I'm not the only one.

Therefore I suggest a modules_collect target, which will collect all 
modules into a single directory ready for being tared and transfered:


--- a/Makefile	2005-11-15 01:41:32.000000000 +0100
+++ b/Makefile	2005-11-23 19:22:33.000000000 +0100
@@ -1065,6 +1065,7 @@ help:
 	@echo  '* vmlinux	  - Build the bare kernel'
 	@echo  '* modules	  - Build all modules'
 	@echo  '  modules_install - Install all modules'
+	@echo  '  modules_collect - Install all modules into ./modules.d'
 	@echo  '  dir/            - Build all files in dir and below'
 	@echo  '  dir/file.[ois]  - Build specified target only'
 	@echo  '  dir/file.ko     - Build module including final link'
@@ -1316,4 +1317,10 @@ clean := -f $(if $(KBUILD_SRC),$(srctree
 
 endif	# skip-makefile
 
+.PHONY: modules_collect
+modules_collect:
+	rm -rf modules.d
+	mkdir modules.d
+	INSTALL_MOD_PATH=modules.d make modules_install
+
 FORCE:

-- 
Top 100 things you don't want the sysadmin to say:
98. What the hell!?
