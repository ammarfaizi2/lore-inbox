Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262901AbSLUSc5>; Sat, 21 Dec 2002 13:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263039AbSLUSc5>; Sat, 21 Dec 2002 13:32:57 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:393 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S262901AbSLUScz>; Sat, 21 Dec 2002 13:32:55 -0500
Date: Sat, 21 Dec 2002 19:34:10 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Grant Grundler <grundler@cup.hp.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       mj@ucw.cz, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       turukawa@icc.melco.co.jp, ink@jurassic.park.msu.ru
Subject: Re: PATCH 2.5.x disable BAR when sizing
In-Reply-To: <Pine.LNX.4.44.0212201203340.2035-100000@home.transmeta.com>
Message-ID: <Pine.GSO.3.96.1021221192335.7158A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Dec 2002, Linus Torvalds wrote:

> > That's exactly the problem on ia64 - it does.
> > Could this also be a problem on i386 that we just haven't noticed yet?
> 
> Unlikely. The IO-APIC on x86 is in that region, but it doesn't respond
> from external sources, it's not actually on the PCI bus and only visible
> from the CPU. And the CPU decodes that address internally and sends it on
> the APIC bus and thus PCI devices simply do not matter for it.

 That's not true for the I/O APIC.  That's only true for the local APIC.

 The I/O APIC may be wired to the PCI-ISA bridge, specifically the APICCS#
(chip select) line may be driven by that bridge when a PCI cycle targets
the area assigned to the I/O APIC.  This is certainly the case for
discrete implementations, like the i82371SB/AB (PCI-ISA bridge) + i82093AA
(I/O APIC) pair, possibly for others, including later I/O APICs integrated
into chipsets.  Obviously cycles from CPUs travel to the PCI-ISA bridge
across the associated PCI bus.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

