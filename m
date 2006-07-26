Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751635AbWGZOXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751635AbWGZOXW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 10:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751638AbWGZOXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 10:23:22 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:40268 "EHLO
	mtaout02-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751630AbWGZOXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 10:23:13 -0400
Message-ID: <44C77CA6.2050807@gentoo.org>
Date: Wed, 26 Jul 2006 15:31:02 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060603)
MIME-Version: 1.0
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Chris Wedgwood <cw@f00f.org>, greg@kroah.com, jeff@garzik.org,
       harmon@ksu.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add SATA device to VIA IRQ quirk fixup list
References: <20060714095233.5678A8B6253@zog.reactivated.net>	 <44B77B1A.6060502@garzik.org> <44B78294.1070308@gentoo.org>	 <44B78538.6030909@garzik.org> <20060714074305.1248b98e.akpm@osdl.org>	 <44BA48A0.2060008@gentoo.org> <20060716183126.GB4483@kroah.com>	 <20060717003418.GA27166@tuatara.stupidest.org>	 <20060724214046.1c1b646e.akpm@osdl.org>	 <1153874577.7559.36.camel@localhost>	 <1153917954.29975.22.camel@bastov.localdomain>	 <44C77544.1050205@gentoo.org> <1153922774.4486.7.camel@localhost.localdomain>
In-Reply-To: <1153922774.4486.7.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergio Monteiro Basto wrote:
> No, Quirks are only need when interrupts are in XT-PIC. (is my bet).
> When APIC and ACPI is enabled (and working) we don't need quirks.
> 
> Someone said on XT-PIC VIA system, don't need, to boot, quirks when ACPI
> is disabled, but this statement don't prove that the quirk aren't need
> it . 

No, please read again:

In the kernels referenced in the bug reports, the quirks were not being 
applied.

When the systems booted up a usual APIC/ACPI config, the hardware in 
question did not work. The quirk was not applied here.

When the system booted up a kernel with acpi=off, the hardware in 
question worked fine. The quirk was not applied here.

When the kernel is modified to apply the quirk again, the system works 
fine in both cases.

IOW, on these systems at least, the quirk is *definitely* needed when 
ACPI/APIC are enabled, whereas in your last mail, you were suggesting we 
should only do the quirk in non-APIC mode:

> I want put here something like:  if ( dev->irq != XT-PIC) return and
> don't quirk this dev.

Such a change would stop the hardware in question from working when 
ACPI/APIC are enabled on these systems.

Daniel

>> http://bugs.gentoo.org/138036
>> http://bugs.gentoo.org/141082

