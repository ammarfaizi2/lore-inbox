Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263397AbTIGR56 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 13:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263400AbTIGR56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 13:57:58 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:44523 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263397AbTIGR5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 13:57:55 -0400
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jamie Lokier <jamie@shareable.org>
Cc: Pavel Machek <pavel@suse.cz>, nagendra_tomar@adaptec.com,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Roman Zippel <zippel@linux-m68k.org>,
       Kars de Jong <jongk@linux-m68k.org>,
       Linux/m68k kernel mailing list 
	<linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <20030907135337.GF19977@mail.jlokier.co.uk>
References: <Pine.LNX.4.44.0309032134040.25093-100000@localhost.localdomain>
	 <1062674382.21667.32.camel@dhcp23.swansea.linux.org.uk>
	 <20030905212420.GD220@elf.ucw.cz>
	 <20030906230911.GA12392@mail.jlokier.co.uk>
	 <20030907131010.GB18067@atrey.karlin.mff.cuni.cz>
	 <20030907133543.GD19977@mail.jlokier.co.uk>
	 <20030907134020.GC18067@atrey.karlin.mff.cuni.cz>
	 <20030907135337.GF19977@mail.jlokier.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062957402.16972.37.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Sun, 07 Sep 2003 18:56:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-09-07 at 14:53, Jamie Lokier wrote:
> Pavel Machek wrote:
> > Perhaps weak ordering matters when you are writting to the MMIO, too?
> 
> Perhaps, but the code in arch/i386/kernel/cpu/centaur.c seems to try
> hard to set weak ordering for RAM, not the whole address space.

There are three cases I know of where you get weak store ordering that
is visible in some way

#1 Pentium Pro due to an errata, hence the need for lock in the
spin_unlock

#2 Centaur Winchip (where OOSTORE off is worth 10-30% performance on
common tasks). A lot of that has to do with the nature of the CPU and 
the old socket 7 bus stuff. Its not SMP but we have to care about it
for mmio not because mmio is itself out of order (we leave it in order)
but because of DMA. We must ensure that our writes to ram finish
-before- we kick off the hardware copying the data...

#3 Weak store ordering via sse type instructions, where its intentional
and an sfence is needed eventually

