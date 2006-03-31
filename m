Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750997AbWCaAfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbWCaAfN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 19:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWCaAfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 19:35:13 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:40338 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750997AbWCaAfL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 19:35:11 -0500
Date: Thu, 30 Mar 2006 18:35:06 -0600
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
Cc: john.ronciak@intel.com, jesse.brandeburg@intel.com,
       jeffrey.t.kirsher@intel.com, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH]: e1000: prevent statistics from getting garbled during reset.
Message-ID: <20060331003506.GU2172@austin.ibm.com>
References: <20060330213928.GQ2172@austin.ibm.com> <20060331000208.GS2172@austin.ibm.com> <442C8069.507@wolfmountaingroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <442C8069.507@wolfmountaingroup.com>
User-Agent: Mutt/1.5.9i
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2006 at 06:05:45PM -0700, Jeff V. Merkey wrote:
> 
> Linas Vepstas wrote:

Well, these comments have nothing to do with my patch, but ... 
anyway ... 

> The driver also needs to be fixed to allow clearing of the stats (like 
> all the other adapter drivers). At present, when I run performance
> and packet drop counts on the cards, I cannot reset the stats with this 
> code because the driver stores them in the e100_adapter
> structure. This is busted.
> 
> This function:
> 
> int clear_network_device_stats(BYTE *name)

I couldn't find such a function in the kernel.
 
> does not work on e1000 due to this section of code:
> 
> void
> e1000_update_stats(struct e1000_adapter *adapter)
> {
> 
> adapter->stats.xofftxc += E1000_READ_REG(hw, XOFFTXC);
> adapter->stats.fcruc += E1000_READ_REG(hw, FCRUC);

These are hardware stats ... presumably useless without
a detailed understanding of the guts of the e1000.

> //NOTE These stats need to be stored in the stats structure so they can 
> be cleared by
> statistics monitoring programs.

I can't imagine what generic interface would allow these 
to be viewed.

> /* Fill out the OS statistics structure */
> 
> adapter->net_stats.rx_packets = adapter->stats.gprc;
> adapter->net_stats.tx_packets = adapter->stats.gptc;
> adapter->net_stats.rx_bytes = adapter->stats.gorcl;
> adapter->net_stats.tx_bytes = adapter->stats.gotcl;

Now *these* are generic ... and fixing this so that the 
stats increment instead of over-riding would take 
maybe half-an-hour or so; this is not hard to do ... !? 

Do you want me to write a patch to do this?

--linas

