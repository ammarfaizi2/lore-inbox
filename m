Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261575AbSKCDMH>; Sat, 2 Nov 2002 22:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261576AbSKCDMG>; Sat, 2 Nov 2002 22:12:06 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22799 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261575AbSKCDME>;
	Sat, 2 Nov 2002 22:12:04 -0500
Date: Sun, 3 Nov 2002 03:18:35 +0000
From: Matthew Wilcox <willy@debian.org>
To: linux-kernel@vger.kernel.org
Cc: Kai Germaschewski <kai-germaschewski@uiowa.edu>
Subject: invalid character 45 in exportstr for include-config
Message-ID: <20021103031835.Q20749@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Anyone else seeing this error message?  I figured out what it _actually_
means is that the character `-' is not permitted in the symbol being
exported.  so if we change include-config to include_config in Makefile
and scripts/Makefile.build, everything is fine.

How about the following patch?

diff -u -p -r1.1.2.6 Makefile
--- Makefile    31 Oct 2002 17:26:55 -0000      1.1.2.6
+++ Makefile    3 Nov 2002 03:15:06 -0000
@@ -214,7 +216,7 @@ SUBDIRS             :=
 
 ifeq ($(filter $(noconfig_targets),$(MAKECMDGOALS)),)
 
-export include-config := 1
+export include_config := 1
 
 -include .config
 
diff -u -p -r1.1.2.1 Makefile.build
--- scripts/Makefile.build      31 Oct 2002 17:28:39 -0000      1.1.2.1
+++ scripts/Makefile.build      3 Nov 2002 03:15:06 -0000
@@ -7,7 +7,7 @@ src := $(obj)
 .PHONY: __build
 __build:
 
-ifdef include-config
+ifdef include_config
 include .config
 endif
 


-- 
Revolutions do not require corporate support.
