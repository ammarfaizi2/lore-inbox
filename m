Return-Path: <linux-kernel-owner+w=401wt.eu-S932460AbXAPJKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbXAPJKU (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 04:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932469AbXAPJKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 04:10:20 -0500
Received: from wr-out-0506.google.com ([64.233.184.229]:2418 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932460AbXAPJKS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 04:10:18 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=kHFtKO2kp/jW23OBZFIT7mwzWatJgC8Tpjkazo8hdIjBg0pnLP/0VddOgUQ30XkgHIePWpG1fdwVrwLLZPEhV9IcuSKVxE/He9qFZ547UcP13T7mucJNGJAfIdZzzzeGzSRVq7WXiGap8bx+t4sKlfX8c46Kq9xcr0dyVz6Qbkw=
Message-ID: <5a2cf1f60701160110v68342cf5lbc364ffae568cd1@mail.gmail.com>
Date: Tue, 16 Jan 2007 10:10:15 +0100
From: "Jerome Lacoste" <jerome.lacoste@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: khubd taking 100% CPU after unproperly removing USB webcam
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I unplugged my (second) webcam, forgotting to stop ekiga, and khubd is
now taking 100% CPU.

- lsusb doesn't return
- /etc/init.d/udev restart didn't resolve the problem.

Is that a problem one may want to investigate or should I just forget
about it (problem being cause by a user error)?

Is there a way for me to:
 - get more information about the problem ? I cannot strace not gdb
attach to the kernel process.
 - solve the issue without restarting the computer
 - should I do something particular before unplugging a USB device (on
windows there's this tray program to stop the USB device), should I
just run some sort of lsof on the device to check if it is safe to
remove it ?

Cheers,

 Jerome

 [Pleased keep me CC'ed]


DETAILS

> uname -a
Linux dolcevita 2.6.17-10-generic #2 SMP Tue Dec 5 22:28:26 UTC 2006
i686 GNU/Linux
> lspci
00:00.0 Host bridge: Intel Corporation 82865G/PE/P DRAM
Controller/Host-Hub Interface (rev 02)
00:02.0 VGA compatible controller: Intel Corporation 82865G Integrated
Graphics Controller (rev 02)
00:1d.0 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB
UHCI Controller #1 (rev 02)
00:1d.1 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB
UHCI Controller #2 (rev 02)
00:1d.2 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB
UHCI Controller #3 (rev 02)
00:1d.3 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB
UHCI Controller #4 (rev 02)
00:1d.7 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB2
EHCI Controller (rev 02)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev c2)
00:1f.0 ISA bridge: Intel Corporation 82801EB/ER (ICH5/ICH5R) LPC
Interface Bridge (rev 02)
00:1f.1 IDE interface: Intel Corporation 82801EB/ER (ICH5/ICH5R) IDE
Controller (rev 02)
00:1f.2 IDE interface: Intel Corporation 82801EB (ICH5) SATA Controller (rev 02)
00:1f.3 SMBus: Intel Corporation 82801EB/ER (ICH5/ICH5R) SMBus
Controller (rev 02)
00:1f.5 Multimedia audio controller: Intel Corporation 82801EB/ER
(ICH5/ICH5R) AC'97 Audio Controller (rev 02)
01:07.0 Serial controller: Rockwell International HCF 56k
Data/Fax/Voice/Spkp (w/Handset) Modem (rev 01)
01:0c.0 Ethernet controller: Intel Corporation 82540EM Gigabit
Ethernet Controller (rev 02)

> dmesg
...
[17238199.732000] usb 3-1: new full speed USB device using uhci_hcd
and address 3
[17238199.924000] usb 3-1: configuration #1 chosen from 1 choice
[17238200.568000] drivers/media/video/spca5xx
/spca5xx-main.c : USB SPCA5XX camera found. Type Flexcam 100 (SPCA561A)
[17238200.576000] usbcore: registered new driver spca5xx
[17238200.576000] drivers/media/video/spca5xx/spca5xx-main.c: spca5xx
driver 00.57.08 registered
[17238225.180000 ] pwc Dumping frame 269.
[17238225.280000] pwc Dumping frame 270.
[17238225.380000] pwc Dumping frame 271.
[17238225.480000] pwc Dumping frame 272.
[17238225.580000] pwc Dumping frame 273.
[17238225.680000] pwc Dumping frame 274.
[17238225.780000] pwc Dumping frame 275.
[17238225.880000] pwc Dumping frame 276.
[17238225.980000] pwc Dumping frame 277.
[17238226.080000] pwc Dumping frame 278.
[17238226.180000] pwc Dumping frame 279.
 [17238226.280000] pwc Dumping frame 280.
[17238230.680000] pwc Closing video device: 325 frames received,
dumped 12 frames, 0 frames with errors.
[17238231.996000] pwc type = 720
[17238232.000000] pwc type = 720
 [17238232.000000] pwc set_video_mode(160x120 @ 10, palette 15).
[17238232.000000] pwc decode_size = 1.
[17238232.000000] pwc Using alternate setting 1.
[17238232.888000] pwc type = 720
[17238232.892000] pwc type = 720
[17238232.892000] pwc set_video_mode(160x120 @ 10, palette 15).
[17238232.892000] pwc decode_size = 1.
[17238232.892000] pwc Using alternate setting 1.
[17238233.468000] pwc type = 720
[17238233.472000] pwc type = 720
[17238233.472000] pwc set_video_mode(160x120 @ 10, palette 15).
[17238233.472000] pwc decode_size = 1.
[17238233.472000] pwc Using alternate setting 1.
[17238233.632000] pwc type = 720
[17238233.632000] pwc type = 720
[17238233.632000] pwc set_video_mode(160x120 @ 10, palette 15).
[17238233.632000] pwc decode_size = 1.
[17238233.632000] pwc Using alternate setting 1.
[17238233.992000] pwc type = 720
[17238233.996000] pwc type = 720
[17238233.996000] pwc set_video_mode(160x120 @ 10, palette 15).
[17238233.996000] pwc decode_size = 1.
[17238233.996000] pwc Using alternate setting 1.
[17238234.736000] pwc type = 720
[17238234.736000] pwc type = 720
[17238234.736000] pwc set_video_mode(160x120 @ 10, palette 15).
[17238234.736000] pwc decode_size = 1.
[17238234.736000] pwc Using alternate setting 1.
[17238446.704000] usb 3-1: USB disconnect, address 3
[17238446.704000] drivers/media/video/spca5xx/spca5xx-main.c:
usb_submit_urb() ret -19
[17238446.704000] drivers/media/video/spca5xx/spca5xx-main.c:
usb_submit_urb() ret -19

(note that the pwc camera is still plugged)
