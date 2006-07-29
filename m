Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932199AbWG2Ulf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbWG2Ulf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 16:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbWG2Ulf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 16:41:35 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:22407
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S932199AbWG2Ulf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 16:41:35 -0400
Date: Sat, 29 Jul 2006 13:41:07 -0700
To: Neil Horman <nhorman@tuxdriver.com>
Cc: Jim Gettys <jg@laptop.org>, "H. Peter Anvin" <hpa@zytor.com>,
       Dave Airlie <airlied@gmail.com>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, a.zummo@towertech.it, jg@freedesktop.org,
       Keith Packard <keithp@keithp.com>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
Message-ID: <20060729204107.GA20890@gnuppy.monkey.org>
References: <21d7e9970607251304n5681bf44gc751c21fd79be99d@mail.gmail.com> <44C67E1A.7050105@zytor.com> <20060725204736.GK4608@hmsreliant.homelinux.net> <1153861094.1230.20.camel@localhost.localdomain> <44C6875F.4090300@zytor.com> <1153862087.1230.38.camel@localhost.localdomain> <44C68AA8.6080702@zytor.com> <1153863542.1230.41.camel@localhost.localdomain> <20060729042820.GA16133@gnuppy.monkey.org> <20060729125427.GA6669@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060729125427.GA6669@localhost.localdomain>
User-Agent: Mutt/1.5.11+cvs20060403
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2006 at 08:54:27AM -0400, Neil Horman wrote:
> On Fri, Jul 28, 2006 at 09:28:20PM -0700, Bill Huey wrote:
> > Not to poop on people's parade, but the last time I looked /dev/rtc was
> > a single instance device, right ? If this reasoning is true, then mplayer
> > and other apps that want to open it can't.
> > 
> > What's the story with this ?
> > 
> Its always been the case.  Its hardware can only support one timer (or at least
> one timer period), and as such multiple users would interefere with each other.

Well, this points out a serious problem with doing an mmap extension to
/dev/rtc. It would be better to have a page mapped by another device like
/dev/jiffy_counter, or something like that rather than to overload the
/dev/rtc with that functionality. The semantic for this change is shadey
in the first place so you should consider that option. It basically means
that, if Xorg, adopts this interface, no userspace applications can get at
and use the 'rtc' for any existing purposes with X running (mplayer and
friends).

It's not a really usable interface for Keith's purposes because of this
and it is a serious problem. You might want to consider writting special
device to do this like I mentioned above instead of mmap extension to
'rtc'.

bill

