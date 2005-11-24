Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030522AbVKXANJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030522AbVKXANJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 19:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030524AbVKXANI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 19:13:08 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:38916 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030522AbVKXANG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 19:13:06 -0500
Date: Thu, 24 Nov 2005 01:13:05 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] add -Werror-implicit-function-declaration to CFLAGS
Message-ID: <20051124001305.GM3963@stusta.de>
References: <20051123223438.GY3963@stusta.de> <20051123150905.6c7a952d.akpm@osdl.org> <20051123233853.GL3963@stusta.de> <20051123155035.2494a746.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051123155035.2494a746.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 03:50:35PM -0800, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > On Wed, Nov 23, 2005 at 03:09:05PM -0800, Andrew Morton wrote:
> > > Adrian Bunk <bunk@stusta.de> wrote:
> > > >
> > > > Currently, using an undeclared function gives a compile warning, but it 
> > > > can lead to a nasty runtime error if the prototype of the function is 
> > > > different from what gcc guessed.
> > > > 
> > > > With -Werror-implicit-function-declaration, we are getting an immediate 
> > > > compile error instead.
> > > 
> > > Where "we" == "me".  This patch means I get to fix all the errors which I
> > > encounter.  No fair.  This should be the last patch, not the first.
> > 
> > Is it my fault that you applied neither Al Viro's patches to remove the 
> > usages of the ISA legacy functions
> 
> Never saw them.

It's the patch series starting with
  http://www.ussg.iu.edu/hypermail/linux/kernel/0511.1/2685.html

> > nor my patch to mark 
> > virt_to_bus/bus_to_virt as __deprecated on i386?
> 
> That won't make powerpc compile.

Judging from the feedback when I sent this patch first, there are people 
who might notice and actually fix these issues.

> Plus there are various other unfixed functions around the tree with various
> .configs.

And it's my job to fix every single such bug before you'd accept 
-Werror-implicit-function-declaration in the CFLAGS?

Yes, these are bugs.
And yes, they do already generate warnings.

> It took about four releases to teach people that the jsm driver won't
> compile.  I don't want to go adding things to -mm which break it in this
> way - that causes us to lose testers.

-Werror-implicit-function-declaration helps us to avoid a class of 
hard to find _runtime_ errors.

I'm already sending patches to fix all the warnings with 
-Wmissing-prototypes (which is roughly spoken the other side of the 
implicit-function-declaration issue) at least on i386 before I'm 
proposing to add this flag to the global CFLAGS, and while doing this 
I've already found and fixed three _runtime_ errors.

But judging from your comments you might then reject 
-Wmissing-prototypes because it causes warnings on other 
architectures...

IMHO reducing the number of hard to find runtime errors is more 
important than to get allmodconfig compiling in every -mm 
on all architectures.

> The patch is a good one, but it should come last.

Instead of telling me that I have to fix compile breakages with all 
possible .config's on all architectures before you would accept my 
patch, couldn't you be honest and simply tell me to fuck off?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

