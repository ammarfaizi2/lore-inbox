Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261949AbUBWQnN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 11:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261952AbUBWQnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 11:43:12 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:54014 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S261949AbUBWQnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 11:43:06 -0500
Date: Tue, 24 Feb 2004 00:42:57 +0800
From: "Michael Frank" <mhf@linuxmail.org>
To: "Bill Davidsen" <davidsen@tmr.com>, "Krzysztof Halasa" <khc@pm.waw.pl>
Subject: Re: ACPI and ISA IRQ 9, Linux 2.4
Cc: linux-kernel@vger.kernel.org
References: <m3isi3n9wa.fsf@defiant.pm.waw.pl> <403A25B0.5090104@tmr.com>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opr3t0pvx24evsfm@smtp.pacific.net.th>
In-Reply-To: <403A25B0.5090104@tmr.com>
User-Agent: Opera M2/7.50 (Linux, build 600)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Feb 2004 11:09:20 -0500, Bill Davidsen <davidsen@tmr.com> wrote:

> Krzysztof Halasa wrote:
>> Hi,
>>
>> I think this is a known problem, but I don't know how to fix it:
>>
>> I have a dual Pentium-2 machine (non-SCSI Asus P2B-D), latest BIOS with
>> ACPI etc. It has an ISA card (serial port) using IRQ 9 (I can't change
>> the IRQ). It works fine without ACPI, Linux 2.4 lists IRQ 9 as
>> APIC edge-triggered.
>>
>> With acpi=force (due to BIOS date) IRQ 9 is used by ACPI. /proc/interrupts
>> lists it as APIC level-triggered, and the ISA card no longer generates
>> interrupts.
>>
>> IRQ 9 is set to "ISA" in BIOS setup. acpi_irq_isa=9 doesn't help.
>>
>> Is is possible to fix it? Or is it just impossible to use ISA IRQ 9
>> with ACPI?
>>
>> More details available on request, of course.
>
> I have a similar problem, and my aha1520 can't be moved off irq9 without
> cutting traces on the system board. How bad is it without ACPI at all? I
> tried that for a while, and several other things didn't work, and it
> looks as if the aha1520 driver won't share irq anyway, and something
> else (I forget) wants that irq as well.
>
> I boot into 2.4 to do backups, fortunately the only thing on the SCSI.
>
>

Try to reduce or eliminate IRQ sharing.

See also Documentation/kernel-parameters.txt

acpi_irq_balance essentially disables PCI IRQ sharing as long as there
are enough IRQs available .

acpi_irq_pci adds IRQs to the list of IRQs allocatable to PCI.

acpi_irq_isa adds IRQs to the list of IRQs allocatable to ISA.

If you have unused ISA IRQs, in particular 3,4,5,6,7 such as HW wo serial,
printer and ancient sound and need IRQ9 on isa, put this on the kernel
command line:

	acpi_irq_balance acpi_irq_pci=3,4,5,6,7 acpi_irq_isa=9

Adjust the lists of IRQs to suit your HW, eg if you got ttyS0 on ISA take
out IRQ4 on PCI and move it to the ISA side.

Hopefully with a bit of experimenting the problems mentioned can be solved.

For testing it is suggested to also put init=/bin/sh on the command line
to avoid a full boot.

I like to use the opportunity to thank Len Brown to have implemented these
functions which greatly enhance the flexibility of ACPI IRQ management :)


Regards
Michael

