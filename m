Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964943AbWACVh5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964943AbWACVh5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964941AbWACVh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:37:57 -0500
Received: from defout.telus.net ([204.209.205.55]:59832 "EHLO
	priv-edmwes48.telusplanet.net") by vger.kernel.org with ESMTP
	id S964943AbWACVhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:37:55 -0500
From: Rob Dyck <rob.dyck@telus.net>
To: linux-kernel@vger.kernel.org
Subject: Problem: USB phone not detected after disconnect/reconnect
Date: Tue, 3 Jan 2006 13:37:52 -0800
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601031337.52560.rob.dyck@telus.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When USB phone is disconnected and then reconnected the system sometimes does 
not detect it. Another device such as storage is not detected either. I am 
not positive but the problem seems to occur if the USB phone was connected 
during the boot. I do not know if it is relevant but I use APM not ACPI.

Some information I have gathered.
This is the device
usb 3-1: new device strings: Mfr=1, Product=2, SerialNumber=4
usb 3-1: Product: USB Phone
usb 3-1: Manufacturer: BeyondTel
usb 3-1: SerialNumber: 0001

Good disconnect. Four interfaces unregistered.

usb 3-1: USB disconnect, address 7
usb 3-1: usb_disable_device nuking all URBs
usb 3-1: unregistering interface 3-1:1.0
usb 3-1:1.0: hotplug
usb 3-1: unregistering interface 3-1:1.1
usb 3-1:1.1: hotplug
usb 3-1: unregistering interface 3-1:1.2
usb 3-1:1.2: hotplug
usb 3-1: unregistering interface 3-1:1.3
drivers/usb/core/file.c: removing 96 minor
usb 3-1:1.3: hotplug
usb 3-1: unregistering device
usb 3-1: hotplug
hub 3-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x100
uhci_hcd 0000:00:10.1: suspend_rh (auto-stop)

Bad disconnect. interfaces 1.1 1.2 and 1.3 not unregistered

usb 3-1: USB disconnect, address 2
usb 3-1: usb_disable_device nuking all URBs
usb 3-1: unregistering interface 3-1:1.0
uhci_hcd 0000:00:10.1: suspend_rh (auto-stop)

Also /var/log/hotplug/events shows that the OSS audio devices were removed on 
disconnect but the ALSA devices were not. The problem is not specific to 
2.6.15 however I do not know when it started. Perhaps it has always been a 
problem in USB.

Linux fatboy.mylan 2.6.15 #1 PREEMPT Tue Jan 3 11:49:30 PST 2006 i686 athlon 
i386 GNU/Linux

Gnu C                  3.4.2
Gnu make               3.80
binutils               2.15.92.0.2
util-linux             2.12a
mount                  2.12a
module-init-tools      3.1-pre5
e2fsprogs              1.35
reiserfsprogs          line
reiser4progs           line
pcmcia-cs              3.2.7
quota-tools            3.12.
PPP                    2.4.2
isdn4k-utils           3.3
nfs-utils              1.0.6
Linux C Library        2.3.3
Dynamic linker (ldd)   2.3.3
Procps                 3.2.3
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   075
Modules Loaded         parport_pc lp parport autofs4 nfs lockd sunrpc 
af_packet usbhid uhci_hcd ehci_hcd snd_via82xx snd_ac97_codec snd_ac97_bus 
snd_mpu401_uart snd_usb_audio snd_pcm_oss snd_mixer_oss snd_pcm snd_timer 
snd_page_alloc snd_usb_lib snd_rawmidi snd_hwdep snd soundcore

Keywords - USB, hotplug

Output of lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP] Host 
Bridge
00:01.0 PCI bridge: VIA Technologies, Inc. VT8235 PCI Bridge
00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 80)
00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 80)
00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 80)
00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 
AC97 Audio Controller (rev 50)
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 74)
01:00.0 VGA compatible controller: nVidia Corporation NV5M64 [RIVA TNT2 Model 
64/Model 64 Pro] (rev 15)

lsusb just hangs.

