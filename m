Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262269AbUCOFh1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 00:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262272AbUCOFh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 00:37:27 -0500
Received: from cpe-024-033-224-91.neo.rr.com ([24.33.224.91]:52097 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S262269AbUCOFh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 00:37:26 -0500
Date: Mon, 15 Mar 2004 00:33:48 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Updates for 2.6.4-mm2
Message-ID: <20040315003348.GH5972@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040315000615.GA5972@neo.rr.com> <20040315001029.GB5972@neo.rr.com> <20040315001519.GC5972@neo.rr.com> <20040315002146.GD5972@neo.rr.com> <20040315002357.GE5972@neo.rr.com> <20040315002607.GF5972@neo.rr.com> <20040315002731.GG5972@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040315002731.GG5972@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ISAPNP] MEM Config Fix

This patch fixes a bug in the resource configuration function.  If there is
more than one memory range, the isapnp driver will write into the incorrect
configuration register.  I'm in the process of rewritting the configuration
code, but I think it's better to send this now rather than waiting to send
it all at once.

--- a/drivers/pnp/isapnp/core.c	2004-03-14 23:09:29.000000000 +0000
+++ b/drivers/pnp/isapnp/core.c	2004-03-14 23:08:46.000000000 +0000
@@ -1048,7 +1048,7 @@
 	for (tmp = 0; tmp < PNP_MAX_DMA && (res->dma_resource[tmp].flags & (IORESOURCE_DMA | IORESOURCE_UNSET)) == IORESOURCE_DMA; tmp++)
 		isapnp_write_byte(ISAPNP_CFG_DMA+tmp, res->dma_resource[tmp].start);
 	for (tmp = 0; tmp < PNP_MAX_MEM && (res->mem_resource[tmp].flags & (IORESOURCE_MEM | IORESOURCE_UNSET)) == IORESOURCE_MEM; tmp++)
-		isapnp_write_word(ISAPNP_CFG_MEM+(tmp<<2), (res->mem_resource[tmp].start >> 8) & 0xffff);
+		isapnp_write_word(ISAPNP_CFG_MEM+(tmp<<3), (res->mem_resource[tmp].start >> 8) & 0xffff);
 	/* FIXME: We aren't handling 32bit mems properly here */
 	isapnp_activate(dev->number);
 	isapnp_cfg_end();
