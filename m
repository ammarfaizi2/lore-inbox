Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132338AbRDCDN0>; Mon, 2 Apr 2001 23:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132494AbRDCDNQ>; Mon, 2 Apr 2001 23:13:16 -0400
Received: from platan.vc.cvut.cz ([147.32.240.81]:24838 "EHLO
	platan.vc.cvut.cz") by vger.kernel.org with ESMTP
	id <S132338AbRDCDNB>; Mon, 2 Apr 2001 23:13:01 -0400
Message-ID: <3AC93F7B.9E46D40E@vc.cvut.cz>
Date: Mon, 02 Apr 2001 20:11:55 -0700
From: Petr Vandrovec <vandrove@vc.cvut.cz>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-ac28-4g i686)
X-Accept-Language: cz, cs, en
MIME-Version: 1.0
To: Don Dugger <n0ano@valinux.com>
CC: xcp <xcp@brewt.org>, linux-kernel@vger.kernel.org
Subject: Re: what is pci=biosirq
In-Reply-To: <Pine.LNX.4.30.0103311833040.8695-100000@stinky.brewt.org> <20010402202343.A8531@tlaloc.n0ano.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don Dugger wrote:
> 
> The error message idicates that the MPS table doesn't provide interrupt
> routing information for that PCI slot.  I ran into the same problem
> on my K6 machine.  I was able to fix it in the BIOS.  In the BIOS setup
> go to the `Advaned' page.  Look under `Installed O/S'.  It probably
> says something silly like `Win95' or `Win98/Win2000'.  Change it to
> `Other' and your problem should go away.
> 
> On Sat, Mar 31, 2001 at 06:37:41PM -0800, xcp wrote:
> > ALI15X3: IDE controller on PCI bus 00 dev 78
> > PCI: No IRQ known for interrupt pin A of device 00:0f.0. Please try using
> > pci=biosirq.
> > ALI15X3: chipset revision 193
...
> > ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> > ide1 at 0x170-0x177,0x376 on irq 15
...
> > 00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c1)

It looks more like that Acer misimplemented PCI_IRQPIN register - if it
is legacy IDE interface using ports 1F0-1F7/170-177, with IRQs 14 & 15,
it should report zero as IRQ pin. What 'lspci -vx -s 0:f.0' says?
Last four bytes it prints should read 'YY 00 XX XX' - where YY is IRQ
number assigned by BIOS - either hardwired to zero in chip, or just left
alone by BIOS (00 or FF) and next 00 is IRQ pin number - 0 = none, 1 =
A, 
2 = B ... Intel IDE interfaces returns 00 00 here, VIA returns FF 00,
and
I have no hardware with an additional IDE around.

					Petr Vandrovec
					vandrove@vc.cvut.cz
