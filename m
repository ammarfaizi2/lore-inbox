Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267890AbUHaL2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267890AbUHaL2n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 07:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267899AbUHaL2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 07:28:43 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:35025 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S267890AbUHaL2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 07:28:40 -0400
Date: Tue, 31 Aug 2004 13:28:34 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       Matt Mackall <mpm@selenic.com>, linux-kernel@vger.kernel.org
Subject: Re: What policy for BUG_ON()?
Message-ID: <20040831112834.GC3466@fs.tum.de>
References: <20040830201519.GH12134@fs.tum.de> <Pine.LNX.4.58.0408301718040.2295@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408301718040.2295@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2004 at 05:25:52PM -0700, Linus Torvalds wrote:
> 
> 
> On Mon, 30 Aug 2004, Adrian Bunk wrote:
> >
> > Let me try to summarize the different options regarding BUG_ON, 
> > concerning whether the argument to BUG_ON might contain side effects, 
> > and whether it should be allowed in some "do this only if you _really_ 
> > know what you are doing" situations to let BUG_ON do nothing.
> > 
> > Options:
> > 1. BUG_ON must not be defined to do nothing
> > 1a. side effects are allowed in the argument of BUG_ON
> > 1b. side effects are not allowed in the argument of BUG_ON
> > 2. BUG_ON is allowed to be defined to do nothing
> > 2a. side effects are allowed in the argument of BUG_ON
> > 2b. side effects are not allowed in the argument of BUG_ON
> > 
> > It would be good if there was a decision which of the four choices 
> > should become documented policy.
> 
> I'd suggest we strongly discourage side-effects in BUG_ON(). 
> 
> That said, it might be safest to just go for 1b - we make side-effects of 
> BUG_ON() be _documented_ as a bug, but just for safety, I'd suggest doing
> 
> 	#define BUG_ON(x) (void)(x)
> 
> anyway, if somebody wants to compile without debugging. That will still 
> make the side-effects happen if somebody has them (and if there are none, 
> the compiler will not generate any code anyway).
>...

You say 1b but describe 2b...

The difference between 1b and 2b is that a patch to
  #define BUG_ON(x) (void)(x)
with an own option under EMBEDDED might be accepted into the kernel
with 2b, but not with 1b.

> 		Linus

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

