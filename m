Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265805AbTLINbo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 08:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265796AbTLINbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 08:31:44 -0500
Received: from pop.gmx.net ([213.165.64.20]:64218 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265805AbTLINbc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 08:31:32 -0500
Date: Tue, 9 Dec 2003 14:31:30 +0100 (MET)
From: "Martin Schaffner" <schaffner@gmx.li>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: [PATCH 2.4.23, 2.6.0-test11] avoid the use of unportable "expr length"
X-Priority: 3 (Normal)
X-Authenticated: #1892127
Message-ID: <14502.1070976690@www62.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I tried to cross-compile from Mac OS X, which failed because the Makefile
uses the "length" feature of GNU expr, which is not found in BSD expr. Here's a
fix.

Please CC me when replying.

--- a/Makefile	2003-12-09 13:54:50.000000000 +0100
+++ b/Makefile	2003-12-09 13:56:39.000000000 +0100
@@ -640,7 +640,7 @@
 uts_len := 64
 
 define filechk_version.h
-	if expr length "$(KERNELRELEASE)" \> $(uts_len) >/dev/null ; then \
+	if expr "$(KERNELRELEASE)" : '.*' \> $(uts_len) >/dev/null ; then \
 	  echo '"$(KERNELRELEASE)" exceeds $(uts_len) characters' >&2; \
 	  exit 1; \
 	fi; \


--- a/Makefile   2003-12-09 14:27:56.000000000 +0100
+++ b/Makefile   2003-12-09 14:28:37.000000000 +0100
@@ -353,7 +353,7 @@
        @rm -f .ver1

 include/linux/version.h: ./Makefile
-       @expr length "$(KERNELRELEASE)" \<= $(uts_len) > /dev/null || \
+       @expr "$(KERNELRELEASE)" : '.*' \<= $(uts_len) > /dev/null || \
          (echo KERNELRELEASE \"$(KERNELRELEASE)\" exceeds $(uts_len)
characters >&2; false)
        @echo \#define UTS_RELEASE \"$(KERNELRELEASE)\" > .ver
        @echo \#define LINUX_VERSION_CODE `expr $(VERSION) \\* 65536 +
$(PATCHLEVEL) \\* 256 + $(SUBLEVEL)` >> .ver

-- 
+++ GMX - die erste Adresse für Mail, Message, More +++
Neu: Preissenkung für MMS und FreeMMS! http://www.gmx.net


