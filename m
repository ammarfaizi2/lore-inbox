Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279515AbRJXKgb>; Wed, 24 Oct 2001 06:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279517AbRJXKgW>; Wed, 24 Oct 2001 06:36:22 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:6927 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S279515AbRJXKgE>; Wed, 24 Oct 2001 06:36:04 -0400
Date: Wed, 24 Oct 2001 12:36:30 +0200
From: Karel Kulhavy <clock@atrey.karlin.mff.cuni.cz>
To: linux-kernel@vger.kernel.org
Subject: Poor documentation of kernel parameters
Message-ID: <20011024123630.A11865@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How do I say kernel this:

I have two ISA network cards,
ne2000 IRQ 10 IO 0x300-0x31f DMA none
WD8003-old IRQ 5 IO 0x380-0x39f DMA none

using kernel parameters?

Why in the doc for kernel parameters in Documentation/kernel-parameters.txt
is written:
    ether=              [HW,NET] Ethernet cards parameters (iomem,irq,dev_name).and in net/ethernet/eth.c in function eth_setup
__initfunc(void eth_setup(char *str, int *ints))
{
        struct device *d = dev_base;

        if (!str || !*str)
                return;
        while (d)
        {
                if (!strcmp(str,d->name))
                {
                        if (ints[0] > 0)
                                d->irq=ints[1];
                        if (ints[0] > 1)
                                d->base_addr=ints[2];
                        if (ints[0] > 2)
                                d->mem_start=ints[3];
                        if (ints[0] > 3)
                                d->mem_end=ints[4];
                        break;
                }
                d=d->next;
        }
}

It looks like the ether= has format of ether=baseaddr,mem_start,mem_end,
which is in direct contradiction with the documentation.

What means the iomem in the documentation? Is it some kind of
hybrid between I/O port and memory address?
What means dev_name in ether? Should I write there

a) NE2000
b) ne2000
c) DP8390
d) dp8390
e) 8390
f) ne
g) NE
h) DP-8390
i) dp-8390
j) ne-2000
k) NE-2000

for ne2000

and
a) WD
b) wd
c) wd8003-old
d) WD8003-old
e) wd8003
f) WD8003
g) wd-old
h) wd-OLD
i) WD-old
j) WD-OLD
k) wd-8003
l) WD-8003

for wd8003-old?

Why isn't in the doc for kernel parameters written syntax of the kernel
parameters? Should they be separated by colon, semicolon, space, tab,
whitespace, newline?

Clock

