Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261700AbVGITOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbVGITOT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 15:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbVGITOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 15:14:18 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:29583 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261700AbVGITNa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 15:13:30 -0400
Date: Sat, 9 Jul 2005 21:13:57 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Stelian Pop <stelian@popies.net>,
       Johannes Berg <johannes@sipsolutions.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Frank Arnold <frank@scirocco-5v-turbo.de>
Subject: Re: [PATCH] Apple USB Touchpad driver (new)
Message-ID: <20050709191357.GA2244@ucw.cz>
References: <20050708101731.GM18608@sd291.sivit.org> <1120821481.5065.2.camel@localhost> <20050708121005.GN18608@sd291.sivit.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050708121005.GN18608@sd291.sivit.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2005 at 02:10:05PM +0200, Stelian Pop wrote:
> On Fri, Jul 08, 2005 at 01:18:01PM +0200, Johannes Berg wrote:
> 
> > Hi all,
> > 
> > Nice to see this going into the kernel :)
> > 
> > > This is a driver for the USB touchpad which can be found on
> > > post-February 2005 Apple PowerBooks (PowerBook5,6).
> > 
> > This is not perfectly correct, the PowerBook5,6 is afaik only the 15"
> > model, the 12" and 17" have other numbers. Maybe you should just leave
> > that out, likewise in the code/Kconfig file.
> 
> Indeed, corrected.
> 
> > > +/*
> > > + * number of sensors. Note that only 16 of the 26 x sensors are used on
> > > + * 12" and 15" Powerbooks.
> > > + */
> > 
> > I think that is misleading, those sensors don't even exist on 12" and
> > 15" powerbooks. Maybe it should say 'Note that only 16 instead of 26
> > sensors exist on 12" and 15" models'
> 
> Sure, I clarified a bit that sentence.
> 
> Updated patch follows.

Looks good. If you remove the open counter (the open
callback is called only once for each device), and the

> +module_init (atp_init);
> +module_exit (atp_exit);
 
spaces here, I think I can merge it.

Btw, what I don't completely understand is why you need linear
regression, when you're not trying to detect motion or something like
that. Basic floating average, or even simpler filtering like the input
core uses for fuzz could work well enough I believe.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
