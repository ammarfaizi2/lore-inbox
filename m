Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030325AbVLMWmb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030325AbVLMWmb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 17:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030309AbVLMWmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 17:42:31 -0500
Received: from hera.kernel.org ([140.211.167.34]:23772 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1030286AbVLMWma (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 17:42:30 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: 2.6.15-rc5 makes tons of: <NULL>: hw csum failure
Date: Tue, 13 Dec 2005 14:42:21 -0800
Organization: OSDL
Message-ID: <20051213144221.4ac854dd@unknown-222.office.pdx.osdl.net>
References: <E1EmIk7-0004Ua-00@kestrel.astro.umass.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1134513741 2652 10.8.0.222 (13 Dec 2005 22:42:21 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Tue, 13 Dec 2005 22:42:21 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Read list before posting and you will see 4 copies of this patch..

Index: linux-2.6/drivers/net/sk98lin/skge.c
===================================================================
--- linux-2.6.orig/drivers/net/sk98lin/skge.c
+++ linux-2.6/drivers/net/sk98lin/skge.c
@@ -818,7 +818,7 @@ uintptr_t VNextDescr;	/* the virtual bus
 		/* set the pointers right */
 		pDescr->VNextRxd = VNextDescr & 0xffffffffULL;
 		pDescr->pNextRxd = pNextDescr;
-		pDescr->TcpSumStarts = 0;
+		if (!IsTx) pDescr->TcpSumStarts = ETH_HLEN << 16 | ETH_HLEN;
 
 		/* advance one step */
 		pPrevDescr = pDescr;
@@ -2169,7 +2169,7 @@ rx_start:	
 		} /* frame > SK_COPY_TRESHOLD */
 
 #ifdef USE_SK_RX_CHECKSUM
-		pMsg->csum = pRxd->TcpSums;
+		pMsg->csum = pRxd->TcpSums & 0xffff;
 		pMsg->ip_summed = CHECKSUM_HW;
 #else
 		pMsg->ip_summed = CHECKSUM_NONE;

