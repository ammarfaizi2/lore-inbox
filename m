Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbTDUUPh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 16:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261999AbTDUUPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 16:15:37 -0400
Received: from palrel13.hp.com ([156.153.255.238]:7879 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S261994AbTDUUPf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 16:15:35 -0400
Date: Mon, 21 Apr 2003 13:27:28 -0700
To: irda-users@lists.sourceforge.net, Muli Ben-Yehuda <mulix@mulix.org>,
       William Lee Irwin III <wli@holomorphy.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [CHECKER] 6 memory leaks
Message-ID: <20030421202728.GA25358@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote :
>
> On Sat, Apr 19, 2003 at 12:44:45PM +0300, Muli Ben-Yehuda wrote:
> > Index: net/irda/irttp.c
> > ===================================================================
> > RCS file: /home/cvs/linux-2.5/net/irda/irttp.c,v
> > retrieving revision 1.12
> > diff -u -r1.12 irttp.c
> > --- net/irda/irttp.c	25 Feb 2003 05:02:46 -0000	1.12
> > +++ net/irda/irttp.c	19 Apr 2003 08:50:00 -0000
> > @@ -263,7 +263,7 @@
> >  
> >  	IRDA_DEBUG(2, "%s(), rx_sdu_size=%d\n",  __FUNCTION__,
> >  		   self->rx_sdu_size);
> > -	ASSERT(n <= self->rx_sdu_size, return NULL;);
> > +	ASSERT(n <= self->rx_sdu_size, {dev_kfree_skb(skb); return NULL;});
> >  
> >  	/* Set the new length */
> >  	skb_trim(skb, n);

	Thanks for the heads up. I'm preparing a massive skb leak
patch for 2.5.X, I'll slip that into it. I'll probably code that
differently so that it looks "cleaner".
	By the way, this is not terribly important, as if ASSERT do
trigger we usually have bigger problems than memory leaks (like you
may want to reboot rather sooner than later).

> I'm in terror. ASSERT()? return NULL in a macro argument?
> Any chance of cleaning that up a bit while you're at it?
> 
> -- wli

	Rather than fixing imaginary non-existing bugs, I prefer to
spend my time fixing real bugs that byte real users. This construct is
perfectly sound and valid, and it needs to be done in this way, the
only issue is that someone should rename "ASSERT" into "IRDA_ASSERT".

	Have fun...

	Jean
