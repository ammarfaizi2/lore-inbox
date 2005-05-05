Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262132AbVEEPOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262132AbVEEPOn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 11:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262133AbVEEPOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 11:14:43 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:13073 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262132AbVEEPOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 11:14:19 -0400
Date: Thu, 5 May 2005 17:14:15 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andi Kleen <ak@muc.de>
Cc: Andrew Morton <akpm@osdl.org>, venkatesh.pallipadi@intel.com,
       racing.guo@intel.com, luming.yu@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]porting lockless mce from x86_64 to i386
Message-ID: <20050505151415.GA3590@stusta.de>
References: <88056F38E9E48644A0F562A38C64FB60049EED02@scsmsx403.amr.corp.intel.com> <20050502171551.GG27150@muc.de> <20050502113125.19320ceb.akpm@osdl.org> <20050502191159.GI27150@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050502191159.GI27150@muc.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2005 at 09:11:59PM +0200, Andi Kleen wrote:
> On Mon, May 02, 2005 at 11:31:25AM -0700, Andrew Morton wrote:
> > Andi Kleen <ak@muc.de> wrote:
> > >
> > >  > 
> > >  > Doing it either way should be OK with this mce code. But I feel, 
> > >  > despite of the patch size, it is better to keep all the shared 
> > >  > code in i386 tree and link it from x86-64. Otherwise, it may become 
> > >  > kind of messy in future, with various links between i386 and x86-64.
> > > 
> > >  i386 already uses code from x86-64 (earlyprintk.c) - it is nothing 
> > >  new.
> > 
> > I must say I don't like the bidirectional sharing either.
> 
> Why exactly? X86-64 is not a "slave" of i386, they are equal peers; 
> free to share from each other, but none better than the other ... ,-) 
>...

When grep'ing whether a patch I send might break something, it's quite 
handy to see what belongs to which architecture.

Perhaps some day someone might want to put some ACPI code under 
arch/ia64 and let i386 and x86_64 use it from there...

What about some kind of arch/i386-x86_64-shared/ that contains the 
shared code?

The fact that x86_64 defines CONFIG_X86 while i386 doesn't define 
CONFIG_X86_64 unambiguously defines an ordering, and if we really need 
this sharing, there's no good reason to make the chaos bigger than it is 
already with unidirectional sharing.

> -Andi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

