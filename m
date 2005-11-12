Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbVKLJN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbVKLJN3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 04:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbVKLJN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 04:13:27 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:3757 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932208AbVKLJN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 04:13:26 -0500
Subject: Re: 3D video card recommendations
From: Lee Revell <rlrevell@joe-job.com>
To: Mark Knecht <markknecht@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Gerhard Mack <gmack@innerfire.net>,
       LKML <linux-kernel@vger.kernel.org>,
       Xavier Bestel <xavier.bestel@free.fr>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Hugo Mills <hugo-lkml@carfax.org.uk>, Nix <nix@esperi.org.uk>,
       Anshuman Gholap <anshu.pg@gmail.com>, Diego Calleja <diegocg@gmail.com>,
       Toon van der Pas <toon@hout.vanvergehaald.nl>, arjan@infradead.org
In-Reply-To: <5bdc1c8b0511071123h4a1d0da7rcae0548c2c55afb3@mail.gmail.com>
References: <1131112605.14381.34.camel@localhost.localdomain>
	 <1131349343.2858.11.camel@laptopd505.fenrus.org>
	 <1131367371.14381.91.camel@localhost.localdomain>
	 <20051107152009.GA20807@shuttle.vanvergehaald.nl>
	 <20051107180045.ec86a7f2.diegocg@gmail.com>
	 <1131384624.14381.106.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0511071243350.9444@innerfire.net>
	 <1131386032.14381.110.camel@localhost.localdomain>
	 <5bdc1c8b0511071001s2d990e72s812c195d5614a894@mail.gmail.com>
	 <1131390332.8383.83.camel@mindpipe>
	 <5bdc1c8b0511071123h4a1d0da7rcae0548c2c55afb3@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 12 Nov 2005 04:11:40 -0500
Message-Id: <1131786700.13373.37.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-07 at 11:23 -0800, Mark Knecht wrote:
> On 11/7/05, Lee Revell <rlrevell@joe-job.com> wrote:
> >
> > Um, didn't you say you were still getting audio underruns correlated
> > with display activity?  I still think it's a bug in the Xorg radeon
> > driver.
> >
> > Lee
> 
> Hi Lee,
>    It very well could be a video issue causing my xruns. That's been
> the biggest, but not olny,  factor, but I don't know any more. I've
> gone down so many paths that haven't yielded results.
> 
>    I've tried the NoAccel and RenderAccel experiments you suggested.
> You also mentioned not loading DRI which I guess isn't possible anyway
> with a PCI-Express card. Anyway, I don't have it loaded.
> 
>    While I do get xruns, they are happening lately only a couple of
> times a day, and usually very late in the day after the machine has
> been running for 12+ hours. If I pull Jack back to 256/2 then I don't
> think I get them at all so I'm living with it for now and hoping for a
> solution one of these days. Low latency really only matters to me when
> recording which is <5% of the time.

After looking at the Radeon driver I'm increasingly convinced that it's
causing your problems.

Please try disabling Xscreensaver and see if the xruns go away - looking
at radeonfb it seems like the xruns could be triggered by video mode
switching, there are lots of places where it loops waiting for the
hardware to be ready.  If that eliminates them I have a patch you can
try.

Lee

