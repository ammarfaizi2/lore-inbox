Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315416AbSHQQMv>; Sat, 17 Aug 2002 12:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315430AbSHQQMv>; Sat, 17 Aug 2002 12:12:51 -0400
Received: from mx2.elte.hu ([157.181.151.9]:22936 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S315416AbSHQQMu>;
	Sat, 17 Aug 2002 12:12:50 -0400
Date: Sat, 17 Aug 2002 18:17:45 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Boot failure in 2.5.31 BK with new TLS patch 
In-Reply-To: <200208171516.g7HFGpK03104@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0208171810260.29714-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 17 Aug 2002, James Bottomley wrote:

> The boot problem only happens with my quad pentium cards, the dyad
> pentium and 486 are fine.  Originally, a voyager system with quad cards
> just wouldn't boot (this was in the 2.2.x days).  Eventually, by trial
> and error and long debug of the boot process I discovered it would boot
> if the GDT was 8 bytes aligned (actually, the manuals say it should be
> 16 byte aligned, so perhaps we should also add this to the Linux
> setup.S?). [...]

indeed it's not aligned:

	c010025c T cpu_gdt_descr

could you align it by adding this line replacing the ALIGN line that
preceeds the cpu_gdt_descr definition in head.S:

	.align 32

we want to align the GDT to 32 bytes anyway, we have optimized it for
cache layout, and didnt realize that it wasnt aligned to begin with ...

> However, the general point that we should keep the boot sequence as
> simple as possible (just in case we run across any other wierd quirks
> even in modern PCs) still remains.

i agree, so unless you can find the source of the problem and we can fix
the generic GDT, your patch is the right solution.

but, the right GDT layout might affect things like APM or PNP BIOS
compatibility, so it would be useful to figure out what's wrong with the
main GDT nevertheless.

	Ingo

