Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261168AbVDDSLA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbVDDSLA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 14:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbVDDSLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 14:11:00 -0400
Received: from baikonur.stro.at ([213.239.196.228]:18832 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261168AbVDDSKy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 14:10:54 -0400
Date: Mon, 4 Apr 2005 20:10:48 +0200
From: maximilian attems <janitor@sternwelten.at>
To: lkml <linux-kernel@vger.kernel.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, akpm <akpm@osdl.org>
Subject: [patch 1/3] pnpbios eliminate bad section references
Message-ID: <20050404181048.GA12394@sputnik.stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

one of the last buildcheck errors on i386,
thanks Randy again for double checking.

Fix pnpbios section references:
make dmi_system_id pnpbios_dmi_table __initdata

Error: ./drivers/pnp/pnpbios/core.o .data refers to 00000100 R_386_32
.init.text
Error: ./drivers/pnp/pnpbios/core.o .data refers to 0000012c R_386_32
.init.text

Signed-off-by: maximilian attems <janitor@sternwelten.at>


--- linux-2.6.12-rc1-bk5/drivers/pnp/pnpbios/core.c.orig	2005-04-04 19:11:37.814477672 +0200
+++ linux-2.6.12-rc1-bk5/drivers/pnp/pnpbios/core.c	2005-04-04 19:25:50.074402365 +0200
@@ -512,7 +512,7 @@
 	return 0;
 }
 
-static struct dmi_system_id pnpbios_dmi_table[] = {
+static struct dmi_system_id pnpbios_dmi_table[] __initdata = {
 	{	/* PnPBIOS GPF on boot */
 		.callback = exploding_pnp_bios,
 		.ident = "Higraded P14H",
