Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129144AbQKFXUK>; Mon, 6 Nov 2000 18:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129166AbQKFXUB>; Mon, 6 Nov 2000 18:20:01 -0500
Received: from nifty.blue-labs.org ([208.179.0.193]:9601 "EHLO
	nifty.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S129144AbQKFXTq>; Mon, 6 Nov 2000 18:19:46 -0500
Message-ID: <3A073C8D.B6511746@linux.com>
Date: Mon, 06 Nov 2000 15:19:41 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Hinds <dhinds@valinux.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: current snapshots of pcmcia
In-Reply-To: <3A06757F.3C63F1A8@linux.com> <20001106104927.A19573@valinux.com>
Content-Type: multipart/mixed;
 boundary="------------6EE2A0851B8E4F3A7408FD97"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------6EE2A0851B8E4F3A7408FD97
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

(cc: lkml)
David Hinds wrote:

> On Mon, Nov 06, 2000 at 01:10:24AM -0800, David Ford wrote:
> > :(
> >
> > Ok.  Here's the story.  2.3/2.4 kernel pcmcia gave up the ghost on my
> > socket controller several versions back.  It is unable to assign an irq.
>
> PCMCIA in 2.4 (whether you build the modules in the kernel, or build
> the modules in the standalone package) is completely dependent on the
> kernel PCI layer to assign PCI interrupts (I assume that's what you
> mean by "an irq"?  without system log messages I can't be sure).
> There has been no change in this in recent months; there may have been
> changes in the PCI layer that broke your setup.
>
> > What changed in the last ~two weeks?  I notice that the current snapshot
> > also loads pci fixup.
>
> I don't understand the second sentence.  Please explain.

Undoubtedly :(  But it used to work when I used your i82365 module instead of
the kernel's yenta module.  The i82365 module now gives the same failure
output as the yenta module.

I modprobed the following to get things up and running, (all your pkg)
pcmcia_core, i82365, and ds.  Then ran cardmgr.  All was well.  Now when I
load i82365, it yields the pci irq failure and the irq type is changed.

2nd sentc: What changed in the last two-three weeks?  I notice that the
current pcmcia (yours) code loads a new module called pci_fixup.

The dmesg output from loading i82365 is:

Intel PCIC probe: <4>PCI: No IRQ known for interrupt pin A of device 00:03.0.

PCI: No IRQ known for interrupt pin B of device 00:03.1.

  Ricoh RL5C478 rev 03 PCI-to-CardBus at slot 00:03, mem 0x10000000
    host opts [0]: [isa irq] [io 3/6/1] [mem 3/6/1] [no pci irq] [lat
168/176] [bus 2/5]
    host opts [1]: [serial irq] [io 3/6/1] [mem 3/6/1] [no pci irq] [lat
168/176] [bus 6/9]
    ISA irqs (default) = 3,4,7,11 polling interval = 1000 ms

Previous output was:
  Ricoh RL5C478 rev 03 PCI-to-CardBus at slot 00:03, mem 0x10000000
    host opts [0]: [serial irq] [io 3/6/1] [mem 3/6/1] [no pci irq] [lat
168/176] [bus 2/5]
    host opts [1]: [serial irq] [io 3/6/1] [mem 3/6/1] [no pci irq] [lat
168/176] [bus 6/9]
    ISA irqs (default) = 3,4,7,11 polling interval = 1000 ms

Notice the change from serial irq to isa irq.

-d

--
"The difference between 'involvement' and 'commitment' is like an
eggs-and-ham breakfast: the chicken was 'involved' - the pig was
'committed'."



--------------6EE2A0851B8E4F3A7408FD97
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

--------------6EE2A0851B8E4F3A7408FD97--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
