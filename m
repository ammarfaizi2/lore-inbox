Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262342AbVGFXZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262342AbVGFXZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 19:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262339AbVGFXXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 19:23:30 -0400
Received: from main.gmane.org ([80.91.229.2]:48551 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262546AbVGFXV4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 19:21:56 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Alexander Fieroch <fieroch@web.de>
Subject: Re: PROBLEM: "drive appears confused" and "irq 18: nobody cared!"
Date: Thu, 07 Jul 2005 01:20:52 +0200
Message-ID: <42CC6754.8050208@web.de>
References: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04C30@USRV-EXCH4.na.uis.unisys.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090505040608030900070801"
X-Complaints-To: usenet@sea.gmane.org
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       bzolnier@gmail.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, axboe@suse.de,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@osdl.org>
X-Gmane-NNTP-Posting-Host: osten.wh.uni-dortmund.de
User-Agent: Debian Thunderbird 1.0.2 (X11/20050611)
X-Accept-Language: de-de, en-us, en
In-Reply-To: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04C30@USRV-EXCH4.na.uis.unisys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090505040608030900070801
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Protasevich, Natalie wrote:
> Hi Alexander,
> To me, it looks like both IDE channels get wrong IRQ. Didn't you
> verified previously that when you go without IDE the system boots up OK?

Yes it does. That's the way I'm currently using linux.

> They get some interrupts because when IRQ 201 occurs triggered by USB,
> the handler for ide runs also, since it is shared with both ide and
> uhci. (Can you also attach output for "cat /proc/interrupts" please).

Ah, acknowledged. IDE and USB iterrupts are shared. /proc/interrupts is 
attached.

>> >Then I would try forth-feeding IRQ 14 to the IDE.
>>
>>I don't know how to do that.
> 
> I was going to put some code together for you over the weekend, but got
> caught up in other things, sorry. 

No problem. I just wanted to know that the problem is not forgotten.

> The idea was to forcibly assign IRQ 14
> for ide0 and IRQ 15 for ide1 in the ide driver, setup-pci.c (just for
> diagnostics and proof of concept so to speak) and see if devices become
> sane.
> I will try tweaking it tonight. I need to make sure it works on my
> system first and if it does I will send you the code. 

> Thanks,
> --Natalie

No, thank you for working on that problem!

Regards,
Alexander

--------------090505040608030900070801
Content-Type: text/plain;
 name="interrupts"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="interrupts"

           CPU0       CPU1       
  0:     143266          0    IO-APIC-edge  timer
  1:        908          0    IO-APIC-edge  i8042
  7:          0          0    IO-APIC-edge  parport0
  8:          0          0    IO-APIC-edge  rtc
  9:          0          0   IO-APIC-level  acpi
 10:          0          0    IO-APIC-edge  MPU401 UART
169:       1857          0   IO-APIC-level  skge, uhci_hcd:usb5, HDA Intel
177:          3          0   IO-APIC-level  bttv0
185:        365          0   IO-APIC-level  ide2, ehci_hcd:usb1, uhci_hcd:usb2
193:      13324          0   IO-APIC-level  libata, uhci_hcd:usb3
201:    1600000          0   IO-APIC-level  ide0, uhci_hcd:usb4
209:          3          0   IO-APIC-level  ohci1394, Ensoniq AudioPCI
NMI:         51          1 
LOC:     140268     140272 
ERR:          1
MIS:          0

--------------090505040608030900070801--

