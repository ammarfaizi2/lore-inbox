Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268149AbUHTPGI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268149AbUHTPGI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 11:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264973AbUHTPGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 11:06:08 -0400
Received: from smtp012.mail.yahoo.com ([216.136.173.32]:24935 "HELO
	smtp012.mail.yahoo.com") by vger.kernel.org with SMTP
	id S268155AbUHTPAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 11:00:47 -0400
Subject: Re: HCI USB on USB 2.0: hci_usb_intr_rx_submit (works with USB 1.1)
From: "Raf D'Halleweyn" <list@noduck.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Max Krasnyansky <maxk@qualcomm.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <1092990717.18082.60.camel@pegasus>
References: <1091581193.15561.3.camel@alto.dhalleweyn.com>
	 <1092049263.21815.18.camel@pegasus>
	 <1092966777.5230.4.camel@alto.dhalleweyn.com>
	 <1092990717.18082.60.camel@pegasus>
Content-Type: text/plain
Date: Fri, 20 Aug 2004 11:00:39 -0400
Message-Id: <1093014039.28268.10.camel@base>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.93 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-20 at 10:31 +0200, Marcel Holtmann wrote:
> your dongle looks like a Broadcom based dongle. Please include the part
> from /proc/bus/usb/devices matching your device. The main problem is
> that the mini driver and the firmware for the Broadcom dongle can't be
> loaded throught request_firmware() by the bcm203x driver. Check the
> BlueZ webpage for more details and put these files in the correct place.
> 
> Regards
> 
> Marcel

Okay, I had bluez-bluefw installed (Debian package) but it seems that
bluez now uses the standard firmware loading mechanism (request_firmware
()). As such, I copied the BCM2033-FW.bin and BCM2033-MD.hex files from
that package into /usr/lib/hotplug/firmware and removed bluez-bluefw.

However, I cannot find any evidence of the firmware actually being
loaded. I believe that my hotplug install is correctly installed (it can
load the ipw2100 firmware). I added some debugging
to /etc/hotplug/firmware.agent, but couldn't find any evidence of any
firmware being requested for the dongle.

Any suggestions what I could try next? Should I add USB_DEVICE(0x0a12,
0x0001) to the usb_device_id array in bcm203x.c?

BTW this used to work (but maybe this was under 2.4, using bluefw).

Raf.

/proc/bus/usb/devices for 1/19:
T:  Bus=01 Lev=03 Prnt=03 Port=00 Cnt=01 Dev#= 19 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0a12 ProdID=0001 Rev= 4.43
C:* #Ifs= 3 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:  If#= 2 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)


