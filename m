Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318208AbSIEVyU>; Thu, 5 Sep 2002 17:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318222AbSIEVw7>; Thu, 5 Sep 2002 17:52:59 -0400
Received: from hermes.domdv.de ([193.102.202.1]:40713 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S318208AbSIEVvg>;
	Thu, 5 Sep 2002 17:51:36 -0400
Message-ID: <3D77BB7E.6090808@domdv.de>
Date: Thu, 05 Sep 2002 22:15:58 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.20pre5 trivial assembler warning fix for apm.c
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------010709000505050902090001"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010709000505050902090001
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

trivial fix for "Warning: indirect lcall without `*'" assembler warnings
attached.
-- 
Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH


--------------010709000505050902090001
Content-Type: text/plain;
 name="apm.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="apm.c.diff"

--- arch/i386/kernel/apm.c.orig	2002-09-05 22:09:58.000000000 +0200
+++ arch/i386/kernel/apm.c	2002-09-05 22:10:32.000000000 +0200
@@ -577,7 +577,7 @@
 	__asm__ __volatile__(APM_DO_ZERO_SEGS
 		"pushl %%edi\n\t"
 		"pushl %%ebp\n\t"
-		"lcall %%cs:" SYMBOL_NAME_STR(apm_bios_entry) "\n\t"
+		"lcall *%%cs:" SYMBOL_NAME_STR(apm_bios_entry) "\n\t"
 		"setc %%al\n\t"
 		"popl %%ebp\n\t"
 		"popl %%edi\n\t"
@@ -624,7 +624,7 @@
 		__asm__ __volatile__(APM_DO_ZERO_SEGS
 			"pushl %%edi\n\t"
 			"pushl %%ebp\n\t"
-			"lcall %%cs:" SYMBOL_NAME_STR(apm_bios_entry) "\n\t"
+			"lcall *%%cs:" SYMBOL_NAME_STR(apm_bios_entry) "\n\t"
 			"setc %%bl\n\t"
 			"popl %%ebp\n\t"
 			"popl %%edi\n\t"

--------------010709000505050902090001--


