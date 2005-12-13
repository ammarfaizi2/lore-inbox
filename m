Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751288AbVLMUBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbVLMUBT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 15:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbVLMUBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 15:01:18 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:37390 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751288AbVLMUBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 15:01:17 -0500
Date: Tue, 13 Dec 2005 20:01:06 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Simon Richter <Simon.Richter@hogyros.de>, linux-kernel@vger.kernel.org,
       tony.luck@intel.com, linux-ia64@vger.kernel.org, matthew@wil.cx,
       grundler@parisc-linux.org, parisc-linux@parisc-linux.org,
       paulus@samba.org, linuxppc-dev@ozlabs.org, lethal@linux-sh.org,
       kkojima@rr.iij4u.or.jp, dwmw2@infradead.org,
       linux-mtd@lists.infradead.org
Subject: Re: [2.6 patch] don't allow users to set CONFIG_BROKEN=y
Message-ID: <20051213200106.GC24094@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	Simon Richter <Simon.Richter@hogyros.de>,
	linux-kernel@vger.kernel.org, tony.luck@intel.com,
	linux-ia64@vger.kernel.org, matthew@wil.cx,
	grundler@parisc-linux.org, parisc-linux@parisc-linux.org,
	paulus@samba.org, linuxppc-dev@ozlabs.org, lethal@linux-sh.org,
	kkojima@rr.iij4u.or.jp, dwmw2@infradead.org,
	linux-mtd@lists.infradead.org
References: <20051211185212.GQ23349@stusta.de> <20051211192109.GA22537@flint.arm.linux.org.uk> <20051211193118.GR23349@stusta.de> <20051211194437.GB22537@flint.arm.linux.org.uk> <20051213001028.GS23349@stusta.de> <439ECDCC.80707@hogyros.de> <20051213140001.GG23349@stusta.de> <20051213173112.GA24094@flint.arm.linux.org.uk> <20051213180551.GN23349@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213180551.GN23349@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2005 at 07:05:52PM +0100, Adrian Bunk wrote:
> On Tue, Dec 13, 2005 at 05:31:12PM +0000, Russell King wrote:
> > The defconfig files in arch/arm/configs are for platform configurations
> > and are provided by the platform maintainers as a _working_ configuration
> > for their platform.  They're not "defconfigs".  They got called
> > "defconfigs" as a result of the kbuild "cleanups".  Please don't confuse
> > them as such.
> > 
> > If, in order to have a working platform configuration, they deem that
> > CONFIG_BROKEN must be enabled, then that's the way it is.
> 
> if a working platform configuration configuration requires 
> CONFIG_BROKEN=y, the problem is a bug that should be fixed properly.

Maybe they're only broken for a small subset of platforms, and someone
added a BROKEN without properly considering whether it should be global
or not?

I don't disagree with the overall notion that CONFIG_BROKEN should not
be set _where_ _possible_.  However, if it needs to be set to get the
required options, then that's what needs to happen until such time that
the above is corrected.

However - and now to the main bug bear - how can we tell what is really
broken if you _just_ change the default configuration file settings for
CONFIG_BROKEN?  What happens is that, on review, we see a simple change.
We'd assume that it has little impact, and we accept that change.

Maybe a month or two down the line, someone whines that their platform
doesn't work for some reason, and it's tracked down to this and the
resulting fallout from disabling CONFIG_BROKEN.

That means that the original review was _worthless_.  It wasn't a
review at all.

So, what I am trying to get across is the need to show the _full_ set
of changes to a default configuratoin when you disable CONFIG_BROKEN,
which is trivially producable if you run the script I've already posted.

You can even use that in conjunction with your present patch to produce
a patch which shows _exactly_ _everything_ which changes as a result of
disabling CONFIG_BROKEN.  Surely giving reviewers the _full_ story is
far better than half a story, and should be something that any change
to the kernel strives for.

If not, what's the point of the original change?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
