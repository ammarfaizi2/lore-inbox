Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262027AbUDZPhl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262027AbUDZPhl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 11:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbUDZPhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 11:37:41 -0400
Received: from host16.apollohosting.com ([209.239.37.142]:54429 "EHLO
	host16.apollohosting.com") by vger.kernel.org with ESMTP
	id S262027AbUDZPhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 11:37:38 -0400
To: "OGAWA Hirofumi" <hirofumi@mail.parknet.co.jp>
Cc: "Linux Kernel ML" <linux-kernel@vger.kernel.org>
Subject: Re: 8139too not working in 2.6 (works now)
References: <opr62ahdvlpsnffn@mail.mcaserta.com> <87oeperj4y.fsf@devron.myhome.or.jp> <opr62jbzk9psnffn@mail.mcaserta.com> <878ygirctm.fsf@devron.myhome.or.jp>
Message-ID: <opr62lomnxpsnffn@mail.mcaserta.com>
Date: Mon, 26 Apr 2004 17:37:24 +0200
From: "Mirko Caserta" <mirko@mcaserta.com>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
In-Reply-To: <878ygirctm.fsf@devron.myhome.or.jp>
User-Agent: Opera M2/7.50 (Linux, build 663)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I tried "acpi=off" and it worked like a charm. He's the new  
/proc/interrupts:

carbon:~# cat /proc/interrupts
            CPU0       CPU1
   0:     857627         12    IO-APIC-edge  timer
   1:       1073          0    IO-APIC-edge  i8042
   2:          0          0          XT-PIC  cascade
   8:          1          1    IO-APIC-edge  rtc
  12:         87          0    IO-APIC-edge  i8042
  14:       4103          2    IO-APIC-edge  ide0
  15:       4900          2    IO-APIC-edge  ide1
  21:       4505          1   IO-APIC-level  eth0
  27:       1484          0   IO-APIC-level  i91u, uhci_hcd, uhci_hcd,  
uhci_hcd
NMI:          0          0
LOC:     857482     857455
ERR:          0
MIS:          0

Hope this helps someone else too.

Thanks a lot, Mirko.

On Tue, 27 Apr 2004 00:14:29 +0900, OGAWA Hirofumi  
<hirofumi@mail.parknet.co.jp> wrote:

> "Mirko Caserta" <mirko@mcaserta.com> writes:
>
>> Anyway, it doesn't look like an irq problem to me. It looks more like
>> a  wrong detection of the TX triggering level in the driver.
>
> In interrupts-2.6.6-rc2-mm2-broken-out,
>
>            CPU0       CPU1
>   0:     103394         48    IO-APIC-edge  timer
>   1:        157          0    IO-APIC-edge  i8042
>   5:          2          1    IO-APIC-edge  eth0
>                               ^^^^^^^^^^^^-- wrong
>   8:          2          0    IO-APIC-edge  rtc
>   9:          0          0   IO-APIC-level  acpi
>  11:          3          1    IO-APIC-edge  i91u
>  12:         87          0    IO-APIC-edge  i8042
>  14:       1068          2    IO-APIC-edge  ide0
>  15:        953          1    IO-APIC-edge  ide1
>
> The above must be IO-APIC-level.
> And the following is interesting one.
>
>     ACPI: ACPI tables contain no PCI IRQ routing entries
>     PCI: Invalid ACPI-PCI IRQ routing table
>     PCI: Probing PCI hardware
>     PCI: Using IRQ router default [1106/3091] at 0000:00:00.0
>     PCI BIOS passed nonexistent PCI bus 0!
>     PCI BIOS passed nonexistent PCI bus 0!
>     PCI BIOS passed nonexistent PCI bus 0!
>     PCI BIOS passed nonexistent PCI bus 0!
>     PCI BIOS passed nonexistent PCI bus 0!
>     PCI BIOS passed nonexistent PCI bus 1!
>     PCI BIOS passed nonexistent PCI bus 0!
>
> Um.. can you try "pci=noacpi" or "acpi=off"?


