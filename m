Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262157AbVCVWct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262157AbVCVWct (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 17:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbVCVWb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 17:31:27 -0500
Received: from ipx10069.ipxserver.de ([80.190.240.67]:61644 "EHLO codeblau.de")
	by vger.kernel.org with ESMTP id S262257AbVCVW3t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 17:29:49 -0500
Date: Tue, 22 Mar 2005 23:29:43 +0100
From: Felix von Leitner <felix-linuxkernel@fefe.de>
To: Adam Belay <abelay@novell.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       cpufreq@ZenII.linux.org.uk
Subject: Re: 2.6.11: USB broken on nforce4, ipv6 still broken, centrino speedstep even more broken than in 2.6.10
Message-ID: <20050322222943.GA10442@codeblau.de>
References: <20050311202122.GA13205@fefe.de> <20050311173517.7fe95918.akpm@osdl.org> <1110599659.12485.279.camel@localhost.localdomain> <20050321163225.4af1c169.akpm@osdl.org> <1111454454.6633.5.camel@linux.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111454454.6633.5.camel@linux.site>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus spake Adam Belay (abelay@novell.com):
> > > Why not use ACPI for CPU scaling?
> > Felix, did you try this?
> ACPI is the preferred (and only standardized) method of controlling cpu
> throttling on x86 systems.

  1. I don't trust ACPI
  2. my battery runs out quicker with ACPI compared to cpufreq

I _really_ _really_ don't want ACPI.  No, really not.  This is no idle
decision.  My current notebook is the only hardware I have ever seen
enabling ACPI not completely break Linux.  Of all my 10+ machines,
including my other 3 ones that are actually in use.

Which ACPI way to you mean, by the way?  Just enabling ACPI with thermal
and CPU or the cpufreq ACPI driver?  I think I tried that driver and did
not get the /sys interface to switch frequencies and governors.  If I
must, I can try again with 2.6.11, but I really really really do not
want to use ACPI, unless someone with a big shotgun is standing behind
me.

> Also, as I said earlier, I wanted to see an lspci for the usb issues.

0000:00:00.0 Memory controller: nVidia Corporation CK804 Memory Controller (rev a3)
0000:00:01.0 ISA bridge: nVidia Corporation: Unknown device 0050 (rev a3)
0000:00:01.1 SMBus: nVidia Corporation CK804 SMBus (rev a2)
0000:00:02.0 USB Controller: nVidia Corporation CK804 USB Controller (rev a2)
0000:00:02.1 USB Controller: nVidia Corporation CK804 USB Controller (rev a3)
0000:00:04.0 Multimedia audio controller: nVidia Corporation CK804 AC'97 Audio Controller (rev a2)
0000:00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev a2)
0000:00:07.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev a3)
0000:00:08.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev a3)
0000:00:09.0 PCI bridge: nVidia Corporation CK804 PCI Bridge (rev a2)
0000:00:0a.0 Bridge: nVidia Corporation CK804 Ethernet Controller (rev a3)
0000:00:0b.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
0000:00:0c.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
0000:00:0d.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
0000:00:0e.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
0000:01:00.0 VGA compatible controller: nVidia Corporation: Unknown device 0141 (rev a2)
0000:05:0b.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link)
0000:05:0c.0 Ethernet controller: Marvell Technology Group Ltd. Gigabit Ethernet Controller (rev 13)

This kernel is stock 2.6.11 with CONFIG_USB_DEBUG=y.

When I put in my USB hub with my USB webcam, I get this:

Mar 22 23:25:40 demilich kernel: hub 1-0:1.0: state 5 ports 10 chg 0000 evt 0400
Mar 22 23:25:40 demilich kernel: ehci_hcd 0000:00:02.1: GetStatus port 10 status 001803 POWER sig=j  CSC CONNECT
Mar 22 23:25:40 demilich kernel: hub 1-0:1.0: port 10, status 0501, change 0001, 480 Mb/s
Mar 22 23:25:40 demilich kernel: hub 1-0:1.0: debounce: port 10: total 100ms stable 100ms status 0x501
Mar 22 23:25:40 demilich kernel: ehci_hcd 0000:00:02.1: port 10 high speed
Mar 22 23:25:40 demilich kernel: ehci_hcd 0000:00:02.1: GetStatus port 10 status 001005 POWER sig=se0  PE CONNECT
Mar 22 23:25:40 demilich kernel: usb 1-10: new high speed USB device using ehci_hcd and address 3
Mar 22 23:25:40 demilich kernel: ehci_hcd 0000:00:02.1: port 10 reset error -110
Mar 22 23:25:40 demilich kernel: hub 1-0:1.0: hub_port_status failed (err = -32)
Mar 22 23:25:40 demilich kernel: hub 1-0:1.0: port 10 not enabled, trying reset again...
Mar 22 23:25:40 demilich kernel: ehci_hcd 0000:00:02.1: port 10 reset error -110
Mar 22 23:25:40 demilich kernel: hub 1-0:1.0: hub_port_status failed (err = -32)
Mar 22 23:25:40 demilich kernel: hub 1-0:1.0: port 10 not enabled, trying reset again...
Mar 22 23:25:40 demilich kernel: ehci_hcd 0000:00:02.1: port 10 reset error -110
Mar 22 23:25:40 demilich kernel: hub 1-0:1.0: hub_port_status failed (err = -32)
Mar 22 23:25:40 demilich kernel: hub 1-0:1.0: port 10 not enabled, trying reset again...
Mar 22 23:25:41 demilich kernel: ehci_hcd 0000:00:02.1: port 10 high speed
Mar 22 23:25:41 demilich kernel: ehci_hcd 0000:00:02.1: GetStatus port 10 status 001005 POWER sig=se0  PE CONNECT
Mar 22 23:25:41 demilich kernel: usb 1-10: new device strings: Mfr=0, Product=0, SerialNumber=0
Mar 22 23:25:41 demilich kernel: usb 1-10: hotplug
Mar 22 23:25:41 demilich kernel: usb 1-10: adding 1-10:1.0 (config #1, interface 0)
Mar 22 23:25:41 demilich kernel: usb 1-10:1.0: hotplug

(the line with Mfr=0 looks wrong to me).

Now pulling the device and putting it on through my USB hub (same hardware port
on the mainboard), I get:

Mar 22 23:27:04 demilich kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Mar 22 23:27:04 demilich kernel: hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
Mar 22 23:27:04 demilich kernel: ide: failed opcode was: unknown
Mar 22 23:27:51 demilich kernel: hub 1-0:1.0: state 5 ports 10 chg 0000 evt 0400
Mar 22 23:27:51 demilich kernel: ehci_hcd 0000:00:02.1: GetStatus port 10 status 001002 POWER sig=se0  CSC
Mar 22 23:27:51 demilich kernel: hub 1-0:1.0: port 10, status 0100, change 0001, 12 Mb/s
Mar 22 23:27:51 demilich kernel: usb 1-10: USB disconnect, address 3
Mar 22 23:27:51 demilich kernel: usb 1-10: usb_disable_device nuking all URBs
Mar 22 23:27:51 demilich kernel: usb 1-10: unregistering interface 1-10:1.0
Mar 22 23:27:51 demilich kernel: usb 1-10:1.0: hotplug
Mar 22 23:27:51 demilich kernel: usb 1-10: unregistering device
Mar 22 23:27:51 demilich kernel: usb 1-10: hotplug
Mar 22 23:27:51 demilich kernel: hub 1-0:1.0: debounce: port 10: total 100ms stable 100ms status 0x100
Mar 22 23:28:36 demilich kernel: hub 1-0:1.0: state 5 ports 10 chg 0000 evt 0400
Mar 22 23:28:36 demilich kernel: ehci_hcd 0000:00:02.1: GetStatus port 10 status 001803 POWER sig=j  CSC CONNECT
Mar 22 23:28:36 demilich kernel: hub 1-0:1.0: port 10, status 0501, change 0001, 480 Mb/s
Mar 22 23:28:36 demilich kernel: hub 1-0:1.0: debounce: port 10: total 100ms stable 100ms status 0x501
Mar 22 23:28:36 demilich kernel: ehci_hcd 0000:00:02.1: port 10 reset error -110
Mar 22 23:28:36 demilich kernel: hub 1-0:1.0: hub_port_status failed (err = -32)
Mar 22 23:28:36 demilich kernel: hub 1-0:1.0: port 10 not enabled, trying reset again...
Mar 22 23:28:37 demilich kernel: ehci_hcd 0000:00:02.1: port 10 full speed --> companion
Mar 22 23:28:37 demilich kernel: ehci_hcd 0000:00:02.1: GetStatus port 10 status 003001 POWER OWNER sig=se0  CONNECT
Mar 22 23:28:37 demilich kernel: hub 1-0:1.0: state 5 ports 10 chg 0000 evt 0400
Mar 22 23:28:37 demilich kernel: ehci_hcd 0000:00:02.1: GetStatus port 10 status 001002 POWER sig=se0  CSC
Mar 22 23:28:37 demilich kernel: hub 1-0:1.0: port 10, status 0100, change 0001, 12 Mb/s
Mar 22 23:28:37 demilich kernel: hub 1-0:1.0: debounce: port 10: total 100ms stable 100ms status 0x100

Now the webcam gets power (the light is on) but lsusb does not show it
and the device is suddenly only full speed, not high speed.

Felix
