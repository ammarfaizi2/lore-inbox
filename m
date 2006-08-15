Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030347AbWHOPTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030347AbWHOPTV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 11:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030346AbWHOPTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 11:19:21 -0400
Received: from spirit.analogic.com ([204.178.40.4]:30224 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1030343AbWHOPTU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 11:19:20 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 15 Aug 2006 15:19:18.0298 (UTC) FILETIME=[2D2D17A0:01C6C07E]
Content-class: urn:content-classes:message
Subject: Re: What determines which interrupts are shared under Linux?
Date: Tue, 15 Aug 2006 11:19:18 -0400
Message-ID: <Pine.LNX.4.61.0608151103190.29526@chaos.analogic.com>
In-Reply-To: <44E1D760.6070600@atipa.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: What determines which interrupts are shared under Linux?
thread-index: AcbAfi00H53yhtoJRfyNJvAIRIp1DA==
References: <44E1D760.6070600@atipa.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Roger Heflin" <rheflin@atipa.com>
Cc: "Linux-Kernel" <linux-kernel@vger.kernel.org>, <linux-ide@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 Aug 2006, Roger Heflin wrote:

> Hello,
>
> On Linux when interrupts are defined similar to below, what defines say
> ide2, ide3 to be on the same interrupt?    The bios, linux, the driver using
> the interrupt?    And can that be controlled/overrode at the
> kernel/driver level?
>
> I have identified that the disks that are shared on ide2, ide3 do funny
> things when both are being heavily used (dma_expiry), this is an older
> driver versions
> but I have experienced it before with a lot newer driver, and a bios
> adjustment
> previously fixed a similar issue, so that may be what is needed in this
> case also,
> I am not sure how they fixed it, but I suspect that the setup the interrupt
> to not be shared.   I have a large number of machines and under heavy
> loads all
> seem to duplicate the issue, and it always happens with the disks on
> ide2/ide3,
> never on the disk connected to ide4.
>
>            CPU0       CPU1       CPU2       CPU3
>   0:   56616921    5359998    7002142     938817          XT-PIC  timer
>   1:          8         88         96          0    IO-APIC-edge  i8042
>   2:          0          0          0          0          XT-PIC  cascade
>   4:       2091        100        208       2477    IO-APIC-edge  serial
>   8:          0          0          0          0    IO-APIC-edge  rtc
>   9:          0          0          0          0   IO-APIC-level  acpi
>  20:          0          0          0          0   IO-APIC-level  ehci_hcd
>  21:          0        950     401419     414482   IO-APIC-level  ide4,
> ohci_hcd
>  22:       1165    1704243     576247       6796   IO-APIC-level  ide2,
> ide3
>  47:      65971          0          0          0   IO-APIC-level  eth0
> NMI:          1          1          1          1
> LOC:   69904264   69877733   69879541   69901903
> ERR:          0
> MIS:        105
>
>
>                                       Roger

The hardware defines what traces go to whatever chips on the
motherboard and to the feature module sockets. Sometimes,
the ultimate IRQ that these traces go to can be configured in the
BIOS. Sometimes not. The kernel just uses what was set up by
the BIOS, convention, and the PCI devices themselves.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.62 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
