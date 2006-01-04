Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750880AbWADSBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbWADSBR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 13:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750879AbWADSBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 13:01:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:58316 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750866AbWADSBR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 13:01:17 -0500
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix pragma packing in ip2 driver
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Wed, 04 Jan 2006 18:01:03 +0000
Message-ID: <31215.1136397663@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch fixes the pragma packing in the ip2 driver by popping the
previous setting rather than explicitly assuming that the correct setting
is 4.

This also gets around a compiler bug in the FRV compiler when building
allmodconfig.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 ip2-pragma-2615rc5.diff 
 drivers/char/ip2/i2pack.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urp linux-2.6.15-rc5/drivers/char/ip2/i2pack.h linux-2.6.15-rc5-frv/drivers/char/ip2/i2pack.h
--- linux-2.6.15-rc5/drivers/char/ip2/i2pack.h	2004-06-18 13:41:44.000000000 +0100
+++ linux-2.6.15-rc5-frv/drivers/char/ip2/i2pack.h	2006-01-04 17:48:08.000000000 +0000
@@ -358,7 +358,7 @@ typedef struct _failStat
 #define MB_OUT_STRIPPED    0x40  // Board has read all output from fifo 
 #define MB_FATAL_ERROR     0x20  // Board has encountered a fatal error
 
-#pragma pack(4)                  // Reset padding to command-line default
+#pragma pack()                  // Reset padding to command-line default
 
 #endif      // I2PACK_H
 
