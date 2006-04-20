Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWDTITV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWDTITV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 04:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbWDTITV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 04:19:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33003 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750768AbWDTITU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 04:19:20 -0400
Date: Thu, 20 Apr 2006 01:18:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christian Praehauser <cpraehaus@cosy.sbg.ac.at>
Cc: linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dvb-core: ULE fixes and RFC4326 additions (kernel
 2.6.16)
Message-Id: <20060420011826.453937b1.akpm@osdl.org>
In-Reply-To: <44474282.8050604@cosy.sbg.ac.at>
References: <44465208.5030004@cosy.sbg.ac.at>
	<20060419235349.2b1840c0.akpm@osdl.org>
	<44474282.8050604@cosy.sbg.ac.at>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Praehauser <cpraehaus@cosy.sbg.ac.at> wrote:
>
> +				static const u8 bc_addr[ETH_ALEN] = {0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF};

There's a nicer way:

--- devel/drivers/media/dvb/dvb-core/dvb_net.c~dvb-core-ule-fixes-and-rfc4326-additions-kernel-2616-fix	2006-04-20 01:16:26.000000000 -0700
+++ devel-akpm/drivers/media/dvb/dvb-core/dvb_net.c	2006-04-20 01:17:29.000000000 -0700
@@ -639,7 +639,8 @@ static void dvb_net_ule( struct net_devi
 			} else {
 				/* CRC32 verified OK. */
 				u8 dest_addr[ETH_ALEN];
-				static const u8 bc_addr[ETH_ALEN] = {0xFF,};
+				static const u8 bc_addr[ETH_ALEN] =
+					{ [ 0 ... ETH_ALEN-1] = 0xff };
 
 				/* CRC32 was OK. Remove it from skb. */
 				priv->ule_skb->tail -= 4;
_

