Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030392AbWHORba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030392AbWHORba (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 13:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030396AbWHORb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 13:31:29 -0400
Received: from hqemgate01.nvidia.com ([216.228.112.170]:22594 "EHLO
	HQEMGATE01.nvidia.com") by vger.kernel.org with ESMTP
	id S1030392AbWHORb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 13:31:28 -0400
Date: Tue, 15 Aug 2006 12:31:16 -0500
From: Terence Ripperda <tripperda@nvidia.com>
To: Roger Heflin <rheflin@atipa.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
Subject: Re: What determines which interrupts are shared under Linux?
Message-ID: <20060815173116.GQ7189@hygelac>
Reply-To: Terence Ripperda <tripperda@nvidia.com>
References: <44E1D760.6070600@atipa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E1D760.6070600@atipa.com>
X-Accept-Language: en
X-Operating-System: Linux hrothgar 2.6.15-1-486 
User-Agent: Mutt/1.5.11+cvs20060403
X-OriginalArrivalTime: 15 Aug 2006 17:31:20.0921 (UTC) FILETIME=[9F6D6C90:01C6C090]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


we've seen a lot of problems on ck804 chipsets when multiple devices
share level-triggered interrupts. I think some of the earlier sample
bioses assumed that interrupts would be configured via ACPI, and when
ACPI is not used, the interrupts end up as level-triggered instead of
edge-triggered.

you might investigate whether ACPI is failing to configure your system
(are you on 2.4? updating to 2.6 might help), using the 'noapic'
kernel parameter to force interrupts back to PIC, or the 'irqpoll' kernel
parameter to try to work around the level-triggered interrupts.

Thanks,
Terence


On Tue, Aug 15, 2006 at 09:17:04AM -0500, rheflin@atipa.com wrote:
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
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
