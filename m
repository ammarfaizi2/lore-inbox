Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318018AbSHQROU>; Sat, 17 Aug 2002 13:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318020AbSHQROU>; Sat, 17 Aug 2002 13:14:20 -0400
Received: from mx1.elte.hu ([157.181.1.137]:41614 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318018AbSHQROU>;
	Sat, 17 Aug 2002 13:14:20 -0400
Date: Sat, 17 Aug 2002 19:18:49 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Gabriel Paubert <paubert@iram.es>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
       <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Boot failure in 2.5.31 BK with new TLS patch
In-Reply-To: <3D5E8346.5010101@iram.es>
Message-ID: <Pine.LNX.4.44.0208171915390.988-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 17 Aug 2002, Gabriel Paubert wrote:

> Hey no, it's cpu_gdt_table that must be aligned. That one does not
> matter, it's only used once for the lgdt instruction...

you are right, i misread the System.map - cpu_gdt_table is aligned
properly:

  c02a39e0 D cpu_gdt_table

so it must be something else that prevents booting on those boxes. Does 
the boot BIOS code perhaps assume a certain GDT layout? A certain size? 
Does it overwrite certain GDT entries perhaps?

> Ingo, for the layout of the gdt also, the location of the TSS descriptor
> is irrelevant AFAICT. It's only used when doing the initial LTR, after
> that it's never referenced by the CPU.

yes. Fortunately this makes no difference, the LDT and the default DS/CS
are in a single cacheline still.

	Ingo

