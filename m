Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261971AbULPScW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261971AbULPScW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 13:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbULPScW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 13:32:22 -0500
Received: from h131n4c2o1027.bredband.skanova.com ([217.208.27.131]:33035 "EHLO
	ogre.magicalforest.se") by vger.kernel.org with ESMTP
	id S261971AbULPScJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 13:32:09 -0500
Message-ID: <41C1D4A5.3080503@magicalforest.se>
Date: Thu, 16 Dec 2004 19:32:05 +0100
From: =?UTF-8?B?Q2hyaXN0aWFuIEJqw6RsZXZpaw==?= <nafallo@magicalforest.se>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041012)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: Debian-Kernel <debian-kernel@lists.debian.org>
Subject: PROBLEM: Cross-compiling fails (patch included)
Content-Type: multipart/mixed;
 boundary="------------090008050409030504050500"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090008050409030504050500
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

  Hi there!

When using kernel-package (Debian specific kernel-management) to 
cross-compile a kernel in a i386-chroot on my x86_64 laptop 
modules_install fails when trying to depmod things. Since we should not 
depmod those things if the arch being built isn't the same as 'uname -m' 
I wrote a patch for the Makefile to test those conditions.

Sincererly

PS I'm not subscribed to those lists, please CC me on reply. DS
-- 
Christian     .-.    Bjälevik
Eskilstuna    /v\    [SWEDEN]
ICQ UIN      // \\   60036598
Linux User  /(   )\  [344682]
GPG Key ID   ^^-^^   23FE8EB7
         Jabber & Email
    nafallo@magicalforest.se

-----------------------------
diff -puN Makefile.orig Makefile
--- Makefile.orig       2004-12-09 00:08:43.000000000 +0100
+++ Makefile    2004-12-08 23:59:34.000000000 +0100
@@ -788,7 +788,9 @@ depmod_opts := -b $(INSTALL_MOD_PATH) -r
  endif
  .PHONY: _modinst_post
  _modinst_post: _modinst_
+ifeq ([ uname -m ],$(ARCH))
         if [ -r System.map ]; then $(DEPMOD) -ae -F System.map 
$(depmod_opts) $$+endif

  else # CONFIG_MODULES


--------------090008050409030504050500
Content-Type: text/x-patch;
 name="cross-compiling.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cross-compiling.patch"

diff -puN Makefile.orig Makefile
--- Makefile.orig	2004-12-09 00:08:43.000000000 +0100
+++ Makefile	2004-12-08 23:59:34.000000000 +0100
@@ -788,7 +788,9 @@ depmod_opts	:= -b $(INSTALL_MOD_PATH) -r
 endif
 .PHONY: _modinst_post
 _modinst_post: _modinst_
+ifeq ([ uname -m ],$(ARCH))
 	if [ -r System.map ]; then $(DEPMOD) -ae -F System.map $(depmod_opts) $(KERNELRELEASE); fi
+endif
 
 else # CONFIG_MODULES
 

--------------090008050409030504050500--
