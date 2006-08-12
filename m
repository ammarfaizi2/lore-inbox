Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932466AbWHLSQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466AbWHLSQH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 14:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbWHLSQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 14:16:07 -0400
Received: from miranda.se.axis.com ([193.13.178.8]:42701 "EHLO
	miranda.se.axis.com") by vger.kernel.org with ESMTP id S932198AbWHLSQF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 14:16:05 -0400
Date: Sat, 12 Aug 2006 20:16:03 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@axis.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Stephen Hemminger <shemminger@osdl.org>, netdev@vger.kernel.org
Subject: Re: 2.6.18-rc3-mm2 (+ hotfixes): GPF related to skge on suspend
Message-ID: <20060812181603.GA31106@edgar.underground.se.axis.com>
References: <200608121207.42268.rjw@sisk.pl> <200608121631.18603.rjw@sisk.pl> <20060812161253.GA30691@edgar.underground.se.axis.com> <200608121913.01139.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608121913.01139.rjw@sisk.pl>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2006 at 07:13:01PM +0200, Rafael J. Wysocki wrote:
> Apparently it doesn't.

Hi, could you try and see if this helps?

Best regards
-- 
        Programmer
        Edgar E. Iglesias <edgar.iglesias@axis.com> 46.46.272.1946

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@axis.com>

diff --git a/drivers/net/skge.c b/drivers/net/skge.c
index 7de9a07..accefab 100644
--- a/drivers/net/skge.c
+++ b/drivers/net/skge.c
@@ -2211,6 +2211,7 @@ static int skge_up(struct net_device *de
 	skge_write8(hw, Q_ADDR(rxqaddr[port], Q_CSR), CSR_START | CSR_IRQ_CL_F);
 	skge_led(skge, LED_MODE_ON);
 
+	netif_poll_enable(dev);
 	return 0;
 
  free_rx_ring:
@@ -2279,6 +2280,7 @@ static int skge_down(struct net_device *
 
 	skge_led(skge, LED_MODE_OFF);
 
+	netif_poll_disable(dev);	
 	skge_tx_clean(skge);
 	skge_rx_clean(skge);
 

