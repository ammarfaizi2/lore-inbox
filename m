Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263173AbTLJKbv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 05:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263486AbTLJKbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 05:31:51 -0500
Received: from imap.gmx.net ([213.165.64.20]:52932 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263173AbTLJKbu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 05:31:50 -0500
Date: Wed, 10 Dec 2003 11:31:49 +0100 (MET)
From: "Martin Schaffner" <maschaffner@gmx.ch>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: [PATCH 2.4.23, 2.6.0-test11] avoid unportable "expr length"
X-Priority: 3 (Normal)
X-Authenticated: #1892127
Message-ID: <20645.1071052309@www2.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This one-line patch makes it possible to compile the linux kernel on systems
without GNU expr.


patch for 2.6.0-test11

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


patch for 2.4.23

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


