Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263693AbRFELHu>; Tue, 5 Jun 2001 07:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263730AbRFELHk>; Tue, 5 Jun 2001 07:07:40 -0400
Received: from mail.zmailer.org ([194.252.70.162]:37638 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S263693AbRFELH2>;
	Tue, 5 Jun 2001 07:07:28 -0400
Date: Tue, 5 Jun 2001 14:07:15 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: "Randal, Phil" <prandal@herefordshire.gov.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: TRG vger.timpanogas.org hacked
Message-ID: <20010605140715.M5947@mea-ext.zmailer.org>
In-Reply-To: <AFE36742FF57D411862500508BDE8DD00199501D@mail.herefordshire.gov.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AFE36742FF57D411862500508BDE8DD00199501D@mail.herefordshire.gov.uk>; from prandal@herefordshire.gov.uk on Tue, Jun 05, 2001 at 11:33:57AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2001 at 11:33:57AM +0100, Randal, Phil wrote:
> Bind 8.2.4 was released on May 17th, with the standard
> comment "BIND 8.2.4 is the latest version of ISC BIND 8.
> We strongly recommend that you upgrade to BIND 9.1 or, if
> that is not immediately possible, to BIND 8.2.4 due to
> certain security vulnerabilities in previous versions."
> 
> However, there are no release notes on ISC's web site,
> and their vulnerabilities page lists no known security
> flaws in Bind 8.2.3.

	That's quaint...

	The 8.2.4 got some immunity on running out of low fd numbers 
	suitable for stdio at e.g. Solaris.
	(Is there anything else, I haven't checked.)

	Essentially it makes system a bit more resistant against
	(possibly unintentional) denial of service attacks when
	there are heaps and troves of TCP based resolving connections.

	All you need is to have some zone with so massive replies for
	some questions that it does not fit into UDP query/reply packet.
	E.g. have a few dozen different PTR records for some IP address,
	and you will soon see what I mean.

	Run that bind at some saturated load system so that the bind is
	slow as molass, and have lots of people asking for reversers...
	I can pretty much guarantee that you will see what bind 8.2.3
	barfs within a day or so.  Your only solution is to restart the
	8.2.3.  (It fails to act as resolver after the barf until reboot,
	it may also loose one or more of your DNS zones.)

	I haven't checked if 9.1.* series is also immunized for this.
	(That is, if it uses stdio for any file accesses anymore.)

> But the paranoid part of me does wonder :-)

	What else there might be...

> (And I haven't the time to do the diffs to see what's
> changed.)
> 
> Cheers,
> 
> Phil
> 
> ---------------------------------------------
> Phil Randal
> Network Engineer
> Herefordshire Council
> Hereford, UK 
> 
> > -----Original Message-----
> > From: Daniel Roesen [mailto:dr@bofh.de]
> > Sent: 05 June 2001 11:14
> > To: linux-kernel@vger.kernel.org
> > Subject: Re: TRG vger.timpanogas.org hacked
> > 
> > 
> > On Tue, Jun 05, 2001 at 08:05:34AM +0100, Alan Cox wrote:
> > > > is curious as to how these folks did this.  They 
> > exploited BIND 8.2.3
> > > > to get in and logs indicated that someone was using a 
> > "back door" in 
> > > 
> > > Bind runs as root.
> > 
> > Not if set up properly. And there is no known hole in BIND 8.2.3-REL
> > so I'm wondering how Jeff found out that the intruder got in via BIND.
> > -
> > To unsubscribe from this list: send the line "unsubscribe 
> > linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
