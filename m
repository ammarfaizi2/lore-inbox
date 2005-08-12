Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbVHLTSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbVHLTSn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 15:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbVHLTSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 15:18:43 -0400
Received: from waste.org ([216.27.176.166]:58249 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1751253AbVHLTSm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 15:18:42 -0400
Date: Fri, 12 Aug 2005 12:17:52 -0700
From: Matt Mackall <mpm@selenic.com>
To: John Ronciak <john.ronciak@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@davemloft.net>,
       ak@suse.de, Jeff Moyer <jmoyer@redhat.com>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org, mingo@elte.hu, john.ronciak@intel.com,
       rostedt@goodmis.org
Subject: Re: [PATCH 3/8] netpoll: e1000 netpoll tweak
Message-ID: <20050812191752.GI12284@waste.org>
References: <3.502409567@selenic.com> <4.502409567@selenic.com> <56a8daef0508121202172bcd17@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56a8daef0508121202172bcd17@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[corrected akpm's address]

On Fri, Aug 12, 2005 at 12:02:03PM -0700, John Ronciak wrote:
> Sorry this reply was to go to the whole list but only made it to Matt.
> 
> The e1000_intr() routine already calls e1000_clean_tx_irq().  So
> what's the point of this patch?  Am I missing something?

Here is Steven's original analysis:

http://lkml.org/lkml/2005/8/5/116

It looked plausible, but I didn't dig much deeper.

> > Index: l/drivers/net/e1000/e1000_main.c
> > ===================================================================
> > --- l.orig/drivers/net/e1000/e1000_main.c       2005-08-06 17:36:32.000000000 -0500
> > +++ l/drivers/net/e1000/e1000_main.c    2005-08-06 17:55:01.000000000 -0500
> > @@ -3789,6 +3789,7 @@ e1000_netpoll(struct net_device *netdev)
> >         struct e1000_adapter *adapter = netdev_priv(netdev);
> >         disable_irq(adapter->pdev->irq);
> >         e1000_intr(adapter->pdev->irq, netdev, NULL);
> > +       e1000_clean_tx_irq(adapter);
> >         enable_irq(adapter->pdev->irq);
> >  }
> >  #endif

-- 
Mathematics is the supreme nostalgia of our time.
