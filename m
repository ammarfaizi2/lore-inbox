Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261510AbSJMMPy>; Sun, 13 Oct 2002 08:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261511AbSJMMPy>; Sun, 13 Oct 2002 08:15:54 -0400
Received: from smtp.mailix.net ([216.148.213.132]:63708 "EHLO smtp.mailix.net")
	by vger.kernel.org with ESMTP id <S261510AbSJMMPw>;
	Sun, 13 Oct 2002 08:15:52 -0400
Date: Sun, 13 Oct 2002 14:21:39 +0200
From: Alex Riesen <fork0@users.sf.net>
To: Greg Kroah-Hartman <greg@kroah.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: 2.5.42-ac1: modprobe uhci-hcd: sleeping function called from illegal context
Message-ID: <20021013122139.GA377@steel>
Reply-To: Alex Riesen <fork0@users.sf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just tried "modprobe uhci-hcd". Nothing evil observed besides that.

syslog:
Oct 13 13:04:08 steel kernel: drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.0
Oct 13 13:04:08 steel kernel: PCI: Found IRQ 10 for device 00:04.2
Oct 13 13:04:08 steel kernel: PCI: Sharing IRQ 10 with 00:04.3
Oct 13 13:04:08 steel kernel: PCI: Sharing IRQ 10 with 00:0f.0
Oct 13 13:04:08 steel kernel: drivers/usb/core/hcd-pci.c: uhci-hcd @ 00:04.2, VIA Technologies, Inc. USB
Oct 13 13:04:08 steel kernel: drivers/usb/core/hcd-pci.c: irq 10, io base 0000b400
Oct 13 13:04:08 steel kernel: drivers/usb/core/hcd.c: new USB bus registered, assigned bus number 1
Oct 13 13:04:08 steel kernel: drivers/usb/core/hub.c: USB hub found at 0
Oct 13 13:04:08 steel kernel: drivers/usb/core/hub.c: 2 ports detected
Oct 13 13:04:08 steel kernel: PCI: Found IRQ 10 for device 00:04.3
Oct 13 13:04:08 steel kernel: PCI: Sharing IRQ 10 with 00:04.2
Oct 13 13:04:08 steel kernel: PCI: Sharing IRQ 10 with 00:0f.0
Oct 13 13:04:08 steel kernel: drivers/usb/core/hcd-pci.c: uhci-hcd @ 00:04.3, VIA Technologies, Inc. USB (#2)
Oct 13 13:04:08 steel kernel: drivers/usb/core/hcd-pci.c: irq 10, io base 0000b000
Oct 13 13:04:08 steel kernel: drivers/usb/core/hcd.c: new USB bus registered, assigned bus number 2
Oct 13 13:04:08 steel kernel: drivers/usb/core/hub.c: USB hub found at 0
Oct 13 13:04:08 steel kernel: drivers/usb/core/hub.c: 2 ports detected
Oct 13 13:04:09 steel kernel: Debug: sleeping function called from illegal context at include/asm/semaphore.h:119
Oct 13 13:04:09 steel kernel: Call Trace:
Oct 13 13:04:09 steel kernel:  [<c0116184>] __might_sleep+0x54/0x60
Oct 13 13:04:09 steel kernel:  [<dc846f56>] .rodata+0x1056/0x1a74 [usbcore]
Oct 13 13:04:09 steel kernel:  [<dc8419dd>] usb_hub_events+0x65/0x2b8 [usbcore]
Oct 13 13:04:09 steel kernel:  [<dc846f56>] .rodata+0x1056/0x1a74 [usbcore]
Oct 13 13:04:09 steel kernel:  [<dc841c65>] usb_hub_thread+0x35/0xe0 [usbcore]
Oct 13 13:04:09 steel kernel:  [<dc841c30>] usb_hub_thread+0x0/0xe0 [usbcore]
Oct 13 13:04:09 steel kernel:  [<c0114f60>] default_wake_function+0x0/0x34
Oct 13 13:04:09 steel kernel:  [<dc84c9ec>] khubd_wait+0x4/0xc [usbcore]
Oct 13 13:04:09 steel kernel:  [<dc84c9ec>] khubd_wait+0x4/0xc [usbcore]
Oct 13 13:04:09 steel kernel:  [<c01054a9>] kernel_thread_helper+0x5/0xc
Oct 13 13:04:09 steel kernel: 
Oct 13 13:04:09 steel kernel: drivers/usb/core/hub.c: new USB device 00:04.2-2, assigned address 2


some of /proc/pci:

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, Inc. VT8605 [ProSavage PM133] (rev 129).
      Prefetchable 32 bit memory at 0xf8000000 [0xfbffffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT8605 [PM133 AGP] (rev 0).
      Master Capable.  No bursts.  Min Gnt=8.
  Bus  0, device   4, function  0:
    ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 34).
  Bus  0, device   4, function  1:
    IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE (rev 16).
      Master Capable.  Latency=32.  
      I/O at 0xb800 [0xb80f].

  Bus  0, device   4, function  2:
    USB Controller: VIA Technologies, Inc. USB (rev 16).
      IRQ 10.
      Master Capable.  Latency=32.  
      I/O at 0xb400 [0xb41f].
  Bus  0, device   4, function  3:
    USB Controller: VIA Technologies, Inc. USB (#2) (rev 16).
      IRQ 10.
      Master Capable.  Latency=32.  
      I/O at 0xb000 [0xb01f].

  Bus  0, device   4, function  4:
    Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 48).


