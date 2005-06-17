Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262025AbVFQRcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262025AbVFQRcd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 13:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262026AbVFQRcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 13:32:33 -0400
Received: from usbb-lacimss3.unisys.com ([192.63.108.53]:12042 "EHLO
	usbb-lacimss3.unisys.com") by vger.kernel.org with ESMTP
	id S262025AbVFQRca convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 13:32:30 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [2.6.12rc4] PROBLEM: "drive appears confused" and "irq 18:     nobody cared!"
Date: Fri, 17 Jun 2005 12:32:20 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04BFF@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6.12rc4] PROBLEM: "drive appears confused" and "irq 18:     nobody cared!"
Thread-Index: AcVzX4vtHGIePiWpS9Org+SEovh3kQAAG85Q
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Alexander Fieroch" <fieroch@web.de>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <bzolnier@gmail.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <axboe@suse.de>,
       "Bartlomiej Zolnierkiewicz" <B.Zolnierkiewicz@elka.pw.edu.pl>
X-OriginalArrivalTime: 17 Jun 2005 17:32:20.0502 (UTC) FILETIME=[83CAC360:01C57362]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Alan Cox wrote:
> >>Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The 
> drive appears 
> >>confused (ireason = 0x01) Jun 17 12:07:49 orclex kernel: 
> irq 18: nobody cared (try booting with the "irqpoll" option.
> > 
> > Something failed to clear IRQ 18, that typically means 
> there are IRQ 
> > routing problems rather than IDE ones and would explain your traces.
> > 
> > Try booting with acpi=off and see what trace you get then.
> 
> acpi=off makes linux hang and not continuing booting. Hm, 
> syslog does not contain the trace until that crash but the 
> last lines before the hanging are:
> 
> ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 
> 10 Dec 2004 hub 1-0:1.0: USB hub found
> 
> 
> I've tried booting the kernel with parameter irqpoll as you 
> have suggested but it leads to a kernel panic.
> The last line was:
> 
> kernel panic - not syncing: Aiee, killing interrupt handler!
> 
> It's not saved in syslog too, so is there any way to get the 
> trace to a file?

You can set up a serial console and capture the output.
 
I would also recommend booting with pci=routeirq, this will show the
pre-disposition of each GSI->IRQ pair, although sometimes it changes IRQ
distribution, and you may get different error. Also try using apic=debug
or acpi=verbose to see the IO-APIC lines setup. For debug failed IRQs, I
sometimes insert print_io_APIC() after each PCI device IRQ registration,
to see it got edge or level triggered and other details. 
The other one that I saw causing problems especially for ISA devices is
ACPI PnP (and still does, I'm researching a similar problem on ES7000),
and in this case I get my system booted with pnpacpi=off.
Thanks,
--Natalie
