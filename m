Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261810AbTCaT2f>; Mon, 31 Mar 2003 14:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261819AbTCaT2e>; Mon, 31 Mar 2003 14:28:34 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:29056 "EHLO
	mta4.rcnstx.swbell.net") by vger.kernel.org with ESMTP
	id <S261810AbTCaT2c>; Mon, 31 Mar 2003 14:28:32 -0500
Message-ID: <3E889C26.7010704@pacbell.net>
Date: Mon, 31 Mar 2003 11:51:02 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: linux-usb-devel <linux-usb-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: ANNOUNCE:  Linux "USB Gadget" API and Driver Framework
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

WHAT
     This is a kernel-mode API, and an initial set of drivers for it, that
     helps Linux 2.4 and 2.5 kernels support intelligent "USB Device"
     (peripheral) hardware.

     The code is ready for more general use by the Linux community, including
     development of new drivers.  It supports network connections over USB
     "out of the box", using the NetChip 2280 USB 2.0 high speed controller,
     and is now being used with high speed USB devices running under Linux.

     (Note that such an API is on the 2.5 wishlist.  This is the first such
     API that was designed from the ground up to work with the existing
     host side Linux-USB stack, and to support USB 2.0 high speed devices.)

WHERE
     http://kernel.bkbits.net/~david-b/

	Temporary web page with info, including:
	    - gadget.pdf ... kerneldoc, in PDF format
	    - gadget25-0331.patch ... patch for 2.5
	    - gadget24-0331.patch ... patch for 2.4

     bk://kernel.bkbits.net/david-b/gadget-2.5
     bk://kernel.bkbits.net/david-b/gadget-2.4

	BitKeeper repositories

HELPING
     There are lots of opportunities to write drivers here, both for
     dozens more USB "class" specifications and, if you want to get
     down'n'dirty, for USB device controller hardware.

     Please discuss this on the linux-usb-devel@lists.sourceforge.net
     mailing list, unless/until a new list gets set up.

DETAILS
     Since talking about a "USB Device Driver" becomes ambiguous when
     both sides of the protocol stack can run Linux, Linux-USB developers
     have chosen new terminology.  A "USB Device Driver" is what current
     Linux kernels have:  a Host-side driver.   A Device-side driver is
     instead called a "USB Gadget Driver" ... that's why the new name.

     The API is straightforward and thin, just one new header file to shape
     how "gadget" drivers talk to the underlying controller hardware.  There
     is no "mid-layer" requirement, and all policy for device configuration
     and management goes above this API.  I/O involves just submitting an
     asynchronous request to the relevant endpoint (like URBs but simpler).

     There are currently two USB device controller drivers available
     implementing that API.

	- The "net2280" driver supports the NetChip 2280 controller, which
	  is a PCI device that supports USB 2.0 high speed transfers.
	  (PCI card versions are available for development.)

	- There's a "dummy_hcd" which provides partial emulation (bulk
	  and control transfers) of a controller so that you can do some
	  stages of development without real hardware.  (Maybe with
	  debug assistance from UML.)  2.5 only for now (got patch?).

	  This can emulate three kinds of hardware that are of interest
	  to the Linux community:  the net2280 (as above), the sa1100
	  (found in older PDAs), and the pxa25x (found in newer PDAs).

     There are currently two gadget drivers using that API:

	- "Gadget Zero" helps development and testing.  One configuration
	  sinks or sources data; the other one loops data sent out from
	  the host back in to that host.  Almost any USB controller can
	  support this driver.  You can start a new driver from this one
	  by "clone and modify" (using new vendor and product IDs).

	- There's a CDC Ethernet gadget driver, letting you use USB as a
	  network link.  It talks to the standard Linux "CDCEther" (2.4)
	  or "cdc-ether" (2.5) drivers, or corresponding class drivers
	  that are found on other operating systems.  (It's analagous to
	  the ARM Linux sa1100 "usb-eth" driver; but more standard.)
	
	  You'll want some recent patches to those drivers, or the latest
	  2.5 "usbnet" for performance.  (18+ Mbyte/sec at high speed,
	  using TTCP in one direction, vs 4+ MByte/sec; no tuning yet.)

     Both of those gadget drivers have compile-time configuration support
     to let them work with net2280, pxa25x, or sa1100 usb drivers.  Each
     controller has slightly different endpoint capabilities; gadget drivers
     must choose endpoints and configurations accordingly, and there's no
     point in trying to do that at run time.


