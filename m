Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268279AbUHKWXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268279AbUHKWXo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 18:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268278AbUHKWXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 18:23:43 -0400
Received: from fmr01.intel.com ([192.55.52.18]:4291 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S268279AbUHKWXR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 18:23:17 -0400
Subject: Re: 2.6.8-rc4-mm1 doesn't boot
From: Len Brown <len.brown@intel.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040811215105.GK26174@fs.tum.de>
References: <566B962EB122634D86E6EE29E83DD808182C2B33@hdsmsx403.hd.intel.com>
	 <1092259920.5021.117.camel@dhcppc4>  <20040811215105.GK26174@fs.tum.de>
Content-Type: text/plain
Organization: 
Message-Id: <1092262929.7765.132.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 11 Aug 2004 18:22:09 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does the system have any BIOS settings to enable/disable the floppy?
Is the floppy physically present on the system?

ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 *6 7 10 11 12 14 15)
        ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 6

I assert it is a BIOS bug for the BIOS to set LNKD to
IRQ6 if there is a floppy present and enabled; but fair
game if there is no floppy.  Though perhaps floppy.c
doesn't understand that.

-Len

On Wed, 2004-08-11 at 17:51, Adrian Bunk wrote:
> On Wed, Aug 11, 2004 at 05:32:00PM -0400, Len Brown wrote:
> > I've never understood this floppy IRQ6 business.
> > Apparently it requests IRQ6, but doesn't show up in /proc/interrupts
> > 
> > In any case, dropping a PCI interrupt on IRQ6 would surely break it
> > b/c that would set that IRQ6 to level trigger.
> > 
> > Before this change, did LNKD get set to something other than IRQ6?
> 
> Yes, this is my 2.6.8-rc3-mm1 /proc/interrupts :
> 
> <--  snip  -->
> 
>            CPU0       
>   0:   17615908          XT-PIC  timer
>   1:      22333          XT-PIC  i8042
>   2:          0          XT-PIC  cascade
>   6:      94751          XT-PIC  eth0
>   8:          4          XT-PIC  rtc
>   9:          0          XT-PIC  acpi
>  10:       5119          XT-PIC  ehci_hcd
>  11:    1329292          XT-PIC  Ensoniq AudioPCI, radeon@PCI:1:0:0
>  12:     118130          XT-PIC  i8042
>  14:      44614          XT-PIC  ide0
>  15:         24          XT-PIC  ide1
> NMI:          0 
> ERR:          8
> 
> <--  snip  -->
> 
> 
> > -Len
> 
> cu
> Adrian
> 
> -- 
> 
>        "Is there not promise of rain?" Ling Tan asked suddenly out
>         of the darkness. There had been need of rain for many days.
>        "Only a promise," Lao Er said.
>                                        Pearl S. Buck - Dragon Seed
> 

