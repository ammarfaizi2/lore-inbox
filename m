Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319363AbSHQGrF>; Sat, 17 Aug 2002 02:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319364AbSHQGrF>; Sat, 17 Aug 2002 02:47:05 -0400
Received: from mx2.elte.hu ([157.181.151.9]:55514 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S319363AbSHQGrE>;
	Sat, 17 Aug 2002 02:47:04 -0400
Date: Sat, 17 Aug 2002 08:51:47 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Boot failure in 2.5.31 BK with new TLS patch
In-Reply-To: <200208170031.g7H0V4806751@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0208170845250.3209-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 16 Aug 2002, James Bottomley wrote:

> This is probably local to me since I've got a box which takes quad CPU
> cards that has always been very picky about the GDT layout at boot.  
> However, it's been failing miserably with the new padding the TLS stuff
> introduces into the boot time GDT.
> 
> I attach a patch that leaves the boot time %cs and %ds at their old
> values (0x10 and 0x18), and shifts to the new GDT layout after the
> switch to protected mode has been accomplished.
> 
> For those who don't have this GDT boot problem, it reduces the size of
> the boot code by about 64 bytes.

while your patch looks OK, it would be *really* interesting to find out
why the previous layout failed. Does the BIOS somehow corrupt the GDT? You
are using the stock SMP code otherwise, correct? And this part of the
patch:

 gdt_48:
-       .word   0x8000                          # gdt limit=2048,
-                                               #  256 GDT entries
-
+       .word   gdt_end - gdt - 1               # gdt limit
        .word   0, 0                            # gdt base (filled in later)

perhaps this bit alone makes the difference?

	Ingo

