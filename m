Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264146AbSIRDNI>; Tue, 17 Sep 2002 23:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264145AbSIRDNI>; Tue, 17 Sep 2002 23:13:08 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:15091 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S264047AbSIRDNG>; Tue, 17 Sep 2002 23:13:06 -0400
Message-ID: <3D87FFCC.6040003@attbi.com>
Date: Tue, 17 Sep 2002 23:23:40 -0500
From: Daya Cooppan <dcooppan@attbi.com>
Reply-To: dcooppan@attbi.com
Organization: Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel 2.4.19 error with usbcore.o 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I think there is a bug in kernel 2.4.19 under the usb section. I 
proceeded to build kernel 2.4.19 on a RH7.3, DELL SMP system. I have a 
wireless usb mouse, usb SanDisk, etc. Anyway the problem showed up when 
I was trying to get the usb mouse to work. This is not a new system ...I 
did have all the hw and sw components working under 2.4.5.

The default for the USB section is to included USB support (y) in the 
kernel. I am assuming the usbcore.o got incorporated into the kernel 
build tree during [make dep; make bzImage; make modules; make 
modules_install]. I continued to get mousedev errors ...verified that I 
had mouse support, hid support, uhci support, all this look good. As 
soon as I changed "USB Support" from (y) to (m), i.e. made usbcore.o a 
loadable module WALLA! usb devices started to work. Question: Is there a 
bug with (y) support for "USB Support" ?

I also noticed usbdrv.o resulted in errors when included (y) in the kernel:
___________________________________
s.o ipc/ipc.o \
         drivers/parport/driver.o drivers/char/char.o 
drivers/block/block.o drivers/misc/misc.o drivers/net/net.o 
drivers/media/media.o drivers/char/agp/agp.o drivers/char/drm/drm.o 
drivers/ide/idedriver.o drivers/cdrom/driver.o 
drivers/sound/sounddrivers.o drivers/pci/driver.o 
drivers/pcmcia/pcmcia.o drivers/net/pcmcia/pcmcia_net.o 
drivers/pnp/pnp.o drivers/video/video.o drivers/usb/usbdrv.o \
        net/network.o \
        /usr/src/linux-2.4.19/arch/i386/lib/lib.a 
/usr/src/linux-2.4.19/lib/lib.a /usr/src/linux-2.4.19/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
drivers/usb/usbdrv.o: In function `hidinput_hid_event':
drivers/usb/usbdrv.o(.text+0x12b05): undefined reference to `input_event'
drivers/usb/usbdrv.o(.text+0x12bae): undefined reference to `input_event'
drivers/usb/usbdrv.o(.text+0x12c0e): undefined reference to `input_event'
drivers/usb/usbdrv.o(.text+0x12c31): undefined reference to `input_event'
drivers/usb/usbdrv.o(.text+0x12c4f): undefined reference to `input_event'
drivers/usb/usbdrv.o: In function `hidinput_connect':
drivers/usb/usbdrv.o(.text+0x12ebc): undefined reference to 
`input_register_device'
drivers/usb/usbdrv.o: In function `hidinput_hid_event':
drivers/usb/usbdrv.o(.text+0x12b30): undefined reference to `input_event'
drivers/usb/usbdrv.o(.text+0x12b9b): undefined reference to `input_event'
drivers/usb/usbdrv.o(.text+0x12bd6): undefined reference to `input_event'
drivers/usb/usbdrv.o: In function `hidinput_disconnect':
drivers/usb/usbdrv.o(.text+0x12ed9): undefined reference to 
`input_unregister_device'
make: *** [vmlinux] Error 1
_______________

Any ideas ?

Right now I am using usbcore.o as a loadable module and every thing 
works fine.

Please cc me at dcooppan@attbi.com

Take Care,
Daya

