Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130600AbRCECeT>; Sun, 4 Mar 2001 21:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130603AbRCECeI>; Sun, 4 Mar 2001 21:34:08 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:13661 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S130600AbRCECeB>; Sun, 4 Mar 2001 21:34:01 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.4 mkdep and symlinked kernel source
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 05 Mar 2001 13:33:55 +1100
Message-ID: <2015.983759635@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The recent changes to mkdep can create incorrect dependencies when
  (a) the kernel source is a symlink and
  (b) you cd to the symlink and
  (c) your shell exports PWD.

This one line patch against 2.4.3-pre2 gives consistent results.
Please report any problems to kaos@ocs.com.au.

Index: 3-pre2.1/Makefile
--- 3-pre2.1/Makefile Mon, 05 Mar 2001 10:47:15 +1100 kaos (linux-2.4/T/c/50_Makefile 1.1.2.15.1.2.2.2 644)
+++ 3-pre2.1(w)/Makefile Mon, 05 Mar 2001 13:19:33 +1100 kaos (linux-2.4/T/c/50_Makefile 1.1.2.15.1.2.2.2 644)
@@ -10,7 +10,7 @@ ARCH := $(shell uname -m | sed -e s/i.86
 CONFIG_SHELL := $(shell if [ -x "$$BASH" ]; then echo $$BASH; \
 	  else if [ -x /bin/bash ]; then echo /bin/bash; \
 	  else echo sh; fi ; fi)
-TOPDIR	:= $(shell if [ "$$PWD" != "" ]; then echo $$PWD; else pwd; fi)
+TOPDIR	:= $(shell /bin/pwd)
 
 HPATH   	= $(TOPDIR)/include
 FINDHPATH	= $(HPATH)/asm $(HPATH)/linux $(HPATH)/scsi $(HPATH)/net

