Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbUDCAe7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 19:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbUDCAe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 19:34:59 -0500
Received: from main.gmane.org ([80.91.224.249]:31201 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261433AbUDCAev (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 19:34:51 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: sean <seandarcy@hotmail.com>
Subject: Re: irq 16 : Nobody cared  - alsa v. io-apic in 2.6.5-rc3-bk2
Date: Fri, 02 Apr 2004 19:34:47 -0500
Message-ID: <406E06A7.1000003@hotmail.com>
References: <A6974D8E5F98D511BB910002A50A6647615F7212@hdsmsx402.hd.intel.com> <1080897252.30361.147.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
Cc: linux-kernel@vger.kernel.org
X-Gmane-NNTP-Posting-Host: ool-4356fe48.dyn.optonline.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040401
X-Accept-Language: en-us, en
In-Reply-To: <1080897252.30361.147.camel@dhcppc4>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown wrote:
> On Thu, 2004-04-01 at 14:24, sean wrote:
> 
>>I have a VIA k400 motherboard.
>>
> 
> 
>>irq 16: nobody cared!
>>Call Trace:
>>  [<c0108508>] __report_bad_irq+0x28/0x80
........................
>>handlers:
>>[<c0395800>] (snd_cmipci_interrupt+0x0/0x130)
>>Disabling IRQ #16
>>..............

> 
> Does acpi=off make a difference and change how /proc/interrupts looks?
> 
> If yes, can you try the latest ACPI code that 2.6.5 is missing?
> http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.5/
> 
> thanks,
> -Len

Correct on all counts. acpi=off changed how /proc/interrupts looked.

Plain rc3-bk2:

cat /proc/interrupts
            CPU0
   0:   24465969    IO-APIC-edge  timer
   1:       3894    IO-APIC-edge  i8042
   2:          0          XT-PIC  cascade
   8:          1    IO-APIC-edge  rtc
   9:          0   IO-APIC-level  acpi
  11:          0    IO-APIC-edge  ohci1394, radeon@PCI:1:0:0
  12:     208554    IO-APIC-edge  i8042
  14:     484633    IO-APIC-edge  ide0
  15:         24    IO-APIC-edge  ide1
  16:     100000   IO-APIC-level  CMI8738-MC6
  18:      96443   IO-APIC-level  eth1
  21:          0   IO-APIC-level  ehci_hcd, uhci_hcd, uhci_hcd, uhci_hcd

With acpi=off:

cat /proc/interrupts
            CPU0
   0:     411879    IO-APIC-edge  timer
   1:       1037    IO-APIC-edge  i8042
   2:          0          XT-PIC  cascade
   8:          1    IO-APIC-edge  rtc
  12:      15358    IO-APIC-edge  i8042
  14:      13668    IO-APIC-edge  ide0
  15:         24    IO-APIC-edge  ide1
  16:      21258   IO-APIC-level  ohci1394, CMI8738-MC6, radeon@PCI:1:0:0
  18:        404   IO-APIC-level  eth1
  21:          0   IO-APIC-level  ehci_hcd, uhci_hcd, uhci_hcd, uhci_hcd


And the patch worked.

With the patch:

cat /proc/interrupts
            CPU0
   0:     138277    IO-APIC-edge  timer
   1:        942    IO-APIC-edge  i8042
   2:          0          XT-PIC  cascade
   8:          1    IO-APIC-edge  rtc
   9:          0   IO-APIC-level  acpi
  12:        918    IO-APIC-edge  i8042
  14:      11189    IO-APIC-edge  ide0
  15:         24    IO-APIC-edge  ide1
  16:       7731   IO-APIC-level  ohci1394, CMI8738-MC6, radeon@PCI:1:0:0
  18:        177   IO-APIC-level  eth1
  21:          0   IO-APIC-level  ehci_hcd, uhci_hcd, uhci_hcd, uhci_hcd


Thanks for all your help. When should we see the patch in the kernel?

sean

