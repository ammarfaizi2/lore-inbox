Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965374AbWHOOQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965374AbWHOOQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 10:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965377AbWHOOQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 10:16:59 -0400
Received: from 125.14.cm.sunflower.com ([24.124.14.125]:36743 "EHLO
	mail.atipa.com") by vger.kernel.org with ESMTP id S965373AbWHOOQ6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 10:16:58 -0400
Message-ID: <44E1D760.6070600@atipa.com>
Date: Tue, 15 Aug 2006 09:17:04 -0500
From: Roger Heflin <rheflin@atipa.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
Subject: What determines which interrupts are shared under Linux?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Aug 2006 14:17:16.0109 (UTC) FILETIME=[82941FD0:01C6C075]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Linux when interrupts are defined similar to below, what defines say
ide2, ide3 to be on the same interrupt?    The bios, linux, the driver using
the interrupt?    And can that be controlled/overrode at the 
kernel/driver level?

I have identified that the disks that are shared on ide2, ide3 do funny
things when both are being heavily used (dma_expiry), this is an older 
driver versions
but I have experienced it before with a lot newer driver, and a bios 
adjustment
previously fixed a similar issue, so that may be what is needed in this 
case also,
I am not sure how they fixed it, but I suspect that the setup the interrupt
to not be shared.   I have a large number of machines and under heavy 
loads all
seem to duplicate the issue, and it always happens with the disks on 
ide2/ide3,
never on the disk connected to ide4.

            CPU0       CPU1       CPU2       CPU3
   0:   56616921    5359998    7002142     938817          XT-PIC  timer
   1:          8         88         96          0    IO-APIC-edge  i8042
   2:          0          0          0          0          XT-PIC  cascade
   4:       2091        100        208       2477    IO-APIC-edge  serial
   8:          0          0          0          0    IO-APIC-edge  rtc
   9:          0          0          0          0   IO-APIC-level  acpi
  20:          0          0          0          0   IO-APIC-level  ehci_hcd
  21:          0        950     401419     414482   IO-APIC-level  ide4, 
ohci_hcd
  22:       1165    1704243     576247       6796   IO-APIC-level  ide2, 
ide3
  47:      65971          0          0          0   IO-APIC-level  eth0
NMI:          1          1          1          1
LOC:   69904264   69877733   69879541   69901903
ERR:          0
MIS:        105


                                       Roger
