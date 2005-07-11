Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261629AbVGKLLW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbVGKLLW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 07:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261633AbVGKLLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 07:11:22 -0400
Received: from gw.alcove.fr ([81.80.245.157]:25271 "EHLO smtp.fr.alcove.com")
	by vger.kernel.org with ESMTP id S261629AbVGKLLT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 07:11:19 -0400
Subject: Re: [PATCH] Apple USB Touchpad driver (new)
From: Stelian Pop <stelian@popies.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Peter Osterlund <petero2@telia.com>, Andrew Morton <akpm@osdl.org>,
       Johannes Berg <johannes@sipsolutions.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Frank Arnold <frank@scirocco-5v-turbo.de>
In-Reply-To: <20050711110024.GA23333@ucw.cz>
References: <20050708101731.GM18608@sd291.sivit.org>
	 <1120821481.5065.2.camel@localhost>
	 <20050708121005.GN18608@sd291.sivit.org> <20050709191357.GA2244@ucw.cz>
	 <m33bqnr3y9.fsf@telia.com> <20050710120425.GC3018@ucw.cz>
	 <m3y88e9ozu.fsf@telia.com>
	 <1121078371.12621.36.camel@localhost.localdomain>
	 <20050711110024.GA23333@ucw.cz>
Content-Type: text/plain; charset=utf-8
Date: Mon, 11 Jul 2005 13:08:35 +0200
Message-Id: <1121080115.12627.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 11 juillet 2005 à 13:00 +0200, Vojtech Pavlik a écrit :
> On Mon, Jul 11, 2005 at 12:39:31PM +0200, Stelian Pop wrote:
>  
> > > > Using a function like
> > > > 
> > > > 	return (x_old * 3 + x) / 4;
> > > > 
> > > > eliminates the need for a FIFO, and has similar (if not better)
> > > > properties to floating average, because its coefficients are
> > > > [ .25 .18 .14 .10 ... ].
> > > 
> > > Agreed.
> > 
> > Except that this does not work well enough.
> 
> I guess the quick motion compensation in input bites you. The above
> equation should do even more smoothing than regular 4-point floating
> average.

Possible. The 'fuzz' parameter in input core serves too many usages
ihmo. Let me try removing the quick motion compensation and see...

> > I already thought about this, one problem is that the sensors do not
> > report the pressure but only the amount of surface touched. A person
> > with thick fingers will always generate higher pressures then one with
> > thin ones, no matter how hard they push on the touchpad.
> 
> That's what all other touchpads do.

I thought the hardware is capable of calculating real pressure...

> > I don't think this value is reliable enough to be reported to the
> > userspace as ABS_PRESSURE...
> 
> I believe it'd still be more useful than a two-value (0 and 100) output.

Ok, I'll do it.

> > +			/*
> > +			 * in the future, we could add here code to search for
> > +			 * a second finger...
> > +			 * for now, scrolling using the synaptics X driver is
> > +			 * much more simpler to achieve.
> > +			 */
> 
> This could be quite useful, too, for right and middle button taps (2 and
> 3 fingers) - since the Macs lack these buttons.

Indeed. But this can be a later improvement, let's make one finger work
for now :)

Stelian.
-- 
Stelian Pop <stelian@popies.net>

