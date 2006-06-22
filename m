Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161166AbWFVSee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161166AbWFVSee (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 14:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030355AbWFVSbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 14:31:09 -0400
Received: from ns1.suse.de ([195.135.220.2]:3210 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030352AbWFVSav (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 14:30:51 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 8/14] [PATCH] w1 exports
Reply-To: Greg KH <greg@kroah.com>
Date: Thu, 22 Jun 2006 11:27:12 -0700
Message-Id: <11510008662311-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11510008623474-git-send-email-greg@kroah.com>
References: <20060622182645.GB5668@kroah.com> <11510008381000-git-send-email-greg@kroah.com> <11510008413045-git-send-email-greg@kroah.com> <11510008461301-git-send-email-greg@kroah.com> <11510008522327-git-send-email-greg@kroah.com> <11510008553417-git-send-email-greg@kroah.com> <11510008583492-git-send-email-greg@kroah.com> <11510008623474-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>

From: Andrew Morton <akpm@osdl.org>

WARNING: "w1_read_block" [drivers/w1/slaves/w1_therm.ko] undefined!
WARNING: "w1_write_8" [drivers/w1/slaves/w1_therm.ko] undefined!
WARNING: "w1_reset_select_slave" [drivers/w1/slaves/w1_therm.ko] undefined!
WARNING: "w1_reset_bus" [drivers/w1/slaves/w1_ds2433.ko] undefined!
WARNING: "w1_write_8" [drivers/w1/slaves/w1_ds2433.ko] undefined!
WARNING: "w1_read_block" [drivers/w1/slaves/w1_ds2433.ko] undefined!
WARNING: "w1_write_block" [drivers/w1/slaves/w1_ds2433.ko] undefined!
WARNING: "w1_reset_select_slave" [drivers/w1/slaves/w1_ds2433.ko] undefined!

Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/w1/w1_io.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/w1/w1_io.c b/drivers/w1/w1_io.c
index a6eb9db..3253bb0 100644
--- a/drivers/w1/w1_io.c
+++ b/drivers/w1/w1_io.c
@@ -23,6 +23,7 @@ #include <asm/io.h>
 
 #include <linux/delay.h>
 #include <linux/moduleparam.h>
+#include <linux/module.h>
 
 #include "w1.h"
 #include "w1_log.h"
@@ -107,6 +108,7 @@ void w1_write_8(struct w1_master *dev, u
 		for (i = 0; i < 8; ++i)
 			w1_touch_bit(dev, (byte >> i) & 0x1);
 }
+EXPORT_SYMBOL_GPL(w1_write_8);
 
 
 /**
@@ -207,6 +209,7 @@ void w1_write_block(struct w1_master *de
 		for (i = 0; i < len; ++i)
 			w1_write_8(dev, buf[i]);
 }
+EXPORT_SYMBOL_GPL(w1_write_block);
 
 /**
  * Reads a series of bytes.
@@ -231,6 +234,7 @@ u8 w1_read_block(struct w1_master *dev, 
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(w1_read_block);
 
 /**
  * Issues a reset bus sequence.
@@ -256,6 +260,7 @@ int w1_reset_bus(struct w1_master *dev)
 
 	return result;
 }
+EXPORT_SYMBOL_GPL(w1_reset_bus);
 
 u8 w1_calc_crc8(u8 * data, int len)
 {
@@ -266,6 +271,7 @@ u8 w1_calc_crc8(u8 * data, int len)
 
 	return crc;
 }
+EXPORT_SYMBOL_GPL(w1_calc_crc8);
 
 void w1_search_devices(struct w1_master *dev, u8 search_type, w1_slave_found_callback cb)
 {
@@ -298,5 +304,4 @@ int w1_reset_select_slave(struct w1_slav
 	}
 	return 0;
 }
-
-EXPORT_SYMBOL_GPL(w1_calc_crc8);
+EXPORT_SYMBOL_GPL(w1_reset_select_slave);
-- 
1.4.0

