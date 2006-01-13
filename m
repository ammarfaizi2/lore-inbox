Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964829AbWAMPTg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbWAMPTg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 10:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964965AbWAMPTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 10:19:36 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:18956 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964829AbWAMPTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 10:19:35 -0500
Date: Fri, 13 Jan 2006 16:19:34 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: "Bryan O'Sullivan" <bos@pathscale.com>, hch@infradead.org,
       rdreier@cisco.com, sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1 of 3] Introduce __raw_memcpy_toio32
Message-ID: <20060113151934.GO29663@stusta.de>
References: <20060110011844.7a4a1f90.akpm@osdl.org> <adaslrw3zfu.fsf@cisco.com> <1136909276.32183.28.camel@serpentine.pathscale.com> <20060110170722.GA3187@infradead.org> <1136915386.6294.8.camel@serpentine.pathscale.com> <20060110175131.GA5235@infradead.org> <1136915714.6294.10.camel@serpentine.pathscale.com> <20060110140557.41e85f7d.akpm@osdl.org> <1136932162.6294.31.camel@serpentine.pathscale.com> <20060110153257.1aac5370.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060110153257.1aac5370.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2006 at 03:32:57PM -0800, Andrew Morton wrote:
> "Bryan O'Sullivan" <bos@pathscale.com> wrote:
> >
> > On Tue, 2006-01-10 at 14:05 -0800, Andrew Morton wrote:
> > 
> > > It's kinda fun playing Brian along like this ;)
> > 
> > A regular barrel of monkeys, indeed...
> > 
> > > One option is to just stick the thing in an existing lib/ or kernel/ file
> > > and mark it __attribute__((weak)).  That way architectures can override it
> > > for free with no ifdefs, no Makefile trickery, no Kconfig trickery, etc.
> > 
> > I'm easy.  Would you prefer to take that, or the Kconfig-trickery-based
> > patch series I already posted earlier?
> > 
> 
> Unless someone can think of a problem with attribute(weak), I think you'll
> find that it's the simplest-by-far solution.

__attribute__((weak)) can turn compile error into runtime errors - you 
won't notice at compile time if it was forgotten to compile the 
non-weak version into the kernel (e.g. due to a typo in the Makefile).

Patch 05/17 from the 2.6.15.1 patchset contains a fix for such a bug
present in 2.6.15.

A variation of this problem can occur in cases like __raw_memcpy_toio32 
if it was forgotten to compile the non-weak version into the kernel and 
the kernel therefore uses the non-optimized version. That's not fatal, 
but it might take years until someone notices that there might be a few 
percent of performance missing.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

