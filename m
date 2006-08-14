Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751630AbWHNMEA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751630AbWHNMEA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 08:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751994AbWHNMEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 08:04:00 -0400
Received: from us.cactii.net ([66.160.141.151]:14099 "EHLO us.cactii.net")
	by vger.kernel.org with ESMTP id S1751630AbWHNMDz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 08:03:55 -0400
Date: Mon, 14 Aug 2006 14:03:16 +0200
From: Ben B <kernel@bb.cactii.net>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: Andrew Morton <akpm@osdl.org>, Maciej Rutecki <maciej.rutecki@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc4-mm1
Message-ID: <20060814120316.GB13159@cactii.net>
References: <20060813012454.f1d52189.akpm@osdl.org> <20060813121126.b1dc22ee.akpm@osdl.org> <20060813224413.GA21959@cactii.net> <200608132000.21132.dtor@insightbb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200608132000.21132.dtor@insightbb.com>
X-PGP-Key: 3CD061AD
X-PGP-Fingerprint: E092 32CA 6196 7C11 0692  BE43 AEDA 4D47 3CD0 61AD
Jabber-ID: bb@cactii.net
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dtor@insightbb.com> uttered the following thing:
> On Sunday 13 August 2006 18:44, Ben Buxton wrote:
> > > Could be i8042-get-rid-of-polling-timer-v4.patch.  Please try the below
> > > reversion patch, on top of rc4-mm1, thanks.
> > 
> > Acking the same issue. Applied the revert patch and my keyboard now
> > works. Also, it turns out that my keyboard is now the only thing that
> > failed to resume from S3 on my HP Nc6400, but adding "irqpoll" has fixed
> > that for now.
> > 
> 
> Can I please have dmesg of booting unpatched -rc4-mm1 with i8042.debug=1?

I've got masses of these messages - about 100-200 per second filling my
logs. It seems that they came through as such a rate that the dmesg
buffer emptied of everything else before syslogd started.

Aug 14 12:53:23 gromit kernel: [   23.070229] drivers/input/serio/i8042.c: Interrupt 1, without any data [4669]
Aug 14 12:53:23 gromit kernel: [   23.070249] drivers/input/serio/i8042.c: Interrupt 12, without any data [4669]
Aug 14 12:53:23 gromit kernel: [   23.074223] drivers/input/serio/i8042.c: Interrupt 1, without any data [4670]
Aug 14 12:53:23 gromit kernel: [   23.074243] drivers/input/serio/i8042.c: Interrupt 12, without any data [4670]
Aug 14 12:53:23 gromit kernel: [   23.078216] drivers/input/serio/i8042.c: Interrupt 1, without any data [4671]
Aug 14 12:53:23 gromit kernel: [   23.078237] drivers/input/serio/i8042.c: Interrupt 12, without any data [4671]
Aug 14 12:53:23 gromit kernel: [   23.082210] drivers/input/serio/i8042.c: Interrupt 1, without any data [4672]

I can try to get a full boot log later when I get home.

The interrupt counts don't actually seem to increase, I checked
/proc/interrupts several times in a row and there's no change to the
8042 interrupt counts:

root@gromit:~# cat /proc/interrupts
           CPU0       CPU1
  0:      66050          0    IO-APIC-edge  timer
  1:         10          0    IO-APIC-edge  i8042
  8:          3          0    IO-APIC-edge  rtc
  9:         10          0   IO-APIC-level  acpi
 12:       1796          0    IO-APIC-edge  i8042
 14:         92          0    IO-APIC-edge  libata
 15:          0          0    IO-APIC-edge  libata
 58:       1527       5427         PCI-MSI  libata
 66:         20          0   IO-APIC-level  sdhci:slot0, uhci_hcd:usb2
 74:      22513          0   IO-APIC-level  uhci_hcd:usb1, ehci_hcd:usb5
 82:       1366          0         PCI-MSI  eth0
177:      13870          0   IO-APIC-level  HDA Intel, i915@pci:0000:00:02.0
193:          0          0   IO-APIC-level  uhci_hcd:usb4
201:         30          0   IO-APIC-level  yenta, uhci_hcd:usb3
NMI:          0          0
LOC:      65373      65374
ERR:          0
MIS:          6

