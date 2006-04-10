Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbWDJP0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbWDJP0w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 11:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbWDJP0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 11:26:52 -0400
Received: from ns1.idleaire.net ([65.220.16.2]:30638 "EHLO iasrv1.idleaire.net")
	by vger.kernel.org with ESMTP id S1750839AbWDJP0v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 11:26:51 -0400
Subject: Re: [PATCH] deinline a few large functions in vlan code v2
From: Dave Dillow <dave@thedillows.org>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, jgarzik@pobox.com
In-Reply-To: <200604101716.58463.vda@ilport.com.ua>
References: <200604071628.30486.vda@ilport.com.ua>
	 <200604100828.20994.vda@ilport.com.ua>
	 <20060409.224559.124326025.davem@davemloft.net>
	 <200604101716.58463.vda@ilport.com.ua>
Content-Type: text/plain
Date: Mon, 10 Apr 2006 11:26:46 -0400
Message-Id: <1144682807.12177.22.camel@dillow.idleaire.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Apr 2006 15:26:14.0435 (UTC) FILETIME=[1AC04F30:01C65CB3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-10 at 17:16 +0300, Denis Vlasenko wrote:
> On Monday 10 April 2006 08:45, David S. Miller wrote:
> > From: Denis Vlasenko <vda@ilport.com.ua>
> > Date: Mon, 10 Apr 2006 08:28:20 +0300
> > 
> > > IOW: shouldn't calls to these functions sit in
> > > #if defined(CONFIG_VLAN_8021Q) || defined (CONFIG_VLAN_8021Q_MODULE)
> > > block? For example, typhoon.c:
> > > 
> > >                 spin_lock(&tp->state_lock);
> > > +#if defined(CONFIG_VLAN_8021Q) || defined (CONFIG_VLAN_8021Q_MODULE)
> > >                 if(tp->vlgrp != NULL && rx->rxStatus & TYPHOON_RX_VLAN)
> > >                         vlan_hwaccel_receive_skb(new_skb, tp->vlgrp,
> > >                                                  ntohl(rx->vlanTag) & 0xffff);
> > >                 else
> > > +#endif
> > >                         netif_receive_skb(new_skb);
> > >                 spin_unlock(&tp->state_lock);
> > > 
> > > Same for s2io.c, chelsio/sge.c, etc...
> > 
> > Very likely yes.  tp->vlgrp will never be non-NULL in such situations
> > so it's not a correctness issue, but rather an optimization :-)
> 
> Done. Please see attached.

I see this as a minor optimization, at the cost uglifying the body of a
function. Besides, if you're going to do this, you can get rid of the
spin_lock functions around it to, since they only protect tp->vlgrp in
this instance.

Please don't apply this to typhoon.c
-- 
Dave Dillow <dave@thedillows.org>

