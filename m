Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbTKMXvV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 18:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbTKMXvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 18:51:21 -0500
Received: from smtp.uol.com.br ([200.221.11.52]:34117 "EHLO smtp.uol.com.br")
	by vger.kernel.org with ESMTP id S261270AbTKMXvT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 18:51:19 -0500
Date: Thu, 13 Nov 2003 21:50:58 -0200
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb-devel@lists.sourceforge.net,
       linux-usb-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] [BUG] Still having problems with an USB Drive
Message-ID: <20031113235058.GA997@ime.usp.br>
References: <20031112204609.GA1009@ime.usp.br> <Pine.LNX.4.44L0.0311131218050.949-100000@ida.rowland.org> <20031113233659.GA881@ime.usp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031113233659.GA881@ime.usp.br>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 13 2003, Rogério Brito wrote:
> For the time being, I put new files at http://www.ime.usp.br/~rbrito/usb
> for the situation without any USB devices plugged after a warm boot. I
> hope that they're more helpful than the files I posted before.

Well, I just tried plugging the drive into one of the ports that come
right from the motherboard and the diff relative to what I saw earlier
is the following:

--- /root/dmesg-no-devices-plugged.txt	2003-11-13 20:58:06.000000000 -0200
+++ dmesg-drive-plugged-unplugged-plugged.txt	2003-11-13 21:41:37.000000000 -0200
@@ -228,3 +228,30 @@
 ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
 ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
 drivers/usb/host/uhci-hcd.c: d400: suspend_hc
+drivers/usb/host/uhci-hcd.c: d400: wakeup_hc
+hub 1-0:1.0: port 1, status 101, change 1, 12 Mb/s
+hub 1-0:1.0: debounce: port 1: delay 100ms stable 4 status 0x101
+hub 1-0:1.0: new USB device on port 1, assigned address 2
+usb 1-1: new device strings: Mfr=1, Product=3, SerialNumber=0
+drivers/usb/core/message.c: USB device number 2 default language ID 0x409
+usb 1-1: Product: USB Embedded Hub
+usb 1-1: Manufacturer: Leading Driver Co.,LTD.
+drivers/usb/core/usb.c: usb_hotplug
+usb 1-1: registering 1-1:1.0 (config #1, interface 0)
+drivers/usb/core/usb.c: usb_hotplug
+hub 1-1:1.0: usb_probe_interface
+hub 1-1:1.0: usb_probe_interface - got id
+hub 1-1:1.0: USB hub found
+hub 1-1:1.0: 2 ports detected
+hub 1-1:1.0: compound device; port removable status: FF
+hub 1-1:1.0: individual port power switching
+hub 1-1:1.0: individual port over-current protection
+hub 1-1:1.0: Port indicators are not supported
+hub 1-1:1.0: power on to power good time: 100ms
+hub 1-1:1.0: hub controller current requirement: 100mA
+hub 1-1:1.0: local power source is lost (inactive)
+hub 1-1:1.0: no over-current condition exists
+hub 1-1:1.0: enabling power on all ports
+hub 1-1:1.0: port 1, status 101, change 1, 12 Mb/s
+hub 1-1:1.0: transfer --> -75
+usb 1-1: control timeout on ep0in
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

So, it seems that my drive indeed has an embedded hub in it. After the
lines above, my khubd thread enters the D state.

If I try to issue a "cat /proc/bus/usb/devices" command, it hangs. BTW,
I just received another line saying control timeout on ep0in. :-(

Is there anything else that I can do?


Thank you very much for your attention, Rogério Brito.

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Rogério Brito - rbrito@ime.usp.br - http://www.ime.usp.br/~rbrito
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
