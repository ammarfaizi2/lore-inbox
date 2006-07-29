Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbWG2VrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbWG2VrZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 17:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbWG2VrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 17:47:25 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:39953 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S932167AbWG2VrY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 17:47:24 -0400
Date: Sat, 29 Jul 2006 17:43:34 -0400
From: Neil Horman <nhorman@tuxdriver.com>
To: Bill Huey <billh@gnuppy.monkey.org>
Cc: Jim Gettys <jg@laptop.org>, "H. Peter Anvin" <hpa@zytor.com>,
       Dave Airlie <airlied@gmail.com>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, a.zummo@towertech.it, jg@freedesktop.org,
       Keith Packard <keithp@keithp.com>
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
Message-ID: <20060729214334.GA8624@localhost.localdomain>
References: <44C67E1A.7050105@zytor.com> <20060725204736.GK4608@hmsreliant.homelinux.net> <1153861094.1230.20.camel@localhost.localdomain> <44C6875F.4090300@zytor.com> <1153862087.1230.38.camel@localhost.localdomain> <44C68AA8.6080702@zytor.com> <1153863542.1230.41.camel@localhost.localdomain> <20060729042820.GA16133@gnuppy.monkey.org> <20060729125427.GA6669@localhost.localdomain> <20060729204107.GA20890@gnuppy.monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060729204107.GA20890@gnuppy.monkey.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2006 at 01:41:07PM -0700, Bill Huey wrote:
> On Sat, Jul 29, 2006 at 08:54:27AM -0400, Neil Horman wrote:
> > On Fri, Jul 28, 2006 at 09:28:20PM -0700, Bill Huey wrote:
> > > Not to poop on people's parade, but the last time I looked /dev/rtc was
> > > a single instance device, right ? If this reasoning is true, then mplayer
> > > and other apps that want to open it can't.
> > > 
> > > What's the story with this ?
> > > 
> > Its always been the case.  Its hardware can only support one timer (or at least
> > one timer period), and as such multiple users would interefere with each other.
> 
> Well, this points out a serious problem with doing an mmap extension to
> /dev/rtc. It would be better to have a page mapped by another device like
Not really.  The rtc driver can only have a single user regardless of weather or
not it has an mmap interface.  using mmap just provides another mothod for
accessing the rtc.

> /dev/jiffy_counter, or something like that rather than to overload the
> /dev/rtc with that functionality. The semantic for this change is shadey
> in the first place so you should consider that option. It basically means
> that, if Xorg, adopts this interface, no userspace applications can get at
> and use the 'rtc' for any existing purposes with X running (mplayer and
> friends).
> 
> It's not a really usable interface for Keith's purposes because of this
> and it is a serious problem. You might want to consider writting special
I think that was the consensus quite some time ago. :).
 
> device to do this like I mentioned above instead of mmap extension to
> 'rtc'.
Sure, an mmaped jiffy counter would certainly be usefull.  I think the only
thing left to be determined in this thread is if adding mmap to the rtc driver
has any merit regardless of any potential users (iow, would current users of
/dev/rtc find it helpful to have the rtc driver provide an mmap interface.)

Regards
Neil

> 
> bill
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
