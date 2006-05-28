Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbWE1QCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWE1QCq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 12:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbWE1QCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 12:02:46 -0400
Received: from 2-1-3-15a.ens.sth.bostream.se ([82.182.31.214]:28832 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id S1750780AbWE1QCp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 12:02:45 -0400
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Christer Weinigel <christer@weinigel.se>, Nathan Laredo <laredo@gnu.org>,
       linux-kernel@vger.kernel.org, video4linux-list@redhat.com
Subject: Re: Stradis driver conflicts with all other SAA7146 drivers
References: <m3wtc6ib0v.fsf@zoo.weinigel.se> <44799D24.7050301@gmail.com>
From: Christer Weinigel <christer@weinigel.se>
Organization: Weinigel Ingenjorsbyra AB
Date: 28 May 2006 18:02:44 +0200
In-Reply-To: <44799D24.7050301@gmail.com>
Message-ID: <m3slmui1cr.fsf@zoo.weinigel.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby <jirislaby@gmail.com> writes:

> Christer Weinigel napsal(a):
> > Hi,
> > 
> > [Nathan Laredo is the maintainer of the stradis driver but Jiri Slaby
> > submitted the PCI probing change that went into 2.6.16 so I'm Cc-ing
> > him too.  I'm not a member of the video4linux mailing list so please
> > Cc me on any responses.]
> > 
> > The stradis driver in the 2.6.16 kernel only looks at the SAA7146
> > vendor and product ID and binds to any SAA7146 based device even if it
> > is not a stradis card.  This stops all other SAA7146 drivers from
> > working, for example my WinTV Nova-T card using the budget-ci driver
> > doesn't work any longer.  A lot of other people have also been bitten
> > by this.

> The only difference is in order of searching for devices. Stradis now gets
> control before your "real" driver. Kick stradis from your config or blacklist
> it. Or, why you ever load module, you don't want to use?
> There is no change in searching devices, it didn't check for subvendors before
> not even now. If Nathan knows, there are some subvendor/subdevices ids, which we
> should compare to, then yes, we can change the behaviour, otherwise, I am
> afraid, we can't. It's vendors' problem, that they don't use this pci registers
> (and it's evil) -- i think, that stradis cards have that two zeroed.

I'm running the stock Fedora Core 5 kernels, and for some reason the
stradis driver is loaded.  I suppose there's some magic in the FC5
hotplug scripts that tries to load all device drivers that claim to
support a certain PCI device.

I have blacklisted the stradis driver on my system, which fixes it for
me, but it does feels as a workaround for a problem that ought to be
fixed in the driver.  If the card doesn't have a subvendor/subdevice,
is there some way of doing a sanity check on the board to see if it
actually is a stradis card and then release the board if it isn't?

If the driver isn't fixed I'll file a bug report on the Fedora
bugzilla asking them to blacklist or just not compile that driver.

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
