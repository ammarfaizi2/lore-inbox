Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263465AbTD1MHK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 08:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263538AbTD1MHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 08:07:10 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:51949 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263465AbTD1MHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 08:07:09 -0400
Date: Mon, 28 Apr 2003 14:19:20 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andi Kleen <ak@muc.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Support worst case cache line sizes as config option
Message-ID: <20030428121920.GE27064@fs.tum.de>
References: <20030427022346.GA27933@averell> <20030428091616.GA27064@fs.tum.de> <20030428114717.GA6904@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030428114717.GA6904@averell>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 28, 2003 at 01:47:17PM +0200, Andi Kleen wrote:
> On Mon, Apr 28, 2003 at 11:16:16AM +0200, Adrian Bunk wrote:
> > Your X86_GENERIC is semantically equivalent to M386.
> 
> M386 is tuning for the Intel 386
> 
> X86_GENERIC is "try to tune for all CPUs if possible" 

M386 says that the minimum CPU supported is the 386 - and all CPUs 
above are supported, too. E.g.:

config X86_PPRO_FENCE
        bool
        depends on M686 || M586MMX || M586TSC || M586 || M486 || M386
        default y

config X86_F00F_BUG
        bool
        depends on M586MMX || M586TSC || M586 || M486 || M386
        default y


> > This doesn't work. E.g. MPENTIUMIII has the semantics of "support 
> > Pentium-III and above". If you want to compile a kernel that runs on 
> > both a Pentium-III and a Pentium-4 you choose MPENTIUMIII which implies 
> > X86_L1_CACHE_SHIFT=5 ...
> 
> Admittedly the other options could be changed to 
> 
> default "4" if (MELAN || M486 || M386) && !X86_GENERIC
> 
> but that looked a bit too ugly and it seems to work even without.

Your approach as well as the approach I'm currently working on breaks
the current semantics that a plain M386 produces a kernel that runs on
all CPUs.

> -Andi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

