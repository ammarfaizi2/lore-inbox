Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbVKAOIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbVKAOIS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 09:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbVKAOIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 09:08:18 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:44306 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750795AbVKAOIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 09:08:17 -0500
Date: Tue, 1 Nov 2005 15:08:13 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, zippel@linux-m68k.org, ak@suse.de,
       rmk+lkml@arm.linux.org.uk, tony.luck@gmail.com,
       paolo.ciarrocchi@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: New (now current development process)
Message-ID: <20051101140813.GP8009@stusta.de>
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com> <20051031001647.GK2846@flint.arm.linux.org.uk> <20051030172247.743d77fa.akpm@osdl.org> <200510310341.02897.ak@suse.de> <Pine.LNX.4.61.0511010039370.1387@scrub.home> <20051031160557.7540cd6a.akpm@osdl.org> <Pine.LNX.4.64.0510311611540.27915@g5.osdl.org> <20051031163408.41a266f3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051031163408.41a266f3.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2005 at 04:34:08PM -0800, Andrew Morton wrote:
> Linus Torvalds <torvalds@osdl.org> wrote:
> >
> > 
> > 
> > On Mon, 31 Oct 2005, Andrew Morton wrote:
> > > 
> > > Are you sure these kernels are feature-equivalent?
> > 
> > They may not be feature-equivalent in reality, but it's hard to generate 
> > something that has the features (or lack there-of) of old kernels these 
> > days. Which is problematic.
> 
> Probably.
> 
> > But some of it is likely also compilers. gcc does insane padding in many 
> > cases these days. 
> 
> 2.6.14 `make allnoconfig':
> 
> gcc-2.95.4:
> 
> 	bix:/usr/src/25> size vmlinux 
> 	   text    data     bss     dec     hex filename
> 	 665502  152379   55120  873001   d5229 vmlinux
> 
> gcc version 4.1.0 20050513 (experimental):
> 
> 	bix:/usr/src/25> size vmlinux
> 	   text    data     bss     dec     hex filename
> 	 761415  151851   55280  968546   ec762 vmlinux

That's not a fair comparison.

If you do not tell gcc to optimize for size you can't expect it to 
produce small code.

The following is with allnoconfig + CONFIG_EMBEDDED=y + intelligent 
setting of the options shown by "make oldconfig" after setting 
CONFIG_EMBEDDED=y (the third kernel is built without 
-fno-unit-at-a-time):

   text    data     bss     dec     hex filename
 522545   77694   31256  631495   9a2c7 vmlinux-2.95
 436878   76594   32248  545720   853b8 vmlinux-4.0
 429420   76370   32184  537974   83576 vmlinux-4.0-unit-at-a-time


> (There's a new reason for retaining gcc-2.95.x support)
>...

There's a new reason for removing gcc-2.95.x support.  ;-)

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

