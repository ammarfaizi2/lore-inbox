Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751492AbWH3UfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbWH3UfX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 16:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751504AbWH3UfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 16:35:23 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:22788 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751492AbWH3UfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 16:35:21 -0400
Date: Wed, 30 Aug 2006 22:35:20 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, dmitry.torokhov@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
Subject: [-mm patch] drivers/input/misc/wistron_btns.c: fix section mismatch
Message-ID: <20060830203520.GM18276@stusta.de>
References: <20060826160922.3324a707.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060826160922.3324a707.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following section mismatch
(dmi_matched() is referenced from struct dmi_ids):

<--  snip  -->

...
  Building modules, stage 2.
  MODPOST 1956 modules
WARNING: drivers/input/misc/wistron_btns.o - Section mismatch: reference to .init.text: from .data between 'dmi_ids' (at offset 0x1e0) and '__param_str_force'
WARNING: drivers/input/misc/wistron_btns.o - Section mismatch: reference to .init.text: from .data between 'dmi_ids' (at offset 0x20c) and '__param_str_force'
WARNING: drivers/input/misc/wistron_btns.o - Section mismatch: reference to .init.text: from .data between 'dmi_ids' (at offset 0x238) and '__param_str_force'
WARNING: drivers/input/misc/wistron_btns.o - Section mismatch: reference to .init.text: from .data between 'dmi_ids' (at offset 0x264) and '__param_str_force'
WARNING: drivers/input/misc/wistron_btns.o - Section mismatch: reference to .init.text: from .data between 'dmi_ids' (at offset 0x290) and '__param_str_force'
WARNING: drivers/input/misc/wistron_btns.o - Section mismatch: reference to .init.text: from .data between 'dmi_ids' (at offset 0x2bc) and '__param_str_force'
WARNING: drivers/input/misc/wistron_btns.o - Section mismatch: reference to .init.text: from .data between 'dmi_ids' (at offset 0x2e8) and '__param_str_force'
...

<--  snip  -->

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.18-rc4-mm3/drivers/input/misc/wistron_btns.c.old	2006-08-30 21:47:00.000000000 +0200
+++ linux-2.6.18-rc4-mm3/drivers/input/misc/wistron_btns.c	2006-08-30 21:47:57.000000000 +0200
@@ -242,7 +242,7 @@
 static int have_wifi;
 static int have_bluetooth;
 
-static int __init dmi_matched(struct dmi_system_id *dmi)
+static int dmi_matched(struct dmi_system_id *dmi)
 {
 	const struct key_entry *key;
 

