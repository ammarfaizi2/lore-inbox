Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261837AbVASSmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbVASSmi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 13:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbVASSmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 13:42:38 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:59561 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261837AbVASSme (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 13:42:34 -0500
Subject: Re: [kbuild 2/5] Dont use the running kernels config file by
	default
From: Andreas Gruenbacher <agruen@suse.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>, Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <Pine.LNX.4.61.0501191858060.30794@scrub.home>
References: <20050118184123.729034000.suse.de>
	 <20050118192608.423265000.suse.de>
	 <Pine.LNX.4.61.0501182106340.6118@scrub.home>
	 <1106157119.8642.25.camel@winden.suse.de>
	 <Pine.LNX.4.61.0501191858060.30794@scrub.home>
Content-Type: text/plain
Organization: SUSE Labs
Message-Id: <1106160130.8642.46.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 19 Jan 2005 19:42:10 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-19 at 19:18, Roman Zippel wrote:
> Hi,
> 
> On Wed, 19 Jan 2005, Andreas Gruenbacher wrote:
> 
> > > > A user ran into the following problem: They grab a SuSE kernel-source
> > > > package that is more recent than their running kernel. The tree under
> > > > /usr/src/linux is unconfigured by default; there is no .config. User
> > > > does a ``make menuconfig'', which gets its default values from
> > > > /boot/config-$(uname -r). User tries to build the kernel, which doesn't
> > > > work.
> > > 
> > > NAK. This isn't normally supposed to happen and it shouldn't be as bad 
> > > anymore as it used to be. Removing these path doesn't magically create a 
> > > working kernel.
> > 
> > "Not normally supposed to happen" and "shouldn't be as bad anymore"
> > aren't very sound arguments.
> 
> It's as precise as above problem report. 
>
> > It's fundamentally broken to use a
> > semi-random configuration for a kernel source tree that may be
> > arbitrarily far apart.
> 
> No, it's not. Please provide more information why exactly this is broken.

Okay, more verbose then. On your machine which is running kernel version
x you build kernel version y. You grab the version y kernel source tree,
let's say a vendor tree, which has meaningful default configurations in
arch/$ARCH/defconfig. The runnig kernel's configuration may also work
for that kernel source tree, or it may not.

The user does a ``make menuconfig'', and expects to see sane defaults.
What kconfig really does is take the running kernel's configuration
instead. This is a ad choice; it makes much more sense to take
arch/$ARCH/defconfig.

> > It's not uncommon that users who build their own kernel modules often
> > are very clueless. Nevertheless we shouldn't cause them pain
> > unnecessarily.
> 
> So they should first try the 2.6 kernel provided by the distribution and 
> then try compiling their own kernel. In this situation it's actually more 
> likely that they produce a working kernel with the current behaviour, the 
> defconfig is not a guarantee for a working kernel either.

You assume that the user is already running the kind of kernel he is
trying to produce. Al least to me this assumption seems weird. Instead
my proposal is to use a different make target if you actually do want to
clone the running kernel's configuration, but this shouldn't be the
default.

> Sorry, but as long as nobody writes an autoconfig tool for the kernel, the 
> kernel configuration is not a simple process and any default can only be a 
> compromise and may fail. If you have evidence that there are better 
> defaults, we can change this, but your problem report above is not enough.

I'm not trying to add more magic, I'm trying to get magic taken out,
because nothing guarantees that taking the running kernel's
configuration makes sense. The kernel packages we ship have meaningful
default configurations on all architectures that allow this. You won't
end up with a highly optimized configuration for your particular
machine, but nothing guarantees that you will end up in a better state
with the running kernel's config.

Cheers,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX GMBH

