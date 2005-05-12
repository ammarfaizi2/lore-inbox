Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbVELLaD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbVELLaD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 07:30:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261461AbVELLaD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 07:30:03 -0400
Received: from ozlabs.org ([203.10.76.45]:52367 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261443AbVELL37 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 07:29:59 -0400
Date: Thu, 12 May 2005 21:28:57 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Michael Ellerman <michael@ellerman.id.au>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       PPC64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH 4/4] iseries_veth: Cleanup skbs to prevent unregister_netdevice() hanging
Message-ID: <20050512112857.GC32694@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Michael Ellerman <michael@ellerman.id.au>,
	Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
	netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
	PPC64-dev <linuxppc64-dev@ozlabs.org>
References: <200505121809.45419.michael@ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505121809.45419.michael@ellerman.id.au>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2005 at 06:09:45PM +1000, Michael Ellerman wrote:
> Hi Andrew, Jeff,
> 
> The iseries_veth driver is badly behaved in that it will keep TX packets
> hanging around forever if they're not ACK'ed and the queue never fills up.
> 
> This causes the unregister_netdevice code to wait forever when we try to take
> the device down, because there's still skbs around with references to our
> struct net_device.
> 
> There's already code to cleanup any un-ACK'ed packets in veth_stop_connection()
> but it's being called after we unregister the net_device, which is too late.
> 
> The fix is to rearrange the module exit function so that we cleanup any
> outstanding skbs and then unregister the driver.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Nice catch.

Acked-by: David Gibson <david@gibson.dropbear.id.au>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/people/dgibson
