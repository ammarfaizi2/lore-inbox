Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263295AbTJKMFd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 08:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263300AbTJKMFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 08:05:32 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:16372 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263295AbTJKMFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 08:05:14 -0400
Date: Sat, 11 Oct 2003 14:05:08 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: dbrownell@users.sourceforge.net
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: [2.4 patch] add USB gadget Configure help entries
Message-ID: <20031011120508.GU24300@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.4.23-pre7 USB gadget support was added but no Configure.help 
entries were added.

The patch below adds these missing entries. the help texts were copied 
from 2.6, please check whether they are correct for 2.4, too.

cu
Adrian

--- linux-2.4.23-pre7-full/Documentation/Configure.help.old	2003-10-11 13:54:06.000000000 +0200
+++ linux-2.4.23-pre7-full/Documentation/Configure.help	2003-10-11 14:00:55.000000000 +0200
@@ -15776,6 +15776,88 @@
   The module will be called speedtch.o. If you want to compile it as
   a module, say M here and read <file:Documentation/modules.txt>.
 
+CONFIG_USB_GADGET
+  USB is a master/slave protocol, organized with one master
+  host (such as a PC) controlling up to 127 peripheral devices.
+  The USB hardware is asymmetric, which makes it easier to set up:
+  you can't connect two "to-the-host" connectors to each other.
+
+  Linux can run in the host, or in the peripheral.  In both cases
+  you need a low level bus controller driver, and some software
+  talking to it.  Peripheral controllers are often discrete silicon,
+  or are integrated with the CPU in a microcontroller.  The more
+  familiar host side controllers have names like like "EHCI", "OHCI",
+  or "UHCI", and are usually integrated into southbridges on PC
+  motherboards.
+
+  Enable this configuration option if you want to run Linux inside
+  a USB peripheral device.  Configure one hardware driver for your
+  peripheral/device side bus controller, and a "gadget driver" for
+  your peripheral protocol.  (If you use modular gadget drivers,
+  you may configure more than one.)
+
+  If in doubt, say "N" and don't enable these drivers; most people
+  don't have this kind of hardware (except maybe inside Linux PDAs).
+
+CONFIG_USB_NET2280
+  NetChip 2280 is a PCI based USB peripheral controller which
+  supports both full and high speed USB 2.0 data transfers.  
+           
+  It has six configurable endpoints, as well as endpoint zero
+  (for control transfers) and several endpoints with dedicated
+  functions.
+
+  Say "y" to link the driver statically, or "m" to build a
+  dynamically linked module called "net2280" and force all
+  gadget drivers to also be dynamically linked.
+
+CONFIG_USB_ZERO
+  Gadget Zero is a two-configuration device.  It either sinks and
+  sources bulk data; or it loops back a configurable number of
+  transfers.  It also implements control requests, for "chapter 9"
+  conformance.  The driver needs only two bulk-capable endpoints, so
+  it can work on top of most device-side usb controllers.  It's
+  useful for testing, and is also a working example showing how
+  USB "gadget drivers" can be written.
+
+  Make this be the first driver you try using on top of any new
+  USB peripheral controller driver.  Then you can use host-side
+  test software, like the "usbtest" driver, to put your hardware
+  and its driver through a basic set of functional tests.
+
+  Gadget Zero also works with the host-side "usb-skeleton" driver,
+  and with many kinds of host-side test software.  You may need
+  to tweak product and vendor IDs before host software knows about
+  this device, and arrange to select an appropriate configuration.
+
+  Say "y" to link the driver statically, or "m" to build a
+  dynamically linked module called "g_zero".
+
+CONFIG_USB_ETH
+  This driver implements Ethernet style communication, in either
+  of two ways:
+          
+   - The "Communication Device Class" (CDC) Ethernet Control Model.
+     That protocol is often avoided with pure Ethernet adapters, in
+     favor of simpler vendor-specific hardware, but is widely
+     supported by firmware for smart network devices.
+
+   - On hardware can't implement that protocol, a simpler approach
+     is used, placing fewer demands on USB.
+
+   Within the USB device, this gadget driver exposes a network device
+   "usbX", where X depends on what other networking devices you have.
+   Treat it like a two-node Ethernet link:  host, and gadget.
+
+   The Linux-USB host-side "usbnet" driver interoperates with this
+   driver, so that deep I/O queues can be supported.  On 2.4 kernels,
+   use "CDCEther" instead, if you're using the CDC option. That CDC
+   mode should also interoperate with standard CDC Ethernet class
+   drivers on other host operating systems.
+
+   Say "y" to link the driver statically, or "m" to build a
+   dynamically linked module called "g_ether".
+
 Always do synchronous disk IO for UBD
 CONFIG_BLK_DEV_UBD_SYNC
   The User-Mode Linux port includes a driver called UBD which will let
