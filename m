Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263517AbUDMNrj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 09:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263540AbUDMNri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 09:47:38 -0400
Received: from users.linvision.com ([62.58.92.114]:25526 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S263517AbUDMNrK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 09:47:10 -0400
Date: Tue, 13 Apr 2004 15:47:08 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH] QD65xx I/O ports
Message-ID: <20040413134708.GB13298@harddisk-recovery.com>
References: <Pine.GSO.4.58.0404061330470.4158@waterleaf.sonytel.be> <200404090050.24841.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404090050.24841.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2004 at 12:50:24AM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Tuesday 06 of April 2004 13:31, Geert Uytterhoeven wrote:
> > I/O port numbers can be larger than 8-bit on many platforms (this caused a
> > warning when {out,in}b() cast reg to a pointer on platforms with memory
> > mapped I/O)
> 
> Was VESA Local Bus ever used on something else than 486?

IIRC there were early Pentium boards with VESA Local Bus (VLB), but my
memory is vague about that.

> I think it's better to just add "depends on X86" to drivers/ide/Kconfig.

VLB is nothing more than ISA with a 32 bit address and data bus. That
is exactly how many busses on embedded CPUs work, but with the
difference that they map the ISA 16bit memory and IO space somewhere in
their 4GB memory space.

For example: the Digital/Intel StrongARM SA-11x0 has a 32 bit bus,
which (with the help of some glue logic) works like a 32 bit ISA bus.
Quite some embedded hardware emulates a 16 bit ISA bus by mapping the
ISA memory and IO space in a special memory area which can live
anywhere in the 4GB space, and that's why Geert wants an unsigned long
address in {out,in}b().


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
