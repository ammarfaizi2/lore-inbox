Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262873AbUDYDHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262873AbUDYDHT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 23:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262810AbUDYDHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 23:07:19 -0400
Received: from fmr99.intel.com ([192.55.52.32]:4801 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S262873AbUDYDHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 23:07:16 -0400
Subject: Re: APIC probs with kernel 2.6.6-rc1-bk2 and usb, bttv
From: Len Brown <len.brown@intel.com>
To: Roessner Christian <info@roessner-net.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615F9864@hdsmsx403.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615F9864@hdsmsx403.hd.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Organization: 
Message-Id: <1082862426.3163.30.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 24 Apr 2004 23:07:07 -0400
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-04-23 at 11:51, Roessner Christian wrote:
> Hello,
> 
> in the meantime I have tested kernel 2.6.6-rc2, but still no luck. I
> also played around with acpi_irq_nobalance and pci=noacpi, etc. But
> this does not fix it (Don´t know wht to do with flags, tagged as
> IA-32, because mine is a AMD64)

Tagged where?  These flags apply equally to both architectures.

> Maybe I forget something in my attached logfile: I use a Gigabyte K8N
> Pro with a NForce3 chipset.

Chances are good that with nforce3 you'll have some of the same problems
that nforce2 users have.

          CPU0       
  0:     345800          XT-PIC  timer
  1:       1452    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  8:          0    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 12:         50    IO-APIC-edge  i8042
 14:       6155    IO-APIC-edge  ide0
 15:         42    IO-APIC-edge  ide1
 16:        678   IO-APIC-level  bttv0, nvidia
 17:        147   IO-APIC-level  aic7xxx, libata
 18:        227   IO-APIC-level  eth0, b1pci-9c00
 19:          7   IO-APIC-level  eth1
 20:          0   IO-APIC-level  ohci_hcd
 21:          0   IO-APIC-level  ehci_hcd
 22:       1806   IO-APIC-level  NVidia nForce3, ohci_hcd

If you run the latest -mm patch, you can fix the XT-PIC timer
by passing "acpi_skip_timer_override" on the cmdline.

RE: USB is totally dead.
you've got a number of controllers, are they all dead.
hard to tell if the last one if taking the interrupts,
or if that is your sound.  perhaps you can disable sound
and see if IRQ22 becomes quiescent.

Re: TV station change freezes system.
Does it also freeze the system if you boot with "noapic"?

cheers,
-Len


