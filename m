Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284710AbRLJVgB>; Mon, 10 Dec 2001 16:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284729AbRLJVfE>; Mon, 10 Dec 2001 16:35:04 -0500
Received: from mtiwmhc23.worldnet.att.net ([204.127.131.48]:39350 "EHLO
	mtiwmhc23.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S286403AbRLJVeV>; Mon, 10 Dec 2001 16:34:21 -0500
Subject: Re: IRQ Routing Problem on ALi Chipset Laptop (HP Pavilion N5425)
From: Cory Bell <cory.bell@usa.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20011210170147.A24663@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.33.0112060938340.32381-100000@pianoman.cluster.toy>
	<1007685691.6675.1.camel@localhost.localdomain>
	<20011207213313.A176@elf.ucw.cz>
	<1007876254.17062.0.camel@localhost.localdomain> 
	<20011210170147.A24663@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 10 Dec 2001 13:24:48 -0800
Message-Id: <1008019490.17061.18.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-12-10 at 08:01, Pavel Machek wrote:
> I called them... The girl who received call was very friendly, wanted
> to assign me bug#, but I resisted. I told her your bug#, but only
> reply I got was something like "all our bug numbers begin with 1327",
> and she apparently had no access to global database. I am not sure the
> person knew what I was talking about.

What, 1st-level tech support staff lacking knowledge? Surely you jest!
:> Seriously, though, I was kind of lucky - I got a guy who's into
computers and plays with a Linux box at school. He was at least
receptive to my description of the problem.

> He told me there's updated bios, somewhere. Did you try that?

Latest BIOS for my machine is 1.03 - didn't help.

> What exactly is wrong? You said PIR tables are broken, but with patch
> below, it seems to work. What's wrong?

Take a look at http://www.microsoft.com/hwdev/archive/BUSBIOS/pciirq.asp
for some background. Under linux, on an ALi chipset, the "link" numbers
are used as an offset into the PCI config space of the ISA bridge, where
the IRQ for that "link" is stored. On my machine, the link numbers are
0x01-0x03 (for everything but USB) and 0x59 (for USB). The value at the
offset for link 0x59 translates to IRQ 9. The PCI configuration space of
the USB controller indicates IRQ 9, as well. See pirq_ali_get() in
linux/arch/i386/kernel/pci-irq.c for details on how this works.

All the last patch does is match the IRQ being considered for the device
against the IRQ mask for that device in the PIR table. If it doesn't
match, the kernel assigns one that does match the mask.

To be clear: with the last patch, USB works, but not the maestro-3,
right?

The reason I keep asking you for the output of "lspci -vvvxxx" and
"dump_pirq" is so I can look at your PIR table and PCI config space and
try to determine if the same thing that happened to USB is happening to
your maestro. It's possible your maestro problem is completely
unrelated. If you're unwilling to provide that informataion for some
reason, just let me know and I'll quit asking.

-Cory

