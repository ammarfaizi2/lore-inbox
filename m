Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbUKSN3p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbUKSN3p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 08:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbUKSN3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 08:29:45 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:42252 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261404AbUKSN3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 08:29:15 -0500
Date: Fri, 19 Nov 2004 14:29:09 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andi Kleen <ak@suse.de>
Cc: Paul Menage <menage@google.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [discuss] RFC: let x86_64 no longer define X86
Message-ID: <20041119132909.GE22981@stusta.de>
References: <20041119005117.GM4943@stusta.de> <6599ad8304111817317880dfe5@mail.google.com> <20041119122827.GB22981@stusta.de> <20041119124055.GG21483@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041119124055.GG21483@wotan.suse.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2004 at 01:40:55PM +0100, Andi Kleen wrote:

> > The most important improvement would be to prevent such bugs and to have 
> > the X86_64 dependency explicitely stated.
> 
> This would just end up with me having to hunt through all the drivers
> all the time and enabling drivers that need to be enabled on x86-64 too.
> 
> It's much easier to disable the few drivers that are broken with !X86_64. 
>...

The issue you describe only occurs when a new dependency on X86 is 
added. It is not a problem for the common case that a driver is portable 
and therefore available on all architectures.

If the driver also works on X86_64, adding a " || X86_64" is trivial.
In the worst case, a new driver is not available on X86_64 until this is 
added to the dependencies.

But the current setup might cause real bugs.

If one new user of CONFIG_LBD wouldn't additionally (and not strictly 
required) check BITS_PER_LONG, it might currently have unwanted effects 
on X86_64. Explicite annotations with X86_64 if it works on this 
architecture would prevent such bugs.

> -Andi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

