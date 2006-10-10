Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbWJJQiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbWJJQiK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 12:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbWJJQiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 12:38:10 -0400
Received: from nic.NetDirect.CA ([216.16.235.2]:39558 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S932197AbWJJQiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 12:38:09 -0400
X-Originating-Ip: 72.57.81.197
Date: Tue, 10 Oct 2006 12:36:25 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Auke Kok <auke-jan.h.kok@intel.com>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       trivial@kernel.org
Subject: Re: [PATCH] ixgb: Delete IXGB_DBG() macro and call pr_debug()
 directly.
In-Reply-To: <452BC6C9.3050902@intel.com>
Message-ID: <Pine.LNX.4.64.0610101227170.9699@localhost.localdomain>
References: <Pine.LNX.4.64.0610100816440.7711@localhost.localdomain>
 <452BC6C9.3050902@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2006, Auke Kok wrote:

> Robert P. J. Day wrote:
> > Delete the minimally-useful IXGB_DBG() macro and call pr_debug()
> > directly from the main routine.
> >
> > Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>
> > ---
> > diff --git a/drivers/net/ixgb/ixgb.h b/drivers/net/ixgb/ixgb.h
> > index 50ffe90..fb9fde5 100644
> > --- a/drivers/net/ixgb/ixgb.h
> > +++ b/drivers/net/ixgb/ixgb.h
> > @@ -77,12 +77,6 @@ #include "ixgb_hw.h"
> >  #include "ixgb_ee.h"
> >  #include "ixgb_ids.h"
> >
> > -#ifdef _DEBUG_DRIVER_
> > -#define IXGB_DBG(args...) printk(KERN_DEBUG "ixgb: " args)
> > -#else
> > -#define IXGB_DBG(args...)
> > -#endif
> > -
> >  #define PFX "ixgb: "
> >  #define DPRINTK(nlevel, klevel, fmt, args...) \
> >  	(void)((NETIF_MSG_##nlevel & adapter->msg_enable) && \
> > diff --git a/drivers/net/ixgb/ixgb_main.c b/drivers/net/ixgb/ixgb_main.c
> > index e09f575..eada685 100644
> > --- a/drivers/net/ixgb/ixgb_main.c
> > +++ b/drivers/net/ixgb/ixgb_main.c
> > @@ -1948,7 +1948,7 @@ #endif
> >
> >  			/* All receives must fit into a single buffer */
> >
> > -			IXGB_DBG("Receive packet consumed multiple buffers "
> > +			pr_debug("ixgb: Receive packet consumed multiple
> > buffers "
> >  					 "length<%x>\n", length);
> >
> >  			dev_kfree_skb_irq(skb);
> >
> > --
> >
> >   all right ... what did i mess up *this* time?  :-)  it's good
> > practice.  that's my story and i'm sticking to it.
>
> We should really use dev_dbg() instead, as it retains the 'ethX:'
> annotation afaics.

i actually tried to use that first, but it wasn't clear to me what i
would use as that first argument to dev_dbg(), given the definitions
in include/linux/device.h:

#define dev_dbg(dev, format, arg...)            \
        dev_printk(KERN_DEBUG , dev , format , ## arg)

#define dev_printk(level, dev, format, arg...)  \
        printk(level "%s %s: " format , dev_driver_string(dev) ,
        (dev)->bus_id , ## arg)

  if someone wants to tell me what, in the context of ixgb_main.c, i
would use as that "dev" argument, i'm all for that.

rday
