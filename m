Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbWGFL3B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbWGFL3B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 07:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbWGFL3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 07:29:01 -0400
Received: from bay0-omc1-s13.bay0.hotmail.com ([65.54.246.85]:3109 "EHLO
	bay0-omc1-s13.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S932409AbWGFL3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 07:29:00 -0400
Message-ID: <BAY19-F228A2C0E9216D53EE93CDFCD770@phx.gbl>
X-Originating-IP: [87.51.137.132]
X-Originating-Email: [nkbj1970@hotmail.com]
From: "Niels Kristian Bech Jensen" <nkbj1970@hotmail.com>
To: linux-kernel@vger.kernel.org, linux-ppc@ozlabs.org
Subject: [PATCH 2.6.18-rc1] Compile fix for 2.6.18-rc1 on Ubuntu Edgy (-fstack-protector)
Date: Thu, 06 Jul 2006 13:28:58 +0200
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_NextPart_000_7f71_7edc_1a33"
X-OriginalArrivalTime: 06 Jul 2006 11:28:59.0992 (UTC) FILETIME=[604CED80:01C6A0EF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_7f71_7edc_1a33
Content-Type: text/plain; charset=iso-8859-1; format=flowed

This patch makes it possible to build the 2.6.18-rc1 kernel on Ubuntu Edgy 
(powerpc architecture).

_________________________________________________________________
Vælg selv hvordan du vil kommunikere - skrift, tale, video eller billeder 
med MSN Messenger:  http://messenger.msn.dk

------=_NextPart_000_7f71_7edc_1a33
Content-Type: text/x-patch; name="linux-2.6.18-rc1.diff"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="linux-2.6.18-rc1.diff"

diff -uprN linux-2.6.18-rc1.orig/arch/powerpc/boot/Makefile linux-2.6.18-rc1/arch/powerpc/boot/Makefile
--- linux-2.6.18-rc1.orig/arch/powerpc/boot/Makefile	2006-07-06 12:26:57.000000000 +0200
+++ linux-2.6.18-rc1/arch/powerpc/boot/Makefile	2006-07-06 11:31:22.000000000 +0200
@@ -41,6 +41,10 @@ src-boot += $(zlib)
 src-boot := $(addprefix $(obj)/, $(src-boot))
 obj-boot := $(addsuffix .o, $(basename $(src-boot)))
 
+# Force gcc to behave correct even for buggy distributions
+BOOTCFLAGS	+= $(call cc-option, -fno-stack-protector,) \
+		   $(call cc-option, -fno-stack-protector-all,)
+
 BOOTCFLAGS	+= -I$(obj) -I$(srctree)/$(obj)
 
 quiet_cmd_copy_zlib = COPY    $@
diff -uprN linux-2.6.18-rc1.orig/Makefile linux-2.6.18-rc1/Makefile
--- linux-2.6.18-rc1.orig/Makefile	2006-07-06 12:26:49.000000000 +0200
+++ linux-2.6.18-rc1/Makefile	2006-07-06 11:30:09.000000000 +0200
@@ -310,8 +310,8 @@ CPPFLAGS        := -D__KERNEL__ $(LINUXI
 CFLAGS          := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
                    -fno-strict-aliasing -fno-common
 # Force gcc to behave correct even for buggy distributions
-CFLAGS          += $(call cc-option, -fno-stack-protector-all \
-                                     -fno-stack-protector)
+CFLAGS          += $(call cc-option, -fno-stack-protector,) \
+                   $(call cc-option, -fno-stack-protector-all,)
 AFLAGS          := -D__ASSEMBLY__
 
 # Read KERNELRELEASE from include/config/kernel.release (if it exists)


------=_NextPart_000_7f71_7edc_1a33--
