Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261966AbSJITUf>; Wed, 9 Oct 2002 15:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262038AbSJITUf>; Wed, 9 Oct 2002 15:20:35 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:23565 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S261966AbSJITUd>;
	Wed, 9 Oct 2002 15:20:33 -0400
Date: Wed, 9 Oct 2002 21:26:13 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: Re: linux kernel conf 0.8
Message-ID: <20021009212613.A12743@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Roman Zippel <zippel@linux-m68k.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	kbuild-devel <kbuild-devel@lists.sourceforge.net>
References: <20021009195531.B1708@mars.ravnborg.org> <Pine.LNX.4.44.0210091141360.14464-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0210091141360.14464-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Oct 09, 2002 at 11:47:16AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2002 at 11:47:16AM -0700, Linus Torvalds wrote:
> 
> On Wed, 9 Oct 2002, Sam Ravnborg wrote:
> > 
> > ls rrunner*
> > should show me not only the implementation [.c + .h] but also
> > the configuration.
> 
> I agree with you, but only if we _always_ have one config file per driver. 
> 
> Which is not necessarily the wrong thing to do. 
The question here is what we aim at.
And we aim at getting the configuration less centralized as compared with
what we have today.
I still remember the thread were you suggested the drivers.conf principle.
And I liked it then, and I like it today.
What I had to add a new driver to the kernel was to add the following
three files:
driver.c, driver,h driver.conf
Even the makefile stuff could be retreived from driver.conf.

> 
> But as long as most drivers are in "grouped" config files, they should be 
> things like "Config.3com" etc.
> 
> Looking at existing big config files (video, networking), they do _not_ 
> group according to driver, but according to other criteria (ie "PCI card", 
> "100/1000 Mbit", "3com", "Sparc-specific" etc).

But there is a good reason why they do it.
Take a look at dirvers/video/Config.in for example.
See the size of the big if's. They span several pages if not the whole file.
Why they do this is simple. Only check for PCI once, and group all
PCI stuff there.
With the syntax Roman propose we see instead that _each_ config option
check for PCI. Which is good IMHO.

The most logical grouping should be utilised, and grouping based on
bustype is not the grouping that we aim for.
We aim to group similar drivers together, if they happens to be for the
same bus or not should not matter.

But the whole argumentation boils down to something rahter simple:
1) Shall we group configuration files together
2) Shall we group related files together

And in mu opinion, if we decide not to use the filesystem namespace to
group similar files, then the incentive to break things out in smaller
files are mostly gone.
Except in the case where I sumbit a new driver and want to keep my
changes to the kernel file to a bare minimum, but then why not
let the config file be grouped with the rest of the driver.

Well I have raised my points, if you still prefer Config.* then let's
stick to that. This should but be the reason to delay lkc-roman.

	Sam
