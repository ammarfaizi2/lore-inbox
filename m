Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751597AbWIPOje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597AbWIPOje (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 10:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751604AbWIPOje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 10:39:34 -0400
Received: from mx2.rowland.org ([192.131.102.7]:33031 "HELO mx2.rowland.org")
	by vger.kernel.org with SMTP id S1751590AbWIPOjd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 10:39:33 -0400
Date: Sat, 16 Sep 2006 10:39:33 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Rene Rebe <rene@exactcode.de>
cc: linux-kernel@vger.kernel.org, <linux-usb-devel@lists.sourceforge.net>,
       Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] USB device stopped working - can't set config
 #1, error -71
In-Reply-To: <200609161137.14307.rene@exactcode.de>
Message-ID: <Pine.LNX.4.44L0.0609161033550.7454-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Sep 2006, Rene Rebe wrote:

> Hi all,
> 
> with the latest kernels (definetly 2.6.17 and 1.6.8-rc*, I do now know off 
> hand when this started) I can not access some (I think all USB 1) scanners 
> via my SANE/Avision backend:
> 
> usb 3-1: new full speed USB device using uhci_hcd and address 2
> usb 3-1: configuration #1 chosen from 1 choice
> usb 3-1: can't set config #1, error -71

This is bad already.  All the rest of the stuff below is just more of the 
same.

> write(2, "attach: opening libusb:003:002\n", 31) = 31
> open("/proc/bus/usb/003/002", O_RDWR)   = 4
> ioctl(4, USBDEVFS_SETCONFIGURATION, 0xbfc10c74) = -1 EPROTO (Protocol error)
> close(4)                                = 0
> fstat64(2, {st_mode=S_IFCHR|0600, st_rdev=makedev(136, 1), ...}) = 0
> write(2, "[avision] ", 10)              = 10
> write(2, "attach: open failed (Invalid arg"..., 39) = 39
> 
> Currently this is on an x86 Apple MacBook:
> 
> Bus 005 Device 002: ID 05ac:1000 Apple Computer
> Bus 005 Device 001: ID 0000:0000 Virtual Hub
> Bus 004 Device 002: ID 05ac:8240 Apple Computer
> Bus 004 Device 001: ID 0000:0000 Virtual Hub
> Bus 003 Device 001: ID 0000:0000 Virtual Hub
> Bus 002 Device 002: ID 05ac:0218 Apple Computer
> Bus 002 Device 001: ID 0000:0000 Virtual Hub
> Bus 001 Device 009: ID 05ac:020c Apple Computer
> Bus 001 Device 008: ID 046d:c00c Logitech Inc. Optical Wheel Mouse
> Bus 001 Device 007: ID 05ac:1003 Apple Computer
> Bus 001 Device 004: ID 05ac:8300 Apple Computer
> Bus 001 Device 002: ID 05e3:0606 Genesys Logic, Inc.
> Bus 001 Device 001: ID 0000:0000 Virtual Hub
> 
> While this simple lsusb is enough to trigger the issue:
> 
> usb 3-1: new full speed USB device using uhci_hcd and address 3
> usb 3-1: configuration #1 chosen from 1 choice
> usb 3-1: can't set config #1, error -71
> 
> And the affected devices do not appear in the lsusb output.
> 
> Btw: I saw a patch related to usb1 devics behind usb2 hubs, but
> I think it made no difference here.
> 
> Btw2: I also do not see the standard bluetooth USB HCI that is suppost to be 
> in the MacBook and that is listed and works fine in OS X.

Try using usbmon to watch what happens when you plug in your scanner.  
Instructions are in the kernel source file Documentation/usb/usbmon.txt.

Alan Stern

