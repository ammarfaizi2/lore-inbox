Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbVALPtj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbVALPtj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 10:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbVALPtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 10:49:39 -0500
Received: from john.hrz.tu-chemnitz.de ([134.109.132.2]:52902 "EHLO
	john.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S261231AbVALPtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 10:49:32 -0500
Date: Wed, 12 Jan 2005 16:49:29 +0100
From: Steffen Klassert <klassert@mathematik.tu-chemnitz.de>
To: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 3c59x: support more ethtool_ops
Message-ID: <20050112154929.GA2738@gareth.mathematik.tu-chemnitz.de>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200501111913.j0BJDnIL009341@hera.kernel.org> <41E42C38.1090903@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E42C38.1090903@pobox.com>
User-Agent: Mutt/1.4.2.1i
X-Spam-Score: -2.8 (--)
X-Spam-Report: --- Start der SpamAssassin 3.0.1 Textanalyse (-2.8 Punkte)
	Fragen an/questions to:  Postmaster TU Chemnitz <postmaster@tu-chemnitz.de>
	-2.8 ALL_TRUSTED            Nachricht wurde nur ueber vertrauenswuerdige Rechner weitergeleitet
	--- Ende der SpamAssassin Textanalyse
X-Scan-Signature: cb5add96829c288e5da73fa3a8e2275c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2005 at 02:42:48PM -0500, Jeff Garzik wrote:
> Linux Kernel Mailing List wrote:
> >+static void vortex_get_ethtool_stats(struct net_device *dev,
> >+	struct ethtool_stats *stats, u64 *data)
> >+{
> >+	struct vortex_private *vp = netdev_priv(dev);
> >+	unsigned long flags;
> >+
> >+	spin_lock_irqsave(&vp->lock, flags);
> >+	update_stats(dev->base_addr, dev);
> >+	spin_unlock_irqrestore(&vp->lock, flags);
> >+
> >+	data[0] = vp->stats.rx_packets;
> >+	data[1] = vp->stats.tx_packets;
> >+	data[2] = vp->stats.rx_bytes;
> >+	data[3] = vp->stats.tx_bytes;
> >+	data[4] = vp->stats.collisions;
> >+	data[5] = vp->stats.tx_carrier_errors;
> >+	data[6] = vp->stats.tx_heartbeat_errors;
> >+	data[7] = vp->stats.tx_window_errors;
> >+}
> 
> Everything in the patch is correct except for the above.
> 
> This is very wrong -- get_ethtool_stats() is for NIC-specific stats. 
> The above stats are already available through the generic net stack.
> 

When I did this I took the e100 driver as an example, here get_ethtool_stats()
provides the generic and the NIC specific stats. Thus I added all in vp->stats
counted stats (in this case just the generic) to get_ethtool_stats().   

But anyway, I will rework this part. 
What is the expected behavior of get_ethtool_stats()?
Provide just the NIC specific stats or all stats as the e100 driver does it?

	Steffen
