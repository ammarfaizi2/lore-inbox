Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261734AbVCGKP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbVCGKP0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 05:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbVCGKP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 05:15:26 -0500
Received: from news.suse.de ([195.135.220.2]:11669 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261734AbVCGKPR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 05:15:17 -0500
Date: Mon, 7 Mar 2005 11:15:13 +0100
From: Karsten Keil <kkeil@suse.de>
To: isdn4linux@listserv.isdn4linux.de
Cc: linux-kernel@vger.kernel.org, nacc@us.ibm.com
Subject: [kkeil@suse.de: Re: [patch 2/8] isdn/capi: replace interruptible_sleep_on() with wait_event_interruptible()]
Message-ID: <20050307101513.GA11492@pingi3.kke.suse.de>
Mail-Followup-To: isdn4linux@listserv.isdn4linux.de,
	linux-kernel@vger.kernel.org, nacc@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.8-24.10-default i686
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Mar 07, 2005 at 09:35:49AM +0100, Domen Puncer wrote:
> > > -		for (;;) {
> > > -			interruptible_sleep_on(&cdev->recvwait);
> > > -			if ((skb = skb_dequeue(&cdev->recvqueue)) != 0)
> > > -				break;
> > > -			if (signal_pending(current))
> > > -				break;
> > > -		}
> > > +		wait_event_interruptible(cdev->recvwait,
> > > +				((skb = skb_dequeue(&cdev->recvqueue)) == 0));
> > >  		if (skb == 0)
> > >  			return -ERESTARTNOHAND;
> > >  	}
> > 
> > hmm, OK.  Putting an expression with side-effect such as this into a macro
> > which evaluates the expression multiple times is a bit of a worry, but it
> > appears that everything will work OK.
> > 
> > That being said, I'd prefer that this come in via the ISDN team, after
> > having been tested please.
> 
> I believe last update from ISDN team was 13 months ago. :-(

You are wrong. Last update was few weeks ago (not on the core).

> And I concur, testing would be great.

Will do that next week.

-- 
Karsten Keil
SuSE Labs
ISDN development

