Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267882AbUHPSrV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267882AbUHPSrV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 14:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267880AbUHPSrB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 14:47:01 -0400
Received: from maximus.kcore.de ([213.133.102.235]:22137 "EHLO
	maximus.kcore.de") by vger.kernel.org with ESMTP id S267863AbUHPSpY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 14:45:24 -0400
Message-ID: <41210098.4080904@gmx.net>
Date: Mon, 16 Aug 2004 20:44:40 +0200
From: Oliver Feiler <kiza@gmx.net>
User-Agent: Mozilla Thunderbird 0.7 (Macintosh/20040616)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Len Brown <len.brown@intel.com>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Marcelo Tosatti <marcelo@hera.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: eth*: transmit timed out since .27
References: <566B962EB122634D86E6EE29E83DD808182C3236@hdsmsx403.hd.intel.com> <1092678734.23057.18.camel@dhcppc4>
In-Reply-To: <1092678734.23057.18.camel@dhcppc4>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Len,

Len Brown wrote:

> Oliver,
> I'm glad that turning off "pci=noacpi" fixed your system.
> I don't know why the legacy irqrouter didn't work, but
> as ACPI works, I'm not going to worry about it;-)

Well, it did work with 2.4.26, but I agree that it's better to get the 
new stuff to work correctly. ;) I just noticed that /proc/interrupts and 
/proc/pci, lspci still disagree on the IRQ of the IDE device.

            CPU0
   0:     112337    IO-APIC-edge  timer
   1:          2    IO-APIC-edge  keyboard
   8:          1    IO-APIC-edge  rtc
   9:          0   IO-APIC-level  acpi
  14:       9296    IO-APIC-edge  ide0
  15:       9078    IO-APIC-edge  ide1
  17:         24   IO-APIC-level  eth1
  18:     125085   IO-APIC-level  eth0
  21:          0   IO-APIC-level  usb-uhci, usb-uhci, usb-uhci
  22:          0   IO-APIC-level  via82cxxx
  23:       2976   IO-APIC-level  eth2
NMI:          0
LOC:     112313
ERR:          0
MIS:         42


vs.

00:11.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C/VT8235 PIPC Bus Master IDE (rev 06) 
(prog-if 8a [Master SecP PriP])
         Subsystem: Unknown device 1849:0571
         Flags: bus master, medium devsel, latency 32, IRQ 255
         I/O ports at fc00 [size=16]
         Capabilities: <available only to root>

This probably has to do with this boot message:
PCI: No IRQ known for interrupt pin A of device 00:11.1

I have found absolutely nothing that explains if this is an error or 
just some sort of debug message one can ignore.

> 
> I expect the "acpi=off" experiment would behave the same as
> "pci=noacpi", but it looks like in your experiment you
> mis-spelled that parameter as apci=off, so instead it was the
> same as the default ACPI-enabled case.

Oh, thanks for noticing. Stupid me.

> 
> Re: lots of interrupts on the same IRQ.
> There are boot params to balance out the IRQs in PIC mode,
> but what you want to do on this system is enable the IOAPIC
> in your kernel config.  The existence of the MADT in your
> ACPI tables suggests you may have one.  An IOAPIC will bring
> additional interrupt pins to bear, usually allowing
> the PCI interrupts to use IRQs > 16 where they may
> not have to share so much.

Ok, I've turned on the IOAPIC and it seems to work perfectly fine. 
Except for that IRQ 255 thing I've noticed no oddities. Thanks for the 
hint. :)

cu
	Oliver

