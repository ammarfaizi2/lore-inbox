Return-Path: <linux-kernel-owner+w=401wt.eu-S1751351AbXAULIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbXAULIw (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 06:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbXAULIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 06:08:52 -0500
Received: from smtpq3.groni1.gr.home.nl ([213.51.130.202]:43146 "EHLO
	smtpq3.groni1.gr.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351AbXAULIv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 06:08:51 -0500
X-Greylist: delayed 2409 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Jan 2007 06:08:51 EST
Message-ID: <8331078.1169375318491.JavaMail.root@webmail2.groni1>
Date: Sun, 21 Jan 2007 11:28:38 +0100
From: <paul.van-de-velde@home.nl>
To: linux-kernel@vger.kernel.org
Subject: Bug with video cards.
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
Sensitivity: Normal
X-Origination-IP: from 84.26.248.70 by webmail-130.home.nl; Sun, 21 Jan 2007 11:28:38 +0100
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear reader,

I would like to report a bug with video cards of which I guess it is located in the kernel (but not certain). It is only happening in FC6 not in Suse 10.2).
However I like FC6 better as Suse 10.2 and I would like to see this bug fixed.

I tried to install a bluecherry PV149 video capture card and after a lot of investigations it turns out the framebuffer address is wrongly set.

The link on which you can follow the issue:
http://www.zoneminder.com/forums/viewtopic.php?t=7836
Also other people with other HW are experiencing the same kind of issues.

Here are some logs:
[root@localhost ~]# dmesg |grep -2 bttv
audit(1168711540.490:2): selinux=0 auid=4294967295
Linux video capture interface: v2.00
bttv: driver version 0.9.16 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
ACPI: PCI Interrupt 0000:03:08.0[A] -> GSI 21 (level, low) -> IRQ 169
bttv0: Bt878 (rev 17) at 0000:03:08.0, irq: 169, latency: 32, mmio: 0xef000000
bttv0: detected: Provideo PV150A-1 [card=98], PCI subsystem ID is aa00:1460
bttv0: using: ProVideo PV150 [card=98,autodetected]
bttv0: gpio: en=00000000, out=00000000 in=00ffffff [init]
bttv0: using tuner=-1
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
bttv0: i2c: checking for TDA9887 @ 0x86... not found
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: PLL: 28636363 => 35468950 .. ok
bttv: Bt8xx card found (1).
ACPI: PCI Interrupt 0000:03:09.0[A] -> GSI 22 (level, low) -> IRQ 193
bttv1: Bt878 (rev 17) at 0000:03:09.0, irq: 193, latency: 32, mmio: 0xee000000
bttv1: detected: Provideo PV150A-2 [card=98], PCI subsystem ID is aa01:1461
bttv1: using: ProVideo PV150 [card=98,autodetected]
bttv1: gpio: en=00000000, out=00000000 in=00ffffff [init]
bttv1: using tuner=-1
bttv1: i2c: checking for TDA9875 @ 0xb0... not found
bttv1: i2c: checking for TDA7432 @ 0x8a... not found
bttv1: i2c: checking for TDA9887 @ 0x86... not found
bttv1: registered device video1
bttv1: registered device vbi1
bttv1: PLL: 28636363 => 35468950 .. ok
bttv: Bt8xx card found (2).
ACPI: PCI Interrupt 0000:03:0a.0[A] -> GSI 23 (level, low) -> IRQ 177
bttv2: Bt878 (rev 17) at 0000:03:0a.0, irq: 177, latency: 32, mmio: 0xed000000
bttv2: detected: Provideo PV150A-3 [card=98], PCI subsystem ID is aa02:1462
bttv2: using: ProVideo PV150 [card=98,autodetected]
bttv2: gpio: en=00000000, out=00000000 in=00ffffff [init]
bttv2: using tuner=-1
bttv2: i2c: checking for TDA9875 @ 0xb0... not found
bttv2: i2c: checking for TDA7432 @ 0x8a... not found
bttv2: i2c: checking for TDA9887 @ 0x86... not found
bttv2: registered device video2
bttv2: registered device vbi2
bttv2: PLL: 28636363 => 35468950 .<6>hdc: ATAPI 40X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
bt878: Unknown symbol bttv_read_gpio
bt878: Unknown symbol bttv_write_gpio
bt878: Unknown symbol bttv_gpio_enable
.<4>bt878: Unknown symbol bttv_read_gpio
bt878: Unknown symbol bttv_write_gpio
bt878: Unknown symbol bttv_gpio_enable
ok
bttv: Bt8xx card found (3).
ACPI: PCI Interrupt 0000:03:0b.0[A] -> GSI 20 (level, low) -> IRQ 201
bttv3: Bt878 (rev 17) at 0000:03:0b.0, irq: 201, latency: 32, mmio: 0xec000000
bttv3: detected: Provideo PV150A-4 [card=98], PCI subsystem ID is aa03:1463
bttv3: using: ProVideo PV150 [card=98,autodetected]
bttv3: gpio: en=00000000, out=00000000 in=00ffffff [init]
bttv3: using tuner=-1
bttv3: i2c: checking for TDA9875 @ 0xb0... not found
bttv3: i2c: checking for TDA7432 @ 0x8a... not found
bttv3: i2c: checking for TDA9887 @ 0x86... not found
bttv3: registered device video3
bttv3: registered device vbi3
bttv3: PLL: 28636363 => 35468950 .<6>hdd: ATAPI 32X CD-ROM CD-R/RW drive, 4096kB Cache, DMA
. ok
bt878: AUDIO driver version 0.0.0 loaded 

root@localhost ffmpeg]# xawtv
This is xawtv-3.95, running on Linux/i686 (2.6.18-1.2849.fc6)
WARNING: v4l-conf is compiled without DGA support.
WARNING: couldn't find framebuffer base address, try manual
configuration ("v4l-conf -a <addr>")
ioctl: VIDIOC_OVERLAY(int=1): Invalid argument
ioctl: VIDIOC_OVERLAY(int=1): Invalid argument
ioctl: VIDIOC_OVERLAY(int=1): Invalid argument
ioctl: VIDIOC_OVERLAY(int=1): Invalid argument 

[root@localhost dev]# xawtv -hwscan
This is xawtv-3.95, running on Linux/i686 (2.6.18-1.2849.fc6)
looking for available devices
/dev/video0: OK [ -device /dev/video0 ]
type : v4l2
name : BT878 video (ProVideo PV150)
flags: overlay capture

/dev/video1: OK [ -device /dev/video1 ]
type : v4l2
name : BT878 video (ProVideo PV150)
flags: overlay capture

/dev/video2: OK [ -device /dev/video2 ]
type : v4l2
name : BT878 video (ProVideo PV150)
flags: overlay capture

/dev/video3: OK [ -device /dev/video3 ]
type : v4l2
name : BT878 video (ProVideo PV150)
flags: overlay capture 

No it is not the HW. I have XAWTV working now. The solution was found under:
http://www.mail-archive.com/mjpeg-users@lists.sourceforge.net/msg07044.html

It seems to be a FC6 issue. You have to find the framebuffer address under /dev/log/Xorg.0.log. Do a search for framebuffer and you will find the address.

The address is 0xF000 0000. One can set it n XAWTV with the command:
v4l-conf -a 0xF0000000. 

Thanks for a solution.

Cheers,

Paul


