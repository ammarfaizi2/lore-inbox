Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130500AbQKGAU4>; Mon, 6 Nov 2000 19:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129600AbQKGAUj>; Mon, 6 Nov 2000 19:20:39 -0500
Received: from nifty.blue-labs.org ([208.179.0.193]:55937 "EHLO
	nifty.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S130332AbQKGAUD>; Mon, 6 Nov 2000 19:20:03 -0500
Message-ID: <3A074AAC.1F88DB3@linux.com>
Date: Mon, 06 Nov 2000 16:19:56 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Hinds <dhinds@valinux.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: current snapshots of pcmcia
In-Reply-To: <3A06757F.3C63F1A8@linux.com> <20001106104927.A19573@valinux.com> <3A073C8D.B6511746@linux.com> <20001106154039.A19860@valinux.com>
Content-Type: multipart/mixed;
 boundary="------------20C3087B84E1E1A64CC49D89"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------20C3087B84E1E1A64CC49D89
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

David Hinds wrote:

> On Mon, Nov 06, 2000 at 03:19:41PM -0800, David Ford wrote:
> >
> > Undoubtedly :(  But it used to work when I used your i82365 module instead of
> > the kernel's yenta module.  The i82365 module now gives the same failure
> > output as the yenta module.
>
> How long ago was this?  I would need to know what kernel versions and
> what PCMCIA driver versions were involved.  It has been months since I
> changed any of the PCI bridge setup code in the PCMCIA modules.

test10-pre6, your code from mid october worked (with gross hack I made for the L1
cache define).

test10 release, nothing works now.


> > I modprobed the following to get things up and running, (all your pkg)
> > pcmcia_core, i82365, and ds.  Then ran cardmgr.  All was well.  Now when I
> > load i82365, it yields the pci irq failure and the irq type is changed.
> >
> > 2nd sentc: What changed in the last two-three weeks?  I notice that the
> > current pcmcia (yours) code loads a new module called pci_fixup.
>
> There is no module called pci_fixup.  There is an object file called
> pci_fixup that is linked into pcmcia_core.  This has been there since
> PCMCIA release 3.1.11.

Hmm, lsmod showed it.  I'll duplicate and report.


> > Intel PCIC probe: <4>PCI: No IRQ known for interrupt pin A of device 00:03.0.
> > PCI: No IRQ known for interrupt pin B of device 00:03.1.
>
> This is a PCI subsystem issue; the PCMCIA code asks the PCI subsystem
> to activate the bridge device and isn't working.
>
> >   Ricoh RL5C478 rev 03 PCI-to-CardBus at slot 00:03, mem 0x10000000
> >     host opts [0]: [isa irq] [io 3/6/1] [mem 3/6/1] [no pci irq] [lat
> > 168/176] [bus 2/5]
> >     host opts [1]: [serial irq] [io 3/6/1] [mem 3/6/1] [no pci irq] [lat
> > 168/176] [bus 6/9]
> >     ISA irqs (default) = 3,4,7,11 polling interval = 1000 ms
> >
> > Previous output was:
> >   Ricoh RL5C478 rev 03 PCI-to-CardBus at slot 00:03, mem 0x10000000
> >     host opts [0]: [serial irq] [io 3/6/1] [mem 3/6/1] [no pci irq] [lat
> > 168/176] [bus 2/5]
> >     host opts [1]: [serial irq] [io 3/6/1] [mem 3/6/1] [no pci irq] [lat
> > 168/176] [bus 6/9]
> >     ISA irqs (default) = 3,4,7,11 polling interval = 1000 ms
> >
> > Notice the change from serial irq to isa irq.
>
> This is odd.  I don't have an explanation for this, especially without
> knowing what PCMCIA driver releases were involved.  Unless you specify
> otherwise, the i82365 driver just reports the bridge settings that it
> finds; it won't change the interrupt delivery mode unless told to do
> so.  So something else has caused your two sockets to be set up in
> different ways; there isn't any way to tell the i82365 module to do
> that.

Ok.  I'll go back to test10-pre6 and get a working pcmcia system and we'll go from
there.

-d

--
"The difference between 'involvement' and 'commitment' is like an
eggs-and-ham breakfast: the chicken was 'involved' - the pig was
'committed'."



--------------20C3087B84E1E1A64CC49D89
Content-Type: text/x-vcard; charset=us-ascii;
 name="david.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for David Ford
Content-Disposition: attachment;
 filename="david.vcf"

begin:vcard 
n:Ford;David
x-mozilla-html:TRUE
adr:;;;;;;
version:2.1
email;internet:david@kalifornia.com
title:Blue Labs Developer
x-mozilla-cpt:;14688
fn:David Ford
end:vcard

--------------20C3087B84E1E1A64CC49D89--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
