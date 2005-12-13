Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030220AbVLMUTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030220AbVLMUTV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 15:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030224AbVLMUTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 15:19:21 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:31504 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030212AbVLMUTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 15:19:20 -0500
Date: Tue, 13 Dec 2005 21:19:20 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Simon Richter <Simon.Richter@hogyros.de>, linux-kernel@vger.kernel.org,
       tony.luck@intel.com, linux-ia64@vger.kernel.org, matthew@wil.cx,
       grundler@parisc-linux.org, parisc-linux@parisc-linux.org,
       paulus@samba.org, linuxppc-dev@ozlabs.org, lethal@linux-sh.org,
       kkojima@rr.iij4u.or.jp, dwmw2@infradead.org,
       linux-mtd@lists.infradead.org
Subject: Re: [2.6 patch] don't allow users to set CONFIG_BROKEN=y
Message-ID: <20051213201920.GT23349@stusta.de>
References: <20051211185212.GQ23349@stusta.de> <20051211192109.GA22537@flint.arm.linux.org.uk> <20051211193118.GR23349@stusta.de> <20051211194437.GB22537@flint.arm.linux.org.uk> <20051213001028.GS23349@stusta.de> <439ECDCC.80707@hogyros.de> <20051213140001.GG23349@stusta.de> <20051213173112.GA24094@flint.arm.linux.org.uk> <20051213180551.GN23349@stusta.de> <20051213200106.GC24094@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213200106.GC24094@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2005 at 08:01:06PM +0000, Russell King wrote:
> On Tue, Dec 13, 2005 at 07:05:52PM +0100, Adrian Bunk wrote:
> > On Tue, Dec 13, 2005 at 05:31:12PM +0000, Russell King wrote:
> > > The defconfig files in arch/arm/configs are for platform configurations
> > > and are provided by the platform maintainers as a _working_ configuration
> > > for their platform.  They're not "defconfigs".  They got called
> > > "defconfigs" as a result of the kbuild "cleanups".  Please don't confuse
> > > them as such.
> > > 
> > > If, in order to have a working platform configuration, they deem that
> > > CONFIG_BROKEN must be enabled, then that's the way it is.
> > 
> > if a working platform configuration configuration requires 
> > CONFIG_BROKEN=y, the problem is a bug that should be fixed properly.
> 
> Maybe they're only broken for a small subset of platforms, and someone
> added a BROKEN without properly considering whether it should be global
> or not?
> 
> I don't disagree with the overall notion that CONFIG_BROKEN should not
> be set _where_ _possible_.  However, if it needs to be set to get the
> required options, then that's what needs to happen until such time that
> the above is corrected.

Where is the bug report from the person who set CONFIG_BROKEN=y in the 
collie defconfig that the BROKEN dependency on MTD_SHARP was wrong?

> However - and now to the main bug bear - how can we tell what is really
> broken if you _just_ change the default configuration file settings for
> CONFIG_BROKEN?  What happens is that, on review, we see a simple change.
> We'd assume that it has little impact, and we accept that change.
> 
> Maybe a month or two down the line, someone whines that their platform
> doesn't work for some reason, and it's tracked down to this and the
> resulting fallout from disabling CONFIG_BROKEN.

The whining is the bug report the person who set the CONFIG_BROKEN=y in 
the defconfig didn't send.

And things would have been even worse if I had sent a patch erasing 
MTD_SHARP from the kernel because code "both marked as obsolete and 
BROKEN can clearly be removed" and the code was therefore completely 
removed two months before the first person whined?

> That means that the original review was _worthless_.  It wasn't a
> review at all.
> 
> So, what I am trying to get across is the need to show the _full_ set
> of changes to a default configuratoin when you disable CONFIG_BROKEN,
> which is trivially producable if you run the script I've already posted.
> 
> You can even use that in conjunction with your present patch to produce
> a patch which shows _exactly_ _everything_ which changes as a result of
> disabling CONFIG_BROKEN.  Surely giving reviewers the _full_ story is
> far better than half a story, and should be something that any change
> to the kernel strives for.
> 
> If not, what's the point of the original change?

The point is that I haven't yet heard any good reason for 
CONFIG_BROKEN=y in a defconfig.

No, it's not a good reason if someone used it as a workaround instead of 
sending a bug report that would result in a fixing of the wrong BROKEN 
dependency.

Where is the bug report of the person setting CONFIG_BROKEN=y in the 
collie defconfig that the MTD_SHARP dependency on BROKEN was wrong?

> Russell King

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

