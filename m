Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261886AbVDESSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261886AbVDESSa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 14:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbVDESSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 14:18:23 -0400
Received: from hammer.engin.umich.edu ([141.213.40.79]:5341 "EHLO
	hammer.engin.umich.edu") by vger.kernel.org with ESMTP
	id S261848AbVDESRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 14:17:45 -0400
Date: Tue, 5 Apr 2005 14:17:36 -0400 (EDT)
From: Christopher Allen Wing <wingc@engin.umich.edu>
To: Andi Kleen <ak@muc.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: clock runs at double speed on x86_64 system w/ATI RS200 chipset
 (with APIC enabled)
In-Reply-To: <m18y3x16rj.fsf@muc.de>
Message-ID: <Pine.LNX.4.58.0504051402590.13242@hammer.engin.umich.edu>
References: <200504031231.j33CVtHp021214@harpo.it.uu.se>
 <Pine.LNX.4.58.0504041050250.32159@hammer.engin.umich.edu> <m18y3x16rj.fsf@muc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I booted with 'apic=debug' in case this is useful to find out what's
wrong.


dmesg of 2.6.11.6 with ACPI enabled, APIC enabled, 'apic=debug':

	http://www-personal.engin.umich.edu/~wingc/apictimer/dmesg/dmesg-2.6.11.6-acpi-apicdebug
	(clock runs at double speed)

dmesg of 2.6.11.6 with ACPI enabled, but disabled for PCI routing, APIC
enabled ('pci=noacpi apic=debug'):

	http://www-personal.engin.umich.edu/~wingc/apictimer/dmesg/dmesg-2.6.11.6-nopciacpi-apicdebug
	(system hangs when loading SATA driver)



One difference I see between ACPI IRQ routing and 'pci=noacpi' is this:

(with ACPI IRQ routing)
	..TIMER: vector=0x31 pin1=2 pin2=-1

(with 'pci=noacpi')
	..TIMER: vector=0x31 pin1=2 pin2=0


so it would seem that mp_irqs[] differs between the ACPI case and
'pci=noacpi' for mp_ExtINT.


-Chris
wingc@engin.umich.edu


On Tue, 5 Apr 2005, Andi Kleen wrote:

> Alternatively you can try to boot with noapic. Does that help?
>
> -Andi
