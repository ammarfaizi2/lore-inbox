Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267449AbUIFXKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267449AbUIFXKg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 19:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267451AbUIFXKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 19:10:36 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:26256 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S267449AbUIFXKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 19:10:22 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: swsusp on x86-64 w/ nforce3
Date: Tue, 7 Sep 2004 01:10:35 +0200
User-Agent: KMail/1.6.2
Cc: Pavel Machek <pavel@suse.cz>, Andi Kleen <ak@suse.de>
References: <200409061836.21505.rjw@sisk.pl> <200409062123.08476.rjw@sisk.pl> <20040906203228.GA18105@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20040906203228.GA18105@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200409070110.35826.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 of September 2004 22:32, Pavel Machek wrote:
> Hi!
> 
> > > Can you tell me, please, if swsusp, as in the 2.6.9-rc1-bk12 kernel, is 
> > > supposed to work on x86-64-based systems (specifically, with the nforce3 
> > > chipset)?
> > 
> > Anyway, on such a system (.config and the output of dmesg are attached), I 
get 
> > the following:
> > 
> > Stopping tasks: 
> > ==============================================================|
> > Freeing 
> > 
memory: ............................................................................................................|
> > Suspending devices... /critical section: counting pages to copy..[nosave 
pfn 
> > 0x59b]..................................................)
> > Alloc pagedir
> > ..[nosave pfn 
> > 
0x59b]................................................................................critical 
> > section/: done (40890 pa)
> > APIC error on CPU0: 80(08)
> 
> Try noapic?

The result is the same. :-(  It is quite strange, though, because I have:

rafael@albercik:~> cat /proc/interrupts
           CPU0
  0:     448292          XT-PIC  timer
  1:       1047          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:        684          XT-PIC  ohci_hcd, NVidia nForce3
  8:          0          XT-PIC  rtc
  9:        839          XT-PIC  acpi, yenta
 10:          2          XT-PIC  ehci_hcd
 11:       3034          XT-PIC  SysKonnect SK-98xx, ohci_hcd, yenta, ohci1394
 12:       4520          XT-PIC  i8042
 14:       2522          XT-PIC  ide0
 15:       8635          XT-PIC  ide1
NMI:         74
LOC:     448090
ERR:          1
MIS:          0

but at the same time:

rafael@albercik:~> dmesg | grep -i apic
Bootdata ok (command line is root=/dev/hdc6 vga=792 resume=/dev/hdc3 noapic)
PCI bridge 00:0a from 10de found. Setting "noapic". Overwrite with "apic"
OEM ID: ASUSTeK  <6>Product ID: L5D          <6>APIC at: 0xFEE00000
Processor #0 15:4 APIC version 16
I/O APIC #1 Version 17 at 0xFEC00000.
Kernel command line: root=/dev/hdc6 vga=792 resume=/dev/hdc3 noapic 
console=tty0
Using local APIC NMI watchdog using perfctr0
Using local APIC timer interrupts.
Detected 12.468 MHz APIC timer.

The nolapic probably oopses, because the box sort of hanged when I set it, but 
I have to use the serial console to confirm it.

Regards,
RJW

-- 
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman
