Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbUDDMZC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 08:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbUDDMZC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 08:25:02 -0400
Received: from pra68-d46.gd.dial-up.cz ([193.85.68.46]:37761 "EHLO
	penguin.localdomain") by vger.kernel.org with ESMTP id S262389AbUDDMY7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 08:24:59 -0400
Date: Sun, 4 Apr 2004 14:24:26 +0200
To: linux-kernel@vger.kernel.org
Subject: menuconfig and UTF-8
Message-ID: <20040404122426.GA16383@penguin.localdomain>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: sebek64@post.cz (Marcel Sebek)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I'm using UTF-8 and new changes in Makefile (2.6.5-rc3/2.6.5-final)
broke using menuconfig on linux console (xterm works ok).

$ locale
LANG=POSIX
LC_CTYPE=en_US.UTF-8
LC_NUMERIC="POSIX"
LC_TIME="POSIX"
LC_COLLATE="POSIX"
LC_MONETARY="POSIX"
LC_MESSAGES="POSIX"
LC_PAPER="POSIX"
LC_NAME="POSIX"
LC_ADDRESS="POSIX"
LC_TELEPHONE="POSIX"
LC_MEASUREMENT="POSIX"
LC_IDENTIFICATION="POSIX"
LC_ALL=

This patch fixes it:

diff -urN linux-2.6/Makefile linux-2.6-new/Makefile
--- linux-2.6/Makefile	2004-04-04 14:20:16.000000000 +0200
+++ linux-2.6-new/Makefile	2004-04-04 14:22:18.000000000 +0200
@@ -114,7 +114,6 @@
 LC_ALL :=
 endif
 LC_COLLATE := C
-LC_CTYPE := C
 export LANG LC_ALL LC_COLLATE LC_CTYPE
 
 srctree		:= $(if $(KBUILD_SRC),$(KBUILD_SRC),$(CURDIR))

-- 
Marcel Sebek
jabber: sebek@jabber.cz                     ICQ: 279852819
linux user number: 307850                 GPG ID: 5F88735E
GPG FP: 0F01 BAB8 3148 94DB B95D  1FCA 8B63 CA06 5F88 735E

