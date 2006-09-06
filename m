Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbWIFWiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbWIFWiO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 18:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbWIFWh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 18:37:57 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:23044 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964790AbWIFWhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 18:37:50 -0400
Date: Thu, 7 Sep 2006 00:37:48 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [2.6 patch] re-add -ffreestanding
Message-ID: <20060906223748.GC12157@stusta.de>
References: <20060830175727.GI18276@stusta.de> <200608302013.58122.ak@suse.de> <20060830183905.GB31594@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060830183905.GB31594@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2006 at 07:39:05PM +0100, Russell King wrote:
> On Wed, Aug 30, 2006 at 08:13:58PM +0200, Andi Kleen wrote:
> > On Wednesday 30 August 2006 19:57, Adrian Bunk wrote:
> > > I got the following compile error with gcc 4.1.1 when trying to compile 
> > > kernel 2.6.18-rc4-mm2 for m68k:
> > 
> > If anything then -ffreestanding needs to be added to arch/m68k/Makefile
> > (assuming it doesn't compile at all right now)
> 
> Looking at the effect of -ffreestanding on ARM, it appears that on one
> hand, the overall image size is reduced by 0.016% but we end up with worse
> code - eg, strlen() of the same string in the same function evaluated
> multiple times vs once without -ffreestanding.
> 
> The difference probably comes down to the lack of __attribute__((pure))
> on our string functions in linux/string.h.
> 
> If we are going to go for -ffreestanding, we need to fix linux/string.h
> in that respect _first_.

We are talking about reverting the patch that removed -ffreestanding, 
and that broke at least two architectures although it wrongly claimed 
it would have been a safe patch.

I agree that there is room for improvement at our string functions, but 
small optimizations like the ones you are mentioning are not much 
when talking about reverting a patch that is both theoretically wrong 
and has proven practically to cause problems.

> Russell King

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

