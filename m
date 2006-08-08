Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030289AbWHHVPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030289AbWHHVPl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 17:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030274AbWHHVPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 17:15:40 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:33049 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S1030273AbWHHVPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 17:15:37 -0400
Subject: Re: [RFC][PATCH 3/9] e1000 driver conversion
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Auke Kok <auke-jan.h.kok@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Daniel Phillips <phillips@google.com>,
       Jesse Brandeburg <jesse.brandeburg@intel.com>
In-Reply-To: <44D8F919.7000006@intel.com>
References: <20060808193325.1396.58813.sendpatchset@lappy>
	 <20060808193355.1396.71047.sendpatchset@lappy> <44D8F919.7000006@intel.com>
Content-Type: text/plain
Date: Tue, 08 Aug 2006 22:59:14 +0200
Message-Id: <1155070755.23134.26.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-08 at 13:50 -0700, Auke Kok wrote:
> Peter Zijlstra wrote:
> > Update the driver to make use of the NETIF_F_MEMALLOC feature.
> > 
> > Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> > Signed-off-by: Daniel Phillips <phillips@google.com>
> > 
> > ---
> >  drivers/net/e1000/e1000_main.c |   11 +++++------
> >  1 file changed, 5 insertions(+), 6 deletions(-)
> > 
> > Index: linux-2.6/drivers/net/e1000/e1000_main.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/net/e1000/e1000_main.c
> > +++ linux-2.6/drivers/net/e1000/e1000_main.c
> > @@ -4020,8 +4020,6 @@ e1000_alloc_rx_buffers(struct e1000_adap
> >  		 */
> >  		skb_reserve(skb, NET_IP_ALIGN);
> >  
> > -		skb->dev = netdev;
> > -
> >  		buffer_info->skb = skb;
> >  		buffer_info->length = adapter->rx_buffer_len;
> >  map_skb:
> > @@ -4135,8 +4136,6 @@ e1000_alloc_rx_buffers_ps(struct e1000_a
> >  		 */
> >  		skb_reserve(skb, NET_IP_ALIGN);
> >  
> > -		skb->dev = netdev;
> > -
> >  		buffer_info->skb = skb;
> >  		buffer_info->length = adapter->rx_ps_bsize0;
> >  		buffer_info->dma = pci_map_single(pdev, skb->data,
> > -
> 
> can we really delete these??

The new {,__}netdev_alloc_skb() will set it when the allocation
succeeds.

