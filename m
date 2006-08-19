Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbWHSRdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbWHSRdk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 13:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751020AbWHSRdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 13:33:40 -0400
Received: from mail.gmx.de ([213.165.64.20]:35974 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750852AbWHSRdj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 13:33:39 -0400
X-Authenticated: #704063
Subject: [Patch] Signedness issue in drivers/net/phy/phy_device.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: drzeus-sdhci@drzeus.cx
Content-Type: text/plain
Date: Sat, 19 Aug 2006 19:33:35 +0200
Message-Id: <1156008815.18192.3.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

while checking gcc 4.1 -Wextra warnings, I stumbled across the following
two warnings:

drivers/net/phy/phy_device.c:528: warning: comparison of unsigned expression < 0 is always false
drivers/net/phy/phy_device.c:546: warning: comparison of unsigned expression < 0 is always false

Since phy_read() returns an integer and can return negative values, it
seems to me the best way to get proper error handling working again
is to make val an int. Currently it is an u32, so the < 0 check
always fails.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.18-rc4/drivers/net/phy/phy_device.c.orig	2006-08-19 18:22:56.000000000 +0200
+++ linux-2.6.18-rc4/drivers/net/phy/phy_device.c	2006-08-19 18:24:49.000000000 +0200
@@ -513,7 +513,7 @@ EXPORT_SYMBOL(genphy_read_status);
 
 static int genphy_config_init(struct phy_device *phydev)
 {
-	u32 val;
+	int val;
 	u32 features;
 
 	/* For now, I'll claim that the generic driver supports


