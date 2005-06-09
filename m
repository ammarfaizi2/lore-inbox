Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262433AbVFIRze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262433AbVFIRze (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 13:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262432AbVFIRzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 13:55:33 -0400
Received: from umbar.esa.informatik.tu-darmstadt.de ([130.83.163.30]:17280
	"EHLO umbar.esa.informatik.tu-darmstadt.de") by vger.kernel.org
	with ESMTP id S262433AbVFIRya (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 13:54:30 -0400
Date: Thu, 9 Jun 2005 19:54:29 +0200
From: Andreas Koch <koch@esa.informatik.tu-darmstadt.de>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andreas Koch <koch@esa.informatik.tu-darmstadt.de>,
       Linus Torvalds <torvalds@osdl.org>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: PROBLEM: Devices behind PCI Express-to-PCI bridge not mapped
Message-ID: <20050609175429.GA26023@erebor.esa.informatik.tu-darmstadt.de>
References: <20050604022600.GA8221@erebor.esa.informatik.tu-darmstadt.de> <Pine.LNX.4.58.0506032149130.1876@ppc970.osdl.org> <20050604155742.GA14384@erebor.esa.informatik.tu-darmstadt.de> <20050605204645.A28422@jurassic.park.msu.ru> <20050606002739.GA943@erebor.esa.informatik.tu-darmstadt.de> <20050606184335.A30338@jurassic.park.msu.ru> <20050608173409.GA32004@erebor.esa.informatik.tu-darmstadt.de> <20050609023639.A7067@jurassic.park.msu.ru> <1118289850.6850.164.camel@gaston> <20050609175441.C9187@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050609175441.C9187@jurassic.park.msu.ru>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So, I managed to test Ivan's latest patch. The machine still hangs,
but a little bit later in the boot process.

Observations thus far:

1) After Ivan's sanity checks in pcibios_allocate_bus_resources get
executed (with the same results I described in a prior mail), I get a
number of messages stating that for the devices on
0000:03:{02,03,04,05}.x, resource regions could not be assigned.
These are the devices in the docking station (behind the PCIE-PCI bridge).

2) Later, I get messages that bogus ressources of 0000:00:1e.0 are ignored

3) Then, the output of pci_setup_bus_bridge begins. It indicates that
for the bridges 0000:00:1c.0, 1c.1 and 1e.0, the characteristics IO,
MEM and PREFETCH are disabled. This is the direct result of Ivan's
latest patch. NOTE: 0000:00:1c._2_, the bridge to the external PCIE,
_does_ appear to have valid data for IO, MEM and PREFETCH.

4) Since the messages of ohci1394 with regard to 0xff reads from the
external FireWire controller persist, I assume that the external
devices can still not be successfully memory mapped.

5) With this latest patch, the boot process proceeds beyond the attempt
of initializing the external CardBus bridge 0000:03:05.0 (which fails
as before `no PCI interrupts. Fish ...' to the initialization of the
internal CardBus bridge. After a `socket status: 3000006' and ACPI PCI
interrupt assignment messages, the machine hangs with no further output.

I regret that I cannot be more specific. But since this machine's
serial port is _on the external dock_, I cannot even provide full logs
obtained by SERIAL_CONSOLE. If you want me to look for specific things in
the output (that I can capture by inserting loop-based pauses at specific
places in in the boot process), I'll gladly do so.

Andreas

