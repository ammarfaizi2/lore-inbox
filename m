Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266530AbUA3FPv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 00:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266524AbUA3FNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 00:13:25 -0500
Received: from cpe-024-033-224-91.neo.rr.com ([24.33.224.91]:52356 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S266515AbUA3FNF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 00:13:05 -0500
Date: Thu, 29 Jan 2004 23:57:54 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Updates for 2.6.2-rc2
Message-ID: <20040129235754.GE12308@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040129235304.GA12308@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040129235304.GA12308@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recently many PnPBIOS bugs have been triggered by static resource information
requests.  This patch makes an effort to further avoid making them.

diff -urN a/drivers/pnp/pnpbios/core.c b/drivers/pnp/pnpbios/core.c
--- a/drivers/pnp/pnpbios/core.c	2004-01-09 06:59:06.000000000 +0000
+++ b/drivers/pnp/pnpbios/core.c	2004-01-17 21:45:05.000000000 +0000
@@ -251,7 +251,7 @@
 	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
 	if (!node)
 		return -1;
-	if (pnp_bios_get_dev_node(&nodenum, (char )PNPMODE_STATIC, node))
+	if (pnp_bios_get_dev_node(&nodenum, (char )PNPMODE_DYNAMIC, node))
 		return -ENODEV;
 	if(pnpbios_write_resources_to_node(res, node)<0) {
 		kfree(node);
 
