Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131413AbRCPXnq>; Fri, 16 Mar 2001 18:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131426AbRCPXng>; Fri, 16 Mar 2001 18:43:36 -0500
Received: from sync.nyct.net ([216.44.109.250]:12551 "HELO sync.nyct.net")
	by vger.kernel.org with SMTP id <S131413AbRCPXnY>;
	Fri, 16 Mar 2001 18:43:24 -0500
Date: Fri, 16 Mar 2001 18:47:02 -0500
From: Michael Bacarella <mbac@nyct.net>
To: linux-kernel@vger.kernel.org
Subject: New ld must have --oformat instead of -oformat ?
Message-ID: <20010316184702.A19192@sync.nyct.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Riding the bleeding edge of debian leaves some interesting tastes.
Here's one:

[..much of build process omitted..]
make[1]: Entering directory `/usr/src/linux/arch/i386/boot'
gcc -E -D__KERNEL__ -I/usr/src/linux/include -D__BIG_KERNEL__ -traditional -DSVGA_MODE=NORMAL_VGA  bootsect.S -o bbootsect.s
as -o bbootsect.o bbootsect.s
bbootsect.s: Assembler messages:
bbootsect.s:253: Warning: indirect lcall without `*'
ld -m elf_i386 -Ttext 0x0 -s -oformat binary bbootsect.o -o bbootsect
ld: cannot open binary: No such file or directory
make[1]: *** [bbootsect] Error 1
make[1]: Leaving directory `/usr/src/linux/arch/i386/boot'
make: *** [bzImage] Error 2


The line 'ld: cannot open binary: No such file or directory' is puzzling.

I redid the build a few times hoping that it would magically work the
next time (the Windows approach), I got over my fear and thought about it.

# ld -v
GNU ld version 2.11.90.0.1 (with BFD 2.11.90.0.1)

# ld --help 2>&1 | grep oformat
  --oformat TARGET            Specify target of output file

The Makefile only has one dash. Changing -oformat to --oformat in
arch/i386/boot/Makefile builds the kernel just fine.

Did I stumble onto something that is a non-issue or am I just lucky enough
to be the first one to trip over it?

-- 
Michael Bacaiella <mbac@nyct.net>
Technical Staff / System Development,
New York Connect.Net, Ltd.
