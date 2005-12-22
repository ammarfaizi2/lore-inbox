Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbVLVDvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbVLVDvH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 22:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbVLVDvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 22:51:07 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:38272
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751198AbVLVDvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 22:51:06 -0500
Date: Wed, 21 Dec 2005 19:51:07 -0800 (PST)
Message-Id: <20051221.195107.113618698.davem@davemloft.net>
To: shemminger@osdl.org
Cc: mikukkon@iki.fi, bridge@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BRIDGE: Fix faulty check in
 br_stp_recalculate_bridge_id()
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051221132527.1ef12bcf@dxpl.pdx.osdl.net>
References: <20051221195527.GA24213@localhost.localdomain>
	<20051221132527.1ef12bcf@dxpl.pdx.osdl.net>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Hemminger <shemminger@osdl.org>
Date: Wed, 21 Dec 2005 13:25:27 -0800

> On Wed, 21 Dec 2005 21:55:27 +0200
> mikukkon@iki.fi wrote:
> 
> > I did a compile with extra gcc warnings, and found a bug in
> > net/bridge/br_stp_if.c function br_stp_recalculate_bridge_id():
> > compare_ether_addr() returns 0 if match, positive if not, so
> > checking it for negative is wrong. 
> > 
> > Signed-of-by: Mika Kukkonen <mikukkon@iki.fi>
 ...
> > diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
> > index ac09b6a..08c52c2 100644
> > --- a/net/bridge/br_stp_if.c
> > +++ b/net/bridge/br_stp_if.c
> > @@ -158,7 +158,7 @@ void br_stp_recalculate_bridge_id(struct
> >  
> >  	list_for_each_entry(p, &br->port_list, list) {
> >  		if (addr == br_mac_zero ||
> > -		    compare_ether_addr(p->dev->dev_addr, addr) < 0)
> > +		    compare_ether_addr(p->dev->dev_addr, addr))
> >  			addr = p->dev->dev_addr;
> >  
> >  	}
> 
> Actually that compare_ether_addr needs to be replaced by memcmp again.
> Because for bridge id calc it wants the min() of all the device addresses.

I'll hold on this patch until that is worked out.

Thanks.
