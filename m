Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291979AbSBAU2y>; Fri, 1 Feb 2002 15:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291976AbSBAU2p>; Fri, 1 Feb 2002 15:28:45 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:51622 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S291975AbSBAU2b>;
	Fri, 1 Feb 2002 15:28:31 -0500
Date: Fri, 1 Feb 2002 15:28:29 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andreas Dilger <adilger@turbolabs.com>, linux-kernel@vger.kernel.org
Subject: Re: Continuing /dev/random problems with 2.4
Message-ID: <20020201152829.A2497@havoc.gtf.org>
In-Reply-To: <20020201031744.A32127@asooo.flowerfire.com> <1012582401.813.1.camel@phantasy> <a3enf3$93p$1@cesium.transmeta.com> <20020201124300.G763@lynx.adilger.int> <3C5AF6B5.5080105@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C5AF6B5.5080105@zytor.com>; from hpa@zytor.com on Fri, Feb 01, 2002 at 12:12:37PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2002 at 12:12:37PM -0800, H. Peter Anvin wrote:
> Andreas Dilger wrote:
> > Maybe, i8XX hardware RNG should feed the /dev/random entropy pool
> > directly if you enable the chipset support (with an option to turn
> > it off if you want to use the user-space tools or a separate RNG),
> > so that people get the benefits of the h/w RNG without having to
> > install another tool (which they won't know about)?

> "Let's put it in the kernel because people are too stupid to install it
> otherwise"?

There actually used to be a timer function in i810_rng driver which
directly added entropy to the pool.  batch_entropy_store was exported in
order to do this.

However, that was just the quick and dirty way.  You DO NOT want to do
this in the kernel, because one must perform fitness tests on the random
data before adding it to the kernel's /dev/[u]random entropy pool.
Putting proper fitness tests into the kernel is just plain code bloat.

Therefore, RNG drivers -must- deal with a userspace agent in order to be
properly used, and properly secure.

The userspace tools for i810 RNG specifically are available at the
website URL mentioned in the source code.  So if somebody cannot find
them, feel free to laugh.

	Jeff



