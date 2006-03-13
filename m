Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964818AbWCMWi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbWCMWi0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 17:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbWCMWi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 17:38:26 -0500
Received: from web26915.mail.ukl.yahoo.com ([217.146.177.82]:43695 "HELO
	web26915.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750835AbWCMWiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 17:38:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=L2iL+2gurbVqnah/xJ/W34w89RZWrrehaHchDE7iTKArmN96uok8PnAfcrIlYXOTsDKoykKzAQboHHT78oxQMVKw2lGzFE5RkZ2mQzrxqHXqbVGCA7s7+PYDuurkQ6bNrnWkqnXa32OpJA4dZpRFb3Zw5qYu3ifQ5Goa0QNgcBg=  ;
Message-ID: <20060313223824.79218.qmail@web26915.mail.ukl.yahoo.com>
Date: Mon, 13 Mar 2006 23:38:23 +0100 (CET)
From: Etienne Lorrain <etienne_lorrain@yahoo.fr>
Subject: Re: sis96x compiled in by error: delay of one minute at boot
To: Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org
In-Reply-To: <u12nXjrl.1142250380.8654670.khali@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi Jean Delvare,

--- Jean Delvare <khali@linux-fr.org> wrote:
> On 2006-03-13, Etienne Lorrain wrote:
> > I just forgot to remove CONFIG_I2C_SIS96X=y in my kernel (minimum
> > support possible for my PC hardware based on VIA, no module at all)
> > and get a one minute delay at boot when trying to probe this non
> > existing device in 2.6.16-rc5.
> > Maybe the abscence test should be quicker.
> 
> The SIS96x SMBus is a PCI chip, so if it doesn't exist in a given
> system, no code at all should be executed. So I have a hard time
> believing it takes one minute. How do you know for sure that _this_
> driver causing the delay? Did you actually try to rebuild without
> CONFIG_I2C_SIS96X?

 Sorry, I was just assuming that while probing I2C hardware one per one, if one line
is diplayed for each driver I do not have - then the kernel will at least display
one line if it found something.

 I have this lspci:
etienne@ubuntu:~/linux/linux-2.6.16-rc5-gujin$ lspci
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP] Host Bridge
(rev 80)
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
0000:00:06.0 CardBus bridge: Ricoh Co Ltd RL5c475 (rev 81)
0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
(rev 80)
0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
(rev 80)
0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
(rev 80)
0000:00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
0000:00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C
PIPC Bus Master IDE (rev 06)
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97
Audio Controller (rev 50)
0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV200 QW [Radeon
7500]

 And the fault on an ubuntu 5.10 system when using linux-2.6.16-rc5 is:

Mar 10 19:39:12 ubuntu kernel: [   40.522970] PCI: Via IRQ fixup for 0000:00:10.2, from 9
to 5
Mar 10 19:39:12 ubuntu kernel: [   40.525792] uhci_hcd 0000:00:10.2: UHCI Host Controller
Mar 10 19:39:12 ubuntu kernel: [   40.528663] uhci_hcd 0000:00:10.2: new USB bus
registered, assigned bus number 4
Mar 10 19:39:12 ubuntu kernel: [   40.531529] uhci_hcd 0000:00:10.2: irq 21, io base
0x0000ec00
Mar 10 19:39:12 ubuntu kernel: [   40.534489] usb usb4: configuration #1 chosen from 1
choice
Mar 10 19:39:12 ubuntu kernel: [   40.537419] hub 4-0:1.0: USB hub found
Mar 10 19:39:12 ubuntu kernel: [   40.540284] hub 4-0:1.0: 2 ports detected
Mar 10 19:39:12 ubuntu kernel: [   40.646920] sl811: driver sl811-hcd, 19 May 2005
Mar 10 19:39:12 ubuntu kernel: [   40.886717] usb 2-1: new full speed USB device using
uhci_hcd and address 2
Mar 10 19:39:12 ubuntu kernel: [   41.040225] usb 2-1: configuration #1 chosen from 1
choice
Mar 10 19:39:12 ubuntu kernel: [   41.045260] hub 2-1:1.0: USB hub found
Mar 10 19:39:12 ubuntu kernel: [   41.050218] hub 2-1:1.0: 3 ports detected
Mar 10 19:39:12 ubuntu kernel: [   41.398463] usb 2-2: new low speed USB device using
uhci_hcd and address 3
Mar 10 19:39:12 ubuntu kernel: [   41.605819] usb 2-2: configuration #1 chosen from 1
choice
Mar 10 19:39:12 ubuntu kernel: [   42.129448] usbcore: registered new driver usblp
Mar 10 19:39:12 ubuntu kernel: [   42.132207] drivers/usb/class/usblp.c: v0.13: USB
Printer Device Class driver
Mar 10 19:39:12 ubuntu kernel: [   42.134959] Initializing USB Mass Storage driver...
Mar 10 19:39:12 ubuntu kernel: [   42.137734] usbcore: registered new driver usb-storage
Mar 10 19:39:12 ubuntu kernel: [   42.140486] USB Mass Storage support registered.
Mar 10 19:39:12 ubuntu kernel: [   42.143247] usbcore: registered new driver libusual
Mar 10 19:39:12 ubuntu kernel: [   42.145980] usbcore: registered new driver hiddev
Mar 10 19:39:12 ubuntu kernel: [   42.196484] input: HID 1241:1111 as /class/input/input0
Mar 10 19:39:12 ubuntu kernel: [   42.199159] input: USB HID v1.10 Mouse [HID 1241:1111]
on usb-0000:00:10.0-2
Mar 10 19:39:12 ubuntu kernel: [   42.201870] usbcore: registered new driver usbhid
Mar 10 19:39:12 ubuntu kernel: [   42.204535] drivers/usb/input/hid-core.c: v2.6:USB HID
core driver
Mar 10 19:39:12 ubuntu kernel: [   42.207244] usbcore: registered new driver microtekX6
Mar 10 19:39:12 ubuntu kernel: [   42.209986] mice: PS/2 mouse device common for all mice
Mar 10 19:39:12 ubuntu kernel: [   42.258776] input: AT Translated Set 2 keyboard as
/class/input/input1
Mar 10 19:39:12 ubuntu kernel: [   42.261682] input: PC Speaker as /class/input/input2
Mar 10 19:39:12 ubuntu kernel: [   42.264394] i2c /dev entries driver
Mar 10 19:39:12 ubuntu kernel: [   42.267552] i2c-parport: using default base 0x378
Mar 10 19:39:12 ubuntu kernel: [   42.270260] i2c-pca-isa: i/o base 0x000330. irq 10
Mar 10 19:39:12 ubuntu kernel: [   42.273590] i2c-sis96x version 1.0.0
Mar 10 19:39:12 ubuntu kernel: [  119.507926]  : Detection failed at step 3
Mar 10 19:39:12 ubuntu kernel: [  119.755830] hdaps: supported laptop not found!
Mar 10 19:39:12 ubuntu kernel: [  119.758363] hdaps: driver init failed (ret=-6)!
Mar 10 19:39:12 ubuntu kernel: [  119.775788] md: linear personality registered for level
-1
Mar 10 19:39:12 ubuntu kernel: [  119.778344] md: raid0 personality registered for level
0

 So I did the long way of disabling each I2C driver one per one, the last is the one,
as usual:
 [*] ALI1535
 [*] ALI1563
 [*] ALI15x3
 [*] AMD 756/766/768/8111 and nVidia nForce
 [*]   SMBus multiplexing on the Tyan S4882
 [*] AMD 8111
 [*] Intel 82801 (ICH)
 [*] Intel 810/815 
 [*] Intel PIIX4
 [*] Nvidia nForce2, nForce3 and nForce4
 [*] Parallel port adapter (light)
 [*] S3/VIA (Pro)Savage
 [*] S3 Savage 4
 [*] NatSemi SCx200 ACCESS.bus
 [*] SiS 5595
 [*] SiS 630/730
 [ ] SiS 96x
 [ ] VIA 82C586B
 [ ] VIA 82C596/82C686/823x
 [ ] Voodoo 3
 [ ] PCA9564 on an ISA bus

 Removing the last PCA9564 gives me:
Mar 13 21:46:48 ubuntu kernel: [   47.699704] input: AT Translated Set 2 keyboard as
/class/input/input1
Mar 13 21:46:48 ubuntu kernel: [   47.702667] input: PC Speaker as /class/input/input2
Mar 13 21:46:48 ubuntu kernel: [   47.705445] i2c /dev entries driver
Mar 13 21:46:48 ubuntu kernel: [   47.708637] i2c-parport: using default base 0x378
Mar 13 21:46:48 ubuntu kernel: [   70.366096] hdaps: supported laptop not found!
Mar 13 21:46:48 ubuntu kernel: [   70.368750] hdaps: driver init failed (ret=-6)!

 Which is a strong improvement. Note that I do not have an ISA bus on this machine...

 Following a bit:
removing "Dallas Semiconductor DS1337 and DS1339 Real Time Clock" does nothing
removing "EEPROM reader" changes to:
Mar 13 22:12:54 ubuntu kernel: [   45.365457] input: PC Speaker as /class/input/input2
Mar 13 22:12:54 ubuntu kernel: [   45.368197] i2c /dev entries driver
Mar 13 22:12:54 ubuntu kernel: [   61.957048] rtc8564: cant init ctrl1
Mar 13 22:12:54 ubuntu kernel: [   61.997032]  : Detection failed at step 3
Mar 13 22:12:54 ubuntu kernel: [   62.132994] hdaps: supported laptop not found!
Mar 13 22:12:54 ubuntu kernel: [   62.135578] hdaps: driver init failed (ret=-6)!

 Removing "Philips PCF8574 and PCF8574A" and "Philips PCF8591" (and "Epson 8564 RTC chip"
because of the previous error message) so no more anything in "Miscellaneous I2C Chip
support" and just the "VIA 82C586B" in "I2C Hardware Bus support", I get:

Mar 13 22:21:42 ubuntu kernel: [   72.252791] input: PC Speaker as /class/input/input2
Mar 13 22:21:42 ubuntu kernel: [   72.255555] i2c /dev entries driver
Mar 13 22:21:42 ubuntu kernel: [   72.258868] hdaps: supported laptop not found!
Mar 13 22:21:42 ubuntu kernel: [   72.261560] hdaps: driver init failed (ret=-6)!

 Adding (embedded centric) drivers for (embedded centric) company which respect
international copyright regulations (and so the GPL) is OK; but not if that delays
so much booting...

 Etienne.


	

	
		
___________________________________________________________________________ 
Nouveau : téléphonez moins cher avec Yahoo! Messenger ! Découvez les tarifs exceptionnels pour appeler la France et l'international.
Téléchargez sur http://fr.messenger.yahoo.com
