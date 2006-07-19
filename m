Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964868AbWGSPQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbWGSPQu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 11:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbWGSPQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 11:16:50 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:50704 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964868AbWGSPQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 11:16:49 -0400
Date: Wed, 19 Jul 2006 17:16:48 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Daniel Drake <dsd@gentoo.org>, Andrew Morton <akpm@osdl.org>,
       linville@tuxdriver.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/net/wireless/zd1211rw/: possible cleanups
Message-ID: <20060719151648.GA22498@stusta.de>
References: <20060715003511.GE3633@stusta.de> <44BA3C59.9030503@gentoo.org> <20060717212951.GC29824@p15091797.pureserver.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060717212951.GC29824@p15091797.pureserver.info>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2006 at 11:29:51PM +0200, Ulrich Kunitz wrote:
> On 06-07-16 14:17 Daniel Drake wrote:
> 
> > Adrian Bunk wrote:
> > >This patch contains the following possible cleanups:
> > >- make needlessly global functions static
> > >- #if 0 unused functions
> > >
> > >Please review which of these functions do make sense and which do 
> > >conflict with pending patches.
> > 
> > Thanks Adrian. I have put this in my tree and made an additional change 
> > along the same lines (your patched introduced an unused function warning 
> > to the non-debug build). If Ulrich signifies acceptance, I will send 
> > this on to John.
> > 
> > I have also sent in a patch to add a MAINTAINERS entry for zd1211rw, in 
> > hope that this will help you send patches with myself and/or Ulrich CC'd 
> > in future :)
> > 
> > Thanks.
> > Daniel
> > -
> > To unsubscribe from this list: send the line "unsubscribe netdev" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> Adrian, I would like to see this patch split up into three at
> least. 
> 
> Patch 1: Remove unused IO emulation functions
> Patch 2: Remove other unused stuff, which could be split up
>          further for each C file and header
> Patch 3: Change DEBUG ifdefs to #if 0
> 
> The purpose of patch 3 is bogus, because the follow-up patch will
> be called "removed useless #if 0 stuff". Keep in mind there is

That's not the purpose.

#if 0'ed code is both marked as unused and does no longer bloat the 
kernel.

> some reason, why I have such code there. If they ifdefs are not
> acceptable I will make this code dependent on a module parameter
> and compile it into the production module. We have a lot of
> different devices from different vendors out there and people
> report "stuff isn't working" but almost nothing more.

You are misunderstanding this part of my patch.
It does NOT remove used debug code.
It does #if 0 code that was not used with CONFIG_ZD1211RW_DEBUG=y.

> The problem with patch 1 and 2 is, that almost all of the function
> are completing the interface and some of them are even only static
> inlines. They are there because they should be used, before
> somebody reinvents the wheel or makes something completely stupid.
> However if such reasoning is not acceptable I'm ready to
> compromise.

I've only #if 0'ed "static inline" functions when they were the only 
user of an otherwise unused global function.

The main question is what your "should be used" means.

Will they be used within the next days/weeks or only in some far future?

In the first case, I agree that my patch shouldn't be applied now.
In the latter case, there's no reason to bloat the kernel binary now for 
some future usage that might or might not happen.

> Uli Kunitz

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

