Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266648AbUJNKrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266648AbUJNKrS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 06:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266650AbUJNKrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 06:47:18 -0400
Received: from prosun.first.fraunhofer.de ([194.95.168.2]:36761 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S266648AbUJNKrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 06:47:14 -0400
Subject: Re: hang after resume with adb: starting probe task.
From: Soeren Sonnenburg <kernel@nn7.de>
To: Benjamin Herrenschmidt <benh@KERNEL.CRASHING.ORG>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1097283818.3646.7.camel@gaston>
References: <1097172895.3281.31.camel@localhost>
	 <1097189899.16161.6.camel@gaston>  <1097234268.3339.27.camel@localhost>
	 <1097283818.3646.7.camel@gaston>
Content-Type: text/plain
Date: Thu, 14 Oct 2004 11:33:49 +0200
Message-Id: <1097746429.4328.10.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-09 at 11:03 +1000, Benjamin Herrenschmidt wrote:
> > Actually there was nothing plugged into the ethernet nor usb port. Could
> > it also be the airport failing ? I still use orinoco cvs, i.e. airport
> > 0.15rc2HEAD, but that one also on 2.6.8.1. 
> > 
> > I now have a more or less reliable way of making this pbook crash: put
> > it to sleep and wake it up as soon it is sleeping.
> 
> Difficult to say at this point. One thing possible is to add printk's
> (or more violent btext_drawstring) when calling the sleep / wakeup
> callbacks of drivers in drivers/base/power/* and drivers/macintosh/via-pmu.c
> and try to figure where precisely it dies.

Well, I now realize that I turned on CONFIG_USB_SUSPEND which also
caused slightly different kernel messages. I turned this option off
again and had no crash since then (for 4 days).


w/o CONFIG_USB_SUSPEND:
========================
eth1: Airport entering sleep mode
eth0: suspending, WakeOnLan disabled
radeonfb: suspending to state: 3...
agpgart: Putting AGP V2 device at 0000:00:0b.0 into 0x mode
agpgart: Putting AGP V2 device at 0000:00:10.0 into 0x mode
radeonfb: switching to D2 state...
cpufreq: resume failed to assert current frequency is what timing core thinks it
 is.
radeonfb: switching to D0 state...
radeonfb: resumed !
eth1: get_wireless_stats() called while device not present
enable_irq(27) unbalanced
enable_irq(28) unbalanced
eth0: resuming
eth1: get_wireless_stats() called while device not present
eth1: Airport waking up
ide_pmac: Set UDMA timing for mode 4, reg: 0x0c50038c
hda: Enabling Ultra DMA 4
hdc: MDMA, cycleTime: 120, accessTime: 90, recTime: 30
hdc: Set MDMA timing for mode 2, reg: 0x00011d26
hdc: Enabling MultiWord DMA 2
adb: starting probe task...
adb devices: [2]: 2 c4 [3]: 3 1 [7]: 7 1f
ADB keyboard at 2, handler 1
ADB mouse at 3, handler set to 4 (trackpad)
adb: finished probe task...
PHY ID: 2060e1, addr: 0

with CONFIG_USB_SUSPEND:
========================
ohci_hcd 0001:10:19.0: Unlink after no-IRQ?  Different ACPI or APIC settings may help.
ohci_hcd 0001:10:18.0: Unlink after no-IRQ?  Different ACPI or APIC settings may help.
eth1: Airport entering sleep mode
eth0: suspending, WakeOnLan disabled
radeonfb: suspending to state: 3...
agpgart: Putting AGP V2 device at 0000:00:0b.0 into 0x mode
agpgart: Putting AGP V2 device at 0000:00:10.0 into 0x mode
radeonfb: switching to D2 state...
cpufreq: resume failed to assert current frequency is what timing core thinks it is.
radeonfb: switching to D0 state...
radeonfb: resumed !
enable_irq(27) unbalanced
enable_irq(28) unbalanced
eth0: resuming
eth1: Airport waking up
ide_pmac: Set UDMA timing for mode 4, reg: 0x0c50038c
hda: Enabling Ultra DMA 4
hdc: MDMA, cycleTime: 120, accessTime: 90, recTime: 30
hdc: Set MDMA timing for mode 2, reg: 0x00011d26
hdc: Enabling MultiWord DMA 2
hub 1-0:1.0: reactivate --> -22
hub 2-0:1.0: reactivate --> -22
adb: starting probe task...
adb devices: [2]: 2 c4 [3]: 3 1 [7]: 7 1f
ADB keyboard at 2, handler 1
ADB mouse at 3, handler set to 4 (trackpad)
adb: finished probe task...
PHY ID: 2060e1, addr: 0
 
Soeren
-- 
Sometimes, there's a moment as you're waking, when you become aware of
the real world around you, but you're still dreaming.

