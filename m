Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268312AbTCCVkm>; Mon, 3 Mar 2003 16:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268586AbTCCVkm>; Mon, 3 Mar 2003 16:40:42 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:41490 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S268312AbTCCVkl>;
	Mon, 3 Mar 2003 16:40:41 -0500
Date: Mon, 3 Mar 2003 22:51:12 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: Smart notation for non-verbose output
Message-ID: <20030303215112.GA19798@mars.ravnborg.org>
Mail-Followup-To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kai.

Create a nice shorthand to enable the non-verbose output mode.
make V=1	=> Gives verbose output (default)
make V=0	=> Gives non-verbose output

One of the reasons why people does not use KBUILD_VERBOSE=0 that
much is simply the typing needed.
This notation should make it acceptable to type it.
The usage of "make V=0" is restricted to the command line.
Anyone that wants to enable the non-verbose mode pr. default shall
set KBUILD_VERBOSE in the shell.

	Sam

===== Makefile 1.391 vs edited =====
--- 1.391/Makefile	Mon Mar  3 05:55:31 2003
+++ edited/Makefile	Mon Mar  3 22:49:14 2003
@@ -107,6 +107,11 @@
 
 #	For now, leave verbose as default
 
+ifdef V
+  ifeq ("$(origin V)", "command line")
+    KBUILD_VERBOSE = $(V)
+  endif
+endif
 ifndef KBUILD_VERBOSE
   KBUILD_VERBOSE = 1
 endif
