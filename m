Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265568AbSL1IsU>; Sat, 28 Dec 2002 03:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265570AbSL1IsU>; Sat, 28 Dec 2002 03:48:20 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:29970 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S265568AbSL1IsT>;
	Sat, 28 Dec 2002 03:48:19 -0500
Date: Sat, 28 Dec 2002 09:56:31 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: gibbs@btc.adaptec.com, gibbs@adaptec.com,
       Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [aic7xxx] Spurious recompile with defconfig
Message-ID: <20021228085631.GA1835@mars.ravnborg.org>
Mail-Followup-To: gibbs@btc.adaptec.com, gibbs@adaptec.com,
	Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling aic7xxx in 2.5.53 with defconfig the kernel always
recompiles because dependency for reg_print.c is not
per default in the aic7xxx Makefile.
Simple correction is to make PRETTY_PRINT dependend on BUILD_FIRMWARE.

	Sam

===== drivers/scsi/aic7xxx/Kconfig.aic79xx 1.5 vs edited =====
--- 1.5/drivers/scsi/aic7xxx/Kconfig.aic79xx	Fri Dec 13 21:17:38 2002
+++ edited/drivers/scsi/aic7xxx/Kconfig.aic79xx	Sat Dec 28 09:46:40 2002
@@ -87,7 +87,7 @@
 
 config AIC79XX_REG_PRETTY_PRINT
         bool "Decode registers during diagnostics"
-        depends on SCSI_AIC79XX
+        depends on SCSI_AIC79XX && SCSI_AIC7XXX_BUILD_FIRMWARE
 	default y
         help
 	Compile in register value tables for the output of expanded register
===== drivers/scsi/aic7xxx/Kconfig.aic7xxx 1.6 vs edited =====
--- 1.6/drivers/scsi/aic7xxx/Kconfig.aic7xxx	Tue Dec 24 20:12:14 2002
+++ edited/drivers/scsi/aic7xxx/Kconfig.aic7xxx	Sat Dec 28 09:46:22 2002
@@ -92,7 +92,7 @@
 
 config AIC7XXX_REG_PRETTY_PRINT
         bool "Decode registers during diagnostics"
-        depends on SCSI_AIC7XXX
+        depends on SCSI_AIC7XXX && SCSI_AIC7XXX_BUILD_FIRMWARE
 	default y
         help
 	Compile in register value tables for the output of expanded register
