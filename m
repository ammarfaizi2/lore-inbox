Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261342AbVB1AZD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbVB1AZD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 19:25:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbVB1AZD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 19:25:03 -0500
Received: from fire.osdl.org ([65.172.181.4]:65508 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261525AbVB1AS5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 19:18:57 -0500
Date: Sun, 27 Feb 2005 16:07:51 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: torvalds <torvalds@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] oss/aedsp16: init/exit sections cleanup
Message-Id: <20050227160751.162cbbf8.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


sound/oss/aedsp16: init/exit section cleanups:

Exit-only function uninit_aedsp16() was marked __init instead of __exit;
ae_config data was marked __initdata but used during exit;
several cleanup functions were marked _init but used for init or exit
  cleanups;

Error: ./sound/oss/aedsp16.o .exit.text refers to 0000000000000004 R_X86_64_PC32     .init.data+0x000000000000003b
Error: ./sound/oss/aedsp16.o .exit.text refers to 000000000000000c R_X86_64_PC32     .init.text+0x00000000000001e4
Error: ./sound/oss/aedsp16.o .exit.text refers to 0000000000000013 R_X86_64_PC32     .init.text+0x0000000000000034
Error: ./sound/oss/aedsp16.o .exit.text refers to 0000000000000019 R_X86_64_PC32     .init.data+0x000000000000003f
Error: ./sound/oss/aedsp16.o .exit.text refers to 0000000000000023 R_X86_64_PC32     .init.text+0x00000000000001b4

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 sound/oss/aedsp16.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff -Naurp ./sound/oss/aedsp16.c~sound_aedsp16_sections ./sound/oss/aedsp16.c
--- ./sound/oss/aedsp16.c~sound_aedsp16_sections	2005-02-27 12:54:07.333808536 -0800
+++ ./sound/oss/aedsp16.c	2005-02-27 16:07:31.392723440 -0800
@@ -489,7 +489,7 @@ static struct orVals orDMA[] __initdata 
 	{0x00, 0x00}
 };
 
-static struct aedsp16_info ae_config __initdata = {
+static struct aedsp16_info ae_config = {
 	DEF_AEDSP16_IOB,
 	DEF_AEDSP16_IRQ,
 	DEF_AEDSP16_MRQ,
@@ -1155,7 +1155,7 @@ static int __init init_aedsp16_sb(void)
 	return TRUE;
 }
 
-static void __init uninit_aedsp16_sb(void)
+static void uninit_aedsp16_sb(void)
 {
 	DBG(("uninit_aedsp16_sb: "));
 
@@ -1196,7 +1196,7 @@ static int __init init_aedsp16_mss(void)
 	return TRUE;
 }
 
-static void __init uninit_aedsp16_mss(void)
+static void uninit_aedsp16_mss(void)
 {
 	DBG(("uninit_aedsp16_mss: "));
 
@@ -1237,7 +1237,7 @@ static int __init init_aedsp16_mpu(void)
 	return TRUE;
 }
 
-static void __init uninit_aedsp16_mpu(void)
+static void uninit_aedsp16_mpu(void)
 {
 	DBG(("uninit_aedsp16_mpu: "));
 
@@ -1294,7 +1294,7 @@ static int __init init_aedsp16(void)
 	return initialized;
 }
 
-static void __init uninit_aedsp16(void)
+static void __exit uninit_aedsp16(void)
 {
 	if (ae_config.mss_base != -1)
 		uninit_aedsp16_mss();


---
