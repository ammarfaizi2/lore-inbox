Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319214AbSHWTud>; Fri, 23 Aug 2002 15:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319263AbSHWTt3>; Fri, 23 Aug 2002 15:49:29 -0400
Received: from [195.39.17.254] ([195.39.17.254]:24960 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S319217AbSHWTtQ>;
	Fri, 23 Aug 2002 15:49:16 -0400
Date: Fri, 2 Nov 2001 08:20:21 +0000
From: Pavel Machek <pavel@suse.cz>
To: Ingo Molnar <mingo@elte.hu>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Boot failure in 2.5.31 BK with new TLS patch
Message-ID: <20011102082020.U35@toy.ucw.cz>
References: <200208171516.g7HFGpK03104@localhost.localdomain> <Pine.LNX.4.44.0208171810260.29714-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.44.0208171810260.29714-100000@localhost.localdomain>; from mingo@elte.hu on Sat, Aug 17, 2002 at 06:17:45PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > The boot problem only happens with my quad pentium cards, the dyad
> > pentium and 486 are fine.  Originally, a voyager system with quad cards
> > just wouldn't boot (this was in the 2.2.x days).  Eventually, by trial
> > and error and long debug of the boot process I discovered it would boot
> > if the GDT was 8 bytes aligned (actually, the manuals say it should be
> > 16 byte aligned, so perhaps we should also add this to the Linux
> > setup.S?). [...]
> 
> indeed it's not aligned:
> 
> 	c010025c T cpu_gdt_descr
> 
> could you align it by adding this line replacing the ALIGN line that
> preceeds the cpu_gdt_descr definition in head.S:
> 
> 	.align 32
> 
> we want to align the GDT to 32 bytes anyway, we have optimized it for
> cache layout, and didnt realize that it wasnt aligned to begin with ...

You might want to .align L1_CACHE_SIZE (or something), IIRC P4s have bigger
cachelines than 32.
								Pave
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

