Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030434AbWALO6D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030434AbWALO6D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 09:58:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030435AbWALO6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 09:58:03 -0500
Received: from relay4.usu.ru ([194.226.235.39]:32650 "EHLO relay4.usu.ru")
	by vger.kernel.org with ESMTP id S1030434AbWALO6A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 09:58:00 -0500
Message-ID: <43C66E82.4030106@ums.usu.ru>
Date: Thu, 12 Jan 2006 19:58:10 +0500
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_ums.usu.ru-27340-1137077863-0001-2"
To: LKML <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: linux-2.6.15-git7: PS/2 keyboard dies on ppp traffic
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.15; AVE: 6.33.0.27; VDF: 6.33.0.117; host: usu2.usu.ru)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_ums.usu.ru-27340-1137077863-0001-2
Content-Type: text/plain; charset=koi8-r; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

the main linux tree started suffering the same bug as described for -mm 
earlier in http://lkml.org/lkml/2005/11/7/147:

if I put load on my system, connect to the Internet using my cellphone 
(/dev/ttyS0) and do something, it stops reacting to PS/2 keyboard 
events, but still understands PS/2 mouse. The PPP load monitor shows 
huge transfer rate (several megabytes per second) consisting of the 
infinitely replicated several last packets. events/0 consumes all the 
CPU. tty buffering revamping patch is the obvious candidate, but I 
haven't tried to revert it yet.

As recommended earlier, I hit Sysrq+T several times. Config ans dmesg 
with the results attached. lspci and lspci -n below:

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo 
PRO133x] (rev c4)
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo 
MVP3/Pro133x AGP]
0000:00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super 
South] (rev 40)
0000:00:07.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
0000:00:07.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 1a)
0000:00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] 
(rev 40)0000:00:0b.0 Communication controller: Lucent Microelectronics 
LT WinModem (rev 02)
0000:00:0d.0 Multimedia audio controller: Fortemedia, Inc Xwave QS3000A 
[FM801] (rev b2)
0000:00:0d.1 Input device controller: Fortemedia, Inc Xwave QS3000A 
[FM801 game port] (rev b2)
0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV280 
[Radeon 9200] (rev 01)

0000:00:00.0 0600: 1106:0691 (rev c4)
0000:00:01.0 0604: 1106:8598
0000:00:07.0 0601: 1106:0686 (rev 40)
0000:00:07.1 0101: 1106:0571 (rev 06)
0000:00:07.2 0c03: 1106:3038 (rev 1a)
0000:00:07.4 0c05: 1106:3057 (rev 40)
0000:00:0b.0 0780: 11c1:044c (rev 02)
0000:00:0d.0 0401: 1319:0801 (rev b2)
0000:00:0d.1 0980: 1319:0802 (rev b2)
0000:01:00.0 0300: 1002:5961 (rev 01)

The test load is the parallel execution of the following:

cat /dev/urandom >/dev/nul
find / -xdev
glxgears
LIBGL_ALWAYS_INDIRECT=1 glxgears
thunderbird

-- 
Alexander E. Patrakov

--=_ums.usu.ru-27340-1137077863-0001-2
Content-Type: text/x-log; name="kern.log"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kern.log"

[   27.644679] lp0: using parport0 (interrupt-driven).
[   27.680500] kobject usbcore: registering. parent: <NULL>, set: module
[   27.680567] kobject_uevent
[   27.680591] fill_kobj_path: path = '/module/usbcore'
[   27.681106] subsystem usb: registering
[   27.681111] kobject usb: registering. parent: <NULL>, set: bus
[   27.681131] kobject devices: registering. parent: usb, set: <NULL>
[   27.681146] kobject drivers: registering. parent: usb, set: <NULL>
[   27.681166] subsystem usb_host: registering
[   27.681170] kobject usb_host: registering. parent: <NULL>, set: class
[   27.681202] subsystem usb: registering
[   27.681206] kobject usb: registering. parent: <NULL>, set: class
[   27.681243] kobject usbfs: registering. parent: <NULL>, set: drivers
[   27.681257] kobject_uevent
[   27.681271] fill_kobj_path: path = '/bus/usb/drivers/usbfs'
[   27.681498] usbcore: registered new driver usbfs
[   27.681512] subsystem usb_device: registering
[   27.681516] kobject usb_device: registering. parent: <NULL>, set: class
[   27.681554] kobject hub: registering. parent: <NULL>, set: drivers
[   27.681567] kobject_uevent
[   27.681580] fill_kobj_path: path = '/bus/usb/drivers/hub'
[   27.681775] usbcore: registered new driver hub
[   27.681908] kobject usb: registering. parent: <NULL>, set: drivers
[   27.681925] kobject_uevent
[   27.681938] fill_kobj_path: path = '/bus/usb/drivers/usb'
[   27.694679] kobject uhci_hcd: registering. parent: <NULL>, set: module
[   27.694739] kobject_uevent
[   27.694761] fill_kobj_path: path = '/module/uhci_hcd'
[   27.695195] USB Universal Host Controller Interface driver v2.3
[   27.695247] kobject uhci_hcd: registering. parent: <NULL>, set: drivers
[   27.695272] kobject_uevent
[   27.695287] fill_kobj_path: path = '/bus/pci/drivers/uhci_hcd'
[   27.695532] PCI: Found IRQ 11 for device 0000:00:07.2
[   27.695551] PCI: Sharing IRQ 11 with 0000:00:0b.0
[   27.695585] uhci_hcd 0000:00:07.2: UHCI Host Controller
[   27.695627] kobject usb_host1: registering. parent: usb_host, set: class_obj
[   27.695671] kobject_uevent
[   27.695686] fill_kobj_path: path = '/class/usb_host/usb_host1'
[   27.695694] fill_kobj_path: path = '/devices/pci0000:00/0000:00:07.2'
[   27.696081] uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
[   27.696102] uhci_hcd 0000:00:07.2: irq 11, io base 0x0000d800
[   27.696305] kobject usb1: registering. parent: 0000:00:07.2, set: devices
[   27.696335] kobject_uevent
[   27.696352] fill_kobj_path: path = '/devices/pci0000:00/0000:00:07.2/usb1'
[   27.696642] kobject ep_00: registering. parent: usb1, set: <NULL>
[   27.696679] usb usb1: configuration #1 chosen from 1 choice
[   27.696699] kobject 1-0:1.0: registering. parent: usb1, set: devices
[   27.696725] kobject_uevent
[   27.696738] fill_kobj_path: path = '/devices/pci0000:00/0000:00:07.2/usb1/1-0:1.0'
[   27.696981] hub 1-0:1.0: USB hub found
[   27.697037] hub 1-0:1.0: 2 ports detected
[   27.797878] kobject ep_81: registering. parent: 1-0:1.0, set: <NULL>
[   27.797945] kobject usbdev1.1: registering. parent: usb_device, set: class_obj
[   27.797974] kobject_uevent
[   27.798011] fill_kobj_path: path = '/class/usb_device/usbdev1.1'
[   27.798019] fill_kobj_path: path = '/devices/pci0000:00/0000:00:07.2/usb1'
[   27.825461] kobject usb_storage: registering. parent: <NULL>, set: module
[   27.825524] kobject_uevent
[   27.825543] fill_kobj_path: path = '/module/usb_storage'
[   27.825997] Initializing USB Mass Storage driver...
[   27.826010] kobject usb-storage: registering. parent: <NULL>, set: drivers
[   27.826045] kobject_uevent
[   27.826063] fill_kobj_path: path = '/bus/usb/drivers/usb-storage'
[   28.003467] usb 1-1: new full speed USB device using uhci_hcd and address 2
[   28.125471] kobject 1-1: registering. parent: usb1, set: devices
[   28.125515] kobject_uevent
[   28.125533] fill_kobj_path: path = '/devices/pci0000:00/0000:00:07.2/usb1/1-1'
[   28.125794] kobject ep_00: registering. parent: 1-1, set: <NULL>
[   28.126459] usb 1-1: configuration #1 chosen from 1 choice
[   28.127457] kobject 1-1:1.0: registering. parent: 1-1, set: devices
[   28.127502] kobject_uevent
[   28.127516] fill_kobj_path: path = '/devices/pci0000:00/0000:00:07.2/usb1/1-1/1-1:1.0'
[   28.127746] kobject ep_81: registering. parent: 1-1:1.0, set: <NULL>
[   28.127786] kobject usbdev1.2: registering. parent: usb_device, set: class_obj
[   28.127816] kobject_uevent
[   28.127829] fill_kobj_path: path = '/class/usb_device/usbdev1.2'
[   28.127839] fill_kobj_path: path = '/devices/pci0000:00/0000:00:07.2/usb1/1-1'
[   28.231121] usbcore: registered new driver usb-storage
[   28.231129] USB Mass Storage support registered.
[   28.250643] kobject sd_mod: registering. parent: <NULL>, set: module
[   28.250701] kobject_uevent
[   28.250722] fill_kobj_path: path = '/module/sd_mod'
[   28.251169] kobject sd: registering. parent: <NULL>, set: drivers
[   28.251186] kobject_uevent
[   28.251204] fill_kobj_path: path = '/bus/scsi/drivers/sd'
[   28.277621] kobject usblp: registering. parent: <NULL>, set: module
[   28.277682] kobject_uevent
[   28.277703] fill_kobj_path: path = '/module/usblp'
[   28.278153] kobject usblp: registering. parent: <NULL>, set: drivers
[   28.278172] kobject_uevent
[   28.278217] fill_kobj_path: path = '/bus/usb/drivers/usblp'
[   28.278442] usbcore: registered new driver usblp
[   28.278450] drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
[   28.292304] kobject mousedev: registering. parent: <NULL>, set: module
[   28.292400] kobject_uevent
[   28.292423] fill_kobj_path: path = '/module/mousedev'
[   28.292842] kobject mice: registering. parent: input, set: class_obj
[   28.292863] kobject_uevent
[   28.292877] fill_kobj_path: path = '/class/input/mice'
[   28.293149] kobject psaux: registering. parent: misc, set: class_obj
[   28.293170] kobject_uevent
[   28.293183] fill_kobj_path: path = '/class/misc/psaux'
[   28.293386] mice: PS/2 mouse device common for all mice
[   28.316370] kobject psmouse: registering. parent: <NULL>, set: module
[   28.316430] kobject_uevent
[   28.316455] fill_kobj_path: path = '/module/psmouse'
[   28.316911] kobject psmouse: registering. parent: <NULL>, set: drivers
[   28.316945] kobject_uevent
[   28.316962] fill_kobj_path: path = '/bus/serio/drivers/psmouse'
[   28.341702] kobject agpgart: registering. parent: <NULL>, set: module
[   28.341763] kobject_uevent
[   28.341783] fill_kobj_path: path = '/module/agpgart'
[   28.342265] Linux agpgart interface v0.101 (c) Dave Jones
[   28.361058] kobject via_agp: registering. parent: <NULL>, set: module
[   28.361104] kobject_uevent
[   28.361121] fill_kobj_path: path = '/module/via_agp'
[   28.361470] kobject agpgart-via: registering. parent: <NULL>, set: drivers
[   28.361492] kobject_uevent
[   28.361510] fill_kobj_path: path = '/bus/pci/drivers/agpgart-via'
[   28.361716] agpgart: Detected VIA Apollo Pro 133 chipset
[   28.366103] kobject agpgart: registering. parent: misc, set: class_obj
[   28.366150] kobject_uevent
[   28.366170] fill_kobj_path: path = '/class/misc/agpgart'
[   28.366424] agpgart: AGP aperture is 64M @ 0xe0000000
[   28.402423] kobject drm: registering. parent: <NULL>, set: module
[   28.402501] kobject_uevent
[   28.402525] fill_kobj_path: path = '/module/drm'
[   28.403012] subsystem drm: registering
[   28.403018] kobject drm: registering. parent: <NULL>, set: class
[   28.403050] [drm] Initialized drm 1.0.0 20040925
[   28.455204] kobject input1: registering. parent: input, set: class_obj
[   28.455260] kobject_uevent
[   28.455279] fill_kobj_path: path = '/class/input/input1'
[   28.455289] fill_kobj_path: path = '/devices/platform/i8042/serio0'
[   28.455666] fill_kobj_path: path = '/class/input/input1'
[   28.455671] input: GenPS/2 Genius <NULL> as /class/input/input1
[   28.455692] kobject mouse0: registering. parent: input1, set: class_obj
[   28.455716] kobject_uevent
[   28.455729] fill_kobj_path: path = '/class/input/input1/mouse0'
[   28.455736] fill_kobj_path: path = '/devices/platform/i8042/serio0'
[   28.462257] kobject radeon: registering. parent: <NULL>, set: module
[   28.462326] kobject_uevent
[   28.462348] fill_kobj_path: path = '/module/radeon'
[   28.463009] kobject card0: registering. parent: drm, set: class_obj
[   28.463040] kobject_uevent
[   28.463060] fill_kobj_path: path = '/class/drm/card0'
[   28.463069] fill_kobj_path: path = '/devices/pci0000:00/0000:00:01.0/0000:01:00.0'
[   28.463291] [drm] Initialized radeon 1.19.0 20050911 on minor 0: 
[   30.880459] kjournald starting.  Commit interval 5 seconds
[   30.880631] EXT3 FS on dm-5, internal journal
[   30.880642] EXT3-fs: mounted filesystem with ordered data mode.
[   30.919236] kjournald starting.  Commit interval 5 seconds
[   30.919372] EXT3 FS on dm-0, internal journal
[   30.919382] EXT3-fs: mounted filesystem with ordered data mode.
[   30.966605] kjournald starting.  Commit interval 5 seconds
[   30.966804] EXT3 FS on dm-2, internal journal
[   30.966813] EXT3-fs: mounted filesystem with ordered data mode.
[   31.020790] kobject reiserfs: registering. parent: <NULL>, set: module
[   31.020860] kobject_uevent
[   31.020884] fill_kobj_path: path = '/module/reiserfs'
[   31.043543] ReiserFS: dm-1: found reiserfs format "3.6" with standard journal
[   31.225840] ReiserFS: dm-1: using ordered data mode
[   31.238461] ReiserFS: dm-1: journal params: device dm-1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   31.243491] ReiserFS: dm-1: checking transaction log (dm-1)
[   31.294842] ReiserFS: dm-1: Using r5 hash to sort names
[   31.365135] kobject fat: registering. parent: <NULL>, set: module
[   31.365200] kobject_uevent
[   31.365223] fill_kobj_path: path = '/module/fat'
[   31.383964] kobject vfat: registering. parent: <NULL>, set: module
[   31.384018] kobject_uevent
[   31.384037] fill_kobj_path: path = '/module/vfat'
[   31.384702] FAT: utf8 is not a recommended IO charset for FAT filesystems, filesystem will be case sensitive!
[   31.401572] kobject nls_cp437: registering. parent: <NULL>, set: module
[   31.401620] kobject_uevent
[   31.401662] fill_kobj_path: path = '/module/nls_cp437'
[   31.417034] kobject nls_utf8: registering. parent: <NULL>, set: module
[   31.417081] kobject_uevent
[   31.417100] fill_kobj_path: path = '/module/nls_utf8'
[   35.060707] kobject vcs2: registering. parent: vc, set: class_obj
[   35.060751] kobject_uevent
[   35.060807] fill_kobj_path: path = '/class/vc/vcs2'
[   35.061106] kobject vcsa2: registering. parent: vc, set: class_obj
[   35.061130] kobject_uevent
[   35.061144] fill_kobj_path: path = '/class/vc/vcsa2'
[   35.061432] kobject_uevent
[   35.061450] fill_kobj_path: path = '/class/vc/vcs2'
[   35.061679] kobject vcs2: cleaning up
[   35.061690] kobject_uevent
[   35.061701] fill_kobj_path: path = '/class/vc/vcsa2'
[   35.061919] kobject vcsa2: cleaning up
[   35.062149] kobject vcs3: registering. parent: vc, set: class_obj
[   35.062174] kobject_uevent
[   35.062189] fill_kobj_path: path = '/class/vc/vcs3'
[   35.062419] kobject vcsa3: registering. parent: vc, set: class_obj
[   35.062437] kobject_uevent
[   35.062450] fill_kobj_path: path = '/class/vc/vcsa3'
[   35.062729] kobject_uevent
[   35.062743] fill_kobj_path: path = '/class/vc/vcs3'
[   35.063001] kobject vcs3: cleaning up
[   35.063011] kobject_uevent
[   35.063023] fill_kobj_path: path = '/class/vc/vcsa3'
[   35.063216] kobject vcsa3: cleaning up
[   35.063456] kobject vcs4: registering. parent: vc, set: class_obj
[   35.063485] kobject_uevent
[   35.063500] fill_kobj_path: path = '/class/vc/vcs4'
[   35.063723] kobject vcsa4: registering. parent: vc, set: class_obj
[   35.063742] kobject_uevent
[   35.063786] fill_kobj_path: path = '/class/vc/vcsa4'
[   35.064081] kobject_uevent
[   35.064095] fill_kobj_path: path = '/class/vc/vcs4'
[   35.064312] kobject vcs4: cleaning up
[   35.064322] kobject_uevent
[   35.064334] fill_kobj_path: path = '/class/vc/vcsa4'
[   35.064526] kobject vcsa4: cleaning up
[   35.064914] kobject vcs5: registering. parent: vc, set: class_obj
[   35.064952] kobject_uevent
[   35.064969] fill_kobj_path: path = '/class/vc/vcs5'
[   35.065212] kobject vcsa5: registering. parent: vc, set: class_obj
[   35.065232] kobject_uevent
[   35.065246] fill_kobj_path: path = '/class/vc/vcsa5'
[   35.065559] kobject_uevent
[   35.065574] fill_kobj_path: path = '/class/vc/vcs5'
[   35.065812] kobject vcs5: cleaning up
[   35.065823] kobject_uevent
[   35.065834] fill_kobj_path: path = '/class/vc/vcsa5'
[   35.066005] kobject vcsa5: cleaning up
[   35.066257] kobject vcs6: registering. parent: vc, set: class_obj
[   35.066287] kobject_uevent
[   35.066301] fill_kobj_path: path = '/class/vc/vcs6'
[   35.066509] kobject vcsa6: registering. parent: vc, set: class_obj
[   35.066529] kobject_uevent
[   35.066542] fill_kobj_path: path = '/class/vc/vcsa6'
[   35.066992] kobject_uevent
[   35.067013] fill_kobj_path: path = '/class/vc/vcs6'
[   35.067255] kobject vcs6: cleaning up
[   35.067267] kobject_uevent
[   35.067279] fill_kobj_path: path = '/class/vc/vcsa6'
[   35.067443] kobject vcsa6: cleaning up
[   35.288888] kobject_uevent
[   35.288921] fill_kobj_path: path = '/class/vc/vcs1'
[   35.289229] kobject vcs1: cleaning up
[   35.289241] kobject_uevent
[   35.289255] fill_kobj_path: path = '/class/vc/vcsa1'
[   35.289497] kobject vcsa1: cleaning up
[   35.321836] kobject vcs1: registering. parent: vc, set: class_obj
[   35.321878] kobject_uevent
[   35.321897] fill_kobj_path: path = '/class/vc/vcs1'
[   35.322198] kobject vcsa1: registering. parent: vc, set: class_obj
[   35.322219] kobject_uevent
[   35.322230] fill_kobj_path: path = '/class/vc/vcsa1'
[   35.322539] kobject_uevent
[   35.322556] fill_kobj_path: path = '/class/vc/vcs1'
[   35.322751] kobject vcs1: cleaning up
[   35.322761] kobject_uevent
[   35.322774] fill_kobj_path: path = '/class/vc/vcsa1'
[   35.322959] kobject vcsa1: cleaning up
[   35.323056] kobject vcs1: registering. parent: vc, set: class_obj
[   35.323078] kobject_uevent
[   35.323089] fill_kobj_path: path = '/class/vc/vcs1'
[   35.323319] kobject vcsa1: registering. parent: vc, set: class_obj
[   35.323337] kobject_uevent
[   35.323348] fill_kobj_path: path = '/class/vc/vcsa1'
[   35.323599] kobject_uevent
[   35.323614] fill_kobj_path: path = '/class/vc/vcs1'
[   35.323803] kobject vcs1: cleaning up
[   35.323811] kobject_uevent
[   35.323825] fill_kobj_path: path = '/class/vc/vcsa1'
[   35.324029] kobject vcsa1: cleaning up
[   35.324116] kobject vcs1: registering. parent: vc, set: class_obj
[   35.324136] kobject_uevent
[   35.324147] fill_kobj_path: path = '/class/vc/vcs1'
[   35.324371] kobject vcsa1: registering. parent: vc, set: class_obj
[   35.324389] kobject_uevent
[   35.324400] fill_kobj_path: path = '/class/vc/vcsa1'
[   35.324715] kobject_uevent
[   35.324730] fill_kobj_path: path = '/class/vc/vcs1'
[   35.324929] kobject vcs1: cleaning up
[   35.324937] kobject_uevent
[   35.324951] fill_kobj_path: path = '/class/vc/vcsa1'
[   35.325153] kobject vcsa1: cleaning up
[   35.326321] kobject vcs1: registering. parent: vc, set: class_obj
[   35.326367] kobject_uevent
[   35.326384] fill_kobj_path: path = '/class/vc/vcs1'
[   35.327476] kobject vcsa1: registering. parent: vc, set: class_obj
[   35.327525] kobject_uevent
[   35.327539] fill_kobj_path: path = '/class/vc/vcsa1'
[   42.129251] kobject vcs2: registering. parent: vc, set: class_obj
[   42.129641] kobject_uevent
[   42.129766] fill_kobj_path: path = '/class/vc/vcs2'
[   42.130222] kobject vcsa2: registering. parent: vc, set: class_obj
[   42.130541] kobject_uevent
[   42.130661] fill_kobj_path: path = '/class/vc/vcsa2'
[   42.133459] kobject vcs3: registering. parent: vc, set: class_obj
[   42.133834] kobject_uevent
[   42.133963] fill_kobj_path: path = '/class/vc/vcs3'
[   42.134376] kobject vcsa3: registering. parent: vc, set: class_obj
[   42.134545] kobject_uevent
[   42.134652] fill_kobj_path: path = '/class/vc/vcsa3'
[   42.138890] kobject vcs4: registering. parent: vc, set: class_obj
[   42.139336] kobject_uevent
[   42.139474] fill_kobj_path: path = '/class/vc/vcs4'
[   42.139871] kobject vcsa4: registering. parent: vc, set: class_obj
[   42.140158] kobject_uevent
[   42.140278] fill_kobj_path: path = '/class/vc/vcsa4'
[   42.146104] kobject vcs6: registering. parent: vc, set: class_obj
[   42.146507] kobject_uevent
[   42.146645] fill_kobj_path: path = '/class/vc/vcs6'
[   42.147226] kobject vcsa6: registering. parent: vc, set: class_obj
[   42.147438] kobject_uevent
[   42.147544] fill_kobj_path: path = '/class/vc/vcsa6'
[   42.149764] kobject vcs5: registering. parent: vc, set: class_obj
[   42.150189] kobject_uevent
[   42.150329] fill_kobj_path: path = '/class/vc/vcs5'
[   42.150693] kobject vcsa5: registering. parent: vc, set: class_obj
[   42.150863] kobject_uevent
[   42.150971] fill_kobj_path: path = '/class/vc/vcsa5'
[   43.440254] kobject vcs7: registering. parent: vc, set: class_obj
[   43.440295] kobject_uevent
[   43.440316] fill_kobj_path: path = '/class/vc/vcs7'
[   43.440776] kobject vcsa7: registering. parent: vc, set: class_obj
[   43.440802] kobject_uevent
[   43.440816] fill_kobj_path: path = '/class/vc/vcsa7'
[   46.245283] mtrr: 0xc0000000,0x10000000 overlaps existing 0xc0000000,0x8000000
[   46.245699] mtrr: 0xc0000000,0x10000000 overlaps existing 0xc0000000,0x8000000
[   46.245948] mtrr: 0xc0000000,0x10000000 overlaps existing 0xc0000000,0x8000000
[   46.246447] agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
[   46.246472] agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
[   46.246514] agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
[   46.278695] [drm] Loading R200 Microcode
[  204.963598] kobject slhc: registering. parent: <NULL>, set: module
[  204.963662] kobject_uevent
[  204.963680] fill_kobj_path: path = '/module/slhc'
[  204.964037] CSLIP: code copyright 1989 Regents of the University of California
[  204.976237] kobject ppp_generic: registering. parent: <NULL>, set: module
[  204.976321] kobject_uevent
[  204.976340] fill_kobj_path: path = '/module/ppp_generic'
[  204.976726] PPP generic driver version 2.4.2
[  204.976747] subsystem ppp: registering
[  204.976750] kobject ppp: registering. parent: <NULL>, set: class
[  204.976777] kobject ppp: registering. parent: ppp, set: class_obj
[  204.976797] kobject_uevent
[  204.976810] fill_kobj_path: path = '/class/ppp/ppp'
[  209.617389] kobject crc_ccitt: registering. parent: <NULL>, set: module
[  209.617445] kobject_uevent
[  209.617462] fill_kobj_path: path = '/module/crc_ccitt'
[  209.760637] kobject ppp_async: registering. parent: <NULL>, set: module
[  209.760713] kobject_uevent
[  209.760732] fill_kobj_path: path = '/module/ppp_async'
[  209.763877] kobject ppp0: registering. parent: net, set: class_obj
[  209.764142] kobject_uevent
[  209.764258] fill_kobj_path: path = '/class/net/ppp0'
[  211.031677] kobject bsd_comp: registering. parent: <NULL>, set: module
[  211.031733] kobject_uevent
[  211.031749] fill_kobj_path: path = '/module/bsd_comp'
[  211.032111] PPP BSD Compression module registered
[  211.310838] kobject ppp_deflate: registering. parent: <NULL>, set: module
[  211.310893] kobject_uevent
[  211.310933] fill_kobj_path: path = '/module/ppp_deflate'
[  211.311322] PPP Deflate Compression module registered
Jan 12 19:29:43 home kernel: n_lock_irqsave+0x22/0x30
[  798.047758]  [<c0131b10>] prepare_to_wait+0x20/0x70
[  798.047769]  [<c02ce7c5>] unix_stream_data_wait+0xd5/0x110
[  798.047777]  [<c0131c40>] autoremove_wake_function+0x0/0x60
[  798.047788]  [<c0131c40>] autoremove_wake_function+0x0/0x60
[  798.047796]  [<c02d28dd>] _spin_unlock_irqrestore+0x1d/0x40
[  798.047806]  [<c02cec3d>] unix_stream_recvmsg+0x43d/0x4c0
[  798.047824]  [<c02d14ef>] __mutex_lock_slowpath+0x27f/0x480
[  798.047834]  [<c02798f1>] do_sock_read+0xa1/0xb0
[  798.047844]  [<c0279a95>] sock_aio_read+0x95/0xa0
[  798.047865]  [<c0161411>] do_sync_read+0xc1/0x110
[  798.047875]  [<c01347bd>] ktime_get+0x1d/0x50
[  798.047892]  [<c0131c40>] autoremove_wake_function+0x0/0x60
[  798.047902]  [<c01e758b>] _atomic_dec_and_lock+0x3b/0x40
[  798.047911]  [<c017fb13>] mntput_no_expire+0x23/0x90
[  798.047922]  [<c0162729>] __fput+0x179/0x1d0
[  798.047932]  [<c01615c4>] vfs_read+0x164/0x180
[  798.047943]  [<c01618c1>] sys_read+0x51/0x80
[  798.047953]  [<c0103315>] syscall_call+0x7/0xb
[  798.047968] cat           D E09F082A  6152  1429      1                1578 (L-TLB)
[  798.047996] d95e5cd4 d90cd030 c03ad5a0 e09f082a 00000001 00000001 00000000 df1b34f8 
[  798.048008]        c14db58c dfc68ab0 000ed1be d51c4596 000000b4 d90cd030 d90cd158 00000c51 
[  798.048020]        c14db554 d95e5d18 c14db58c c012da3a 00200096 c02d2642 c0327d60 fffffdff 
[  798.048033] Call Trace:
[  798.048038]  [<e09f082a>] drm_vbl_send_signals+0x2a/0xba [drm]
[  798.048086]  [<c012da3a>] flush_cpu_workqueue+0x9a/0x1c0
[  798.048094]  [<c02d2642>] _spin_lock_irqsave+0x22/0x30
[  798.048103]  [<c02d2845>] _spin_unlock+0x15/0x30
[  798.048111]  [<c0131c40>] autoremove_wake_function+0x0/0x60
[  798.048121]  [<c0131c40>] autoremove_wake_function+0x0/0x60
[  798.048133]  [<c012db88>] flush_workqueue+0x28/0x30
[  798.048141]  [<c0233052>] release_dev+0x4d2/0x7b0
[  798.048153]  [<c02d2845>] _spin_unlock+0x15/0x30
[  798.048161]  [<c014cfee>] zap_pte_range+0xae/0x230
[  798.048170]  [<c015de5c>] free_block+0xec/0x180
[  798.048178]  [<c01ec310>] memmove+0x50/0x54
[  798.048188]  [<c015bf06>] poison_obj+0x36/0x60
[  798.048198]  [<c02d2845>] _spin_unlock+0x15/0x30
[  798.048206]  [<c02d2b7f>] lock_kernel+0x2f/0x50
[  798.048213]  [<c0233860>] tty_release+0x0/0x20
[  798.048220]  [<c0233874>] tty_release+0x14/0x20
[  798.048226]  [<c0162763>] __fput+0x1b3/0x1d0
[  798.048238]  [<c0160bad>] filp_close+0x4d/0x80
[  798.048248]  [<c011ebc4>] put_files_struct+0x74/0xb0
[  798.048259]  [<c011f945>] do_exit+0x125/0x440
[  798.048270]  [<c011fcdc>] do_group_exit+0x3c/0xb0
[  798.048280]  [<c0129643>] get_signal_to_deliver+0x243/0x350
[  798.048292]  [<c010311f>] do_signal+0x8f/0x120
[  798.048304]  [<c01ec72c>] copy_to_user+0x6c/0x90
[  798.048314]  [<c022fb09>] extract_entropy_user+0x89/0xf0
[  798.048333]  [<c02d27eb>] _spin_lock+0x1b/0x30
[  798.048344]  [<c0161577>] vfs_read+0x117/0x180
[  798.048355]  [<c01618c1>] sys_read+0x51/0x80
[  798.048365]  [<c01031e7>] do_notify_resume+0x37/0x3c
[  798.048372]  [<c01033a6>] work_notifysig+0x13/0x19
[  798.048387] bash          S C0335160  6900  1459   1424          1467  1425 (NOTLB)
[  798.048416] d975be88 da53ea90 c03ad5a0 c0335160 1ee55e6c 0002c36b de41fbe0 dae8a050 
[  798.048428]        dae8a050 dae8a050 00000512 dac7e1b3 000000b0 da53ea90 da53ebb8 7fffffff 
[  798.048440]        d97bcb64 7fffffff d97bcb58 c02d0fc9 dae8a050 00200046 00000001 d97bccb8 
[  798.048453] Call Trace:
[  798.048465]  [<c02d0fc9>] schedule_timeout+0xa9/0xb0
[  798.048474]  [<c02d2642>] _spin_lock_irqsave+0x22/0x30
[  798.048483]  [<c02d28dd>] _spin_unlock_irqrestore+0x1d/0x40
[  798.048492]  [<c02376d3>] read_chan+0x513/0x610
[  798.048499]  [<c01196a7>] __wake_up_locked+0x27/0x30
[  798.048511]  [<c0119590>] default_wake_function+0x0/0x20
[  798.048519]  [<c02d28dd>] _spin_unlock_irqrestore+0x1d/0x40
[  798.048528]  [<c0119590>] default_wake_function+0x0/0x20
[  798.048537]  [<c02d2bf6>] .text.lock.kernel_lock+0x2b/0x3a
[  798.048546]  [<c0231ff1>] tty_read+0xe1/0xf0
[  798.048557]  [<c016150e>] vfs_read+0xae/0x180
[  798.048568]  [<c01618c1>] sys_read+0x51/0x80
[  798.048579]  [<c0103315>] syscall_call+0x7/0xb
[  798.048593] bash          S C0335160  7016  1467   1424          1548  1459 (NOTLB)
[  798.048623] d7c29e88 d9819580 c03ad5a0 c0335160 11de9c18 0000bef1 de41fbe0 dae8a050 
[  798.048636]        dae8a050 d9819ab0 00000713 bc460012 0000002f d9819580 d98196a8 7fffffff 
[  798.048648]        d97bc358 7fffffff d97bc34c c02d0fc9 c0101a93 dae8a210 d9819580 d97bc4ac 
[  798.048661] Call Trace:
[  798.048673]  [<c02d0fc9>] schedule_timeout+0xa9/0xb0
[  798.048680]  [<c0101a93>] __switch_to+0x23/0x220
[  798.048688]  [<c02d2642>] _spin_lock_irqsave+0x22/0x30
[  798.048697]  [<c02d28dd>] _spin_unlock_irqrestore+0x1d/0x40
[  798.048706]  [<c02376d3>] read_chan+0x513/0x610
[  798.048718]  [<c0119590>] default_wake_function+0x0/0x20
[  798.048727]  [<c02d28dd>] _spin_unlock_irqrestore+0x1d/0x40
[  798.048735]  [<c0119590>] default_wake_function+0x0/0x20
[  798.048744]  [<c02d2b7f>] lock_kernel+0x2f/0x50
[  798.048753]  [<c0231ff1>] tty_read+0xe1/0xf0
[  798.048764]  [<c016150e>] vfs_read+0xae/0x180
[  798.048775]  [<c01618c1>] sys_read+0x51/0x80
[  798.048785]  [<c0103315>] syscall_call+0x7/0xb
[  798.048800] pppd          S 00000032  6408  1478      1          1544  1424 (NOTLB)
[  798.048827] d7965eac dfcdbab0 c03ad5e0 00000032 000000d0 da53e560 00000044 0beb2830 
[  798.048839]        00000032 dfcdbab0 0000758f 0beb977c 00000032 da53e560 da53e688 7fffffff 
[  798.048851]        00000000 0000000a 00000000 c02d0fc9 c02d2642 de469af4 d72a2028 de469af4 
[  798.048863] Call Trace:
[  798.048876]  [<c02d0fc9>] schedule_timeout+0xa9/0xb0
[  798.048883]  [<c02d2642>] _spin_lock_irqsave+0x22/0x30
[  798.048892]  [<c02d28dd>] _spin_unlock_irqrestore+0x1d/0x40
[  798.048900]  [<e0a7c383>] ppp_poll+0x33/0x90 [ppp_generic]
[  798.048921]  [<c0176397>] do_select+0x197/0x300
[  798.048937]  [<c0176030>] __pollwait+0x0/0xd0
[  798.048947]  [<c017680c>] sys_select+0x2cc/0x4b0
[  798.048955]  [<c02d2916>] _spin_unlock_irq+0x16/0x30
[  798.048971]  [<c0103315>] syscall_call+0x7/0xb
[  798.048985] gconfd-2      S 00200296  5988  1544      1          1578  1478 (NOTLB)
[  798.049011] d755bf08 d7a86a90 c03ad5a0 00200296 c02d2642 c03b2ba0 c03b2ba0 d755bf1c 
[  798.049024]        00005fc9 dfc68ab0 00026afe 2ad9b5a7 000000b9 d7a86a90 d7a86bb8 d755bf1c 
[  798.049036]        0007bc46 d755bf60 00005fc9 c02d0f77 d755bf1c 0007bc46 d665a7e0 c03b36a8 
[  798.049048] Call Trace:
[  798.049053]  [<c02d2642>] _spin_lock_irqsave+0x22/0x30
[  798.049067]  [<c02d0f77>] schedule_timeout+0x57/0xb0
[  798.049077]  [<c0126970>] process_timeout+0x0/0x10
[  798.049087]  [<c0176b38>] do_poll+0xa8/0xd0
[  798.049099]  [<c0176ce1>] sys_poll+0x181/0x270
[  798.049109]  [<c01216bc>] sys_gettimeofday+0x3c/0x90
[  798.049117]  [<c0176030>] __pollwait+0x0/0xd0
[  798.049126]  [<c0103315>] syscall_call+0x7/0xb
[  798.049141] bash          S C0335160  7028  1548   1424          1587  1467 (NOTLB)
[  798.049171] d7953e88 da53e030 c03ad5a0 c0335160 e586c5f4 0002c0c0 de41fbe0 dae8a050 
[  798.049184]        dae8a050 d4339ab0 000004f0 303a0c42 000000b0 da53e030 da53e158 7fffffff 
[  798.049196]        d63653d0 7fffffff d63653c4 c02d0fc9 c0101a93 dae8a210 da53e030 d6365524 
[  798.049209] Call Trace:
[  798.049221]  [<c02d0fc9>] schedule_timeout+0xa9/0xb0
[  798.049228]  [<c0101a93>] __switch_to+0x23/0x220
[  798.049236]  [<c02d2642>] _spin_lock_irqsave+0x22/0x30
[  798.049245]  [<c02d28dd>] _spin_unlock_irqrestore+0x1d/0x40
[  798.049254]  [<c02376d3>] read_chan+0x513/0x610
[  798.049266]  [<c0119590>] default_wake_function+0x0/0x20
[  798.049274]  [<c02d28dd>] _spin_unlock_irqrestore+0x1d/0x40
[  798.049283]  [<c0119590>] default_wake_function+0x0/0x20
[  798.049292]  [<c02d2b7f>] lock_kernel+0x2f/0x50
[  798.049301]  [<c0231ff1>] tty_read+0xe1/0xf0
[  798.049311]  [<c016150e>] vfs_read+0xae/0x180
[  798.049322]  [<c01618c1>] sys_read+0x51/0x80
[  798.049333]  [<c0103315>] syscall_call+0x7/0xb
[  798.049347] find          D D2069D04  6228  1578      1          1429  1544 (L-TLB)
[  798.049374] d2069cd4 d4339ab0 c03ad5a0 d2069d04 00000000 d2069d0c d2069cac c02d0ece 
[  798.049387]        c14db58c dfc68ab0 00007715 f7a85996 000000b2 d4339ab0 d4339bd8 00000c51 
[  798.049399]        c14db554 d2069d18 c14db58c c012da3a 00000002 c1402400 cf2ad11c 00000002 
[  798.049411] Call Trace:
[  798.049418]  [<c02d0ece>] io_schedule+0xe/0x20
[  798.049430]  [<c012da3a>] flush_cpu_workqueue+0x9a/0x1c0
[  798.049440]  [<c0131ca0>] wake_bit_function+0x0/0x60
[  798.049449]  [<c0131c40>] autoremove_wake_function+0x0/0x60
[  798.049459]  [<c0131c40>] autoremove_wake_function+0x0/0x60
[  798.049471]  [<c012db88>] flush_workqueue+0x28/0x30
[  798.049479]  [<c0233052>] release_dev+0x4d2/0x7b0
[  798.049490]  [<c015de5c>] free_block+0xec/0x180
[  798.049498]  [<c01ec310>] memmove+0x50/0x54
[  798.049507]  [<c0144fba>] free_hot_cold_page+0x11a/0x170
[  798.049518]  [<c015bf06>] poison_obj+0x36/0x60
[  798.049527]  [<c015d71d>] cache_free_debugcheck+0x11d/0x250
[  798.049536]  [<c02d2b7f>] lock_kernel+0x2f/0x50
[  798.049544]  [<c0233860>] tty_release+0x0/0x20
[  798.049550]  [<c0233874>] tty_release+0x14/0x20
[  798.049557]  [<c0162763>] __fput+0x1b3/0x1d0
[  798.049569]  [<c0160bad>] filp_close+0x4d/0x80
[  798.049578]  [<c011ebc4>] put_files_struct+0x74/0xb0
[  798.049589]  [<c011f945>] do_exit+0x125/0x440
[  798.049601]  [<c011fcdc>] do_group_exit+0x3c/0xb0
[  798.049610]  [<c0129643>] get_signal_to_deliver+0x243/0x350
[  798.049622]  [<c010311f>] do_signal+0x8f/0x120
[  798.049642]  [<c016c567>] sys_lstat64+0x37/0x40
[  798.049665]  [<c01031e7>] do_notify_resume+0x37/0x3c
[  798.049672]  [<c01033a6>] work_notifysig+0x13/0x19
[  798.049686] bash          S C0335160  6900  1587   1424                1548 (NOTLB)
[  798.049715] d51b7e88 d51a2ab0 c03ad5a0 c0335160 b314fa96 00029b5e de41fbe0 dae8a050 
[  798.049727]        dae8a050 dfc68ab0 00000724 d7adc60a 000000a6 d51a2ab0 d51a2bd8 7fffffff 
[  798.049740]        d098f290 7fffffff d098f284 c02d0fc9 c0101a93 dae8a210 d51a2ab0 d098f3e4 
[  798.049752] Call Trace:
[  798.049765]  [<c02d0fc9>] schedule_timeout+0xa9/0xb0
[  798.049772]  [<c0101a93>] __switch_to+0x23/0x220
[  798.049780]  [<c02d2642>] _spin_lock_irqsave+0x22/0x30
[  798.049789]  [<c02d28dd>] _spin_unlock_irqrestore+0x1d/0x40
[  798.049797]  [<c02376d3>] read_chan+0x513/0x610
[  798.049810]  [<c0119590>] default_wake_function+0x0/0x20
[  798.049818]  [<c02d28dd>] _spin_unlock_irqrestore+0x1d/0x40
[  798.049827]  [<c0119590>] default_wake_function+0x0/0x20
[  798.049836]  [<c02d2b7f>] lock_kernel+0x2f/0x50
[  798.049844]  [<c0231ff1>] tty_read+0xe1/0xf0
[  798.049855]  [<c016150e>] vfs_read+0xae/0x180
[  798.049866]  [<c01618c1>] sys_read+0x51/0x80
[  798.049877]  [<c0103315>] syscall_call+0x7/0xb
[  798.049892] 
[  798.049893] Showing all blocking locks in the system:
[  798.049898] S            init:    1 [dffc9a90, 116] (not blocked on mutex)
[  798.049906] R     ksoftirqd/0:    2 [dffc9560, 134] (not blocked on mutex)
[  798.049913] S      watchdog/0:    3 [dffc9030,   0] (not blocked on mutex)
[  798.049920] R        events/0:    4 [dfc68ab0, 120] (not blocked on mutex)
[  798.049927] S         khelper:    5 [dfc68580, 110] (not blocked on mutex)
[  798.049934] S         kthread:    6 [dfc68050, 111] (not blocked on mutex)
[  798.049940] S       kblockd/0:    8 [dfc77a90, 110] (not blocked on mutex)
[  798.049947] S          kacpid:    9 [dfc77560, 120] (not blocked on mutex)
[  798.049954] S         pdflush:  101 [dfcd6/0x40
[  809.051284]  [<c02cec3d>] unix_stream_recvmsg+0x43d/0x4c0
[  809.051302]  [<c02d14ef>] __mutex_lock_slowpath+0x27f/0x480
[  809.051312]  [<c02798f1>] do_sock_read+0xa1/0xb0
[  809.051322]  [<c0279a95>] sock_aio_read+0x95/0xa0
[  809.051342]  [<c0161411>] do_sync_read+0xc1/0x110
[  809.051352]  [<c01347bd>] ktime_get+0x1d/0x50
[  809.051370]  [<c0131c40>] autoremove_wake_function+0x0/0x60
[  809.051379]  [<c01e758b>] _atomic_dec_and_lock+0x3b/0x40
[  809.051388]  [<c017fb13>] mntput_no_expire+0x23/0x90
[  809.051399]  [<c0162729>] __fput+0x179/0x1d0
[  809.051409]  [<c01615c4>] vfs_read+0x164/0x180
[  809.051419]  [<c01618c1>] sys_read+0x51/0x80
[  809.051430]  [<c0103315>] syscall_call+0x7/0xb
[  809.051444] cat           D E09F082A  6152  1429      1                1578 (L-TLB)
[  809.051471] d95e5cd4 d90cd030 c03ad5a0 e09f082a 00000001 00000001 00000000 df1b34f8 
[  809.051482]        c14db58c dfc68ab0 000ed1be d51c4596 000000b4 d90cd030 d90cd158 00000c51 
[  809.051494]        c14db554 d95e5d18 c14db58c c012da3a 00200096 c02d2642 c0327d60 fffffdff 
[  809.051507] Call Trace:
[  809.051511]  [<e09f082a>] drm_vbl_send_signals+0x2a/0xba [drm]
[  809.051560]  [<c012da3a>] flush_cpu_workqueue+0x9a/0x1c0
[  809.051568]  [<c02d2642>] _spin_lock_irqsave+0x22/0x30
[  809.051577]  [<c02d2845>] _spin_unlock+0x15/0x30
[  809.051584]  [<c0131c40>] autoremove_wake_function+0x0/0x60
[  809.051595]  [<c0131c40>] autoremove_wake_function+0x0/0x60
[  809.051606]  [<c012db88>] flush_workqueue+0x28/0x30
[  809.051614]  [<c0233052>] release_dev+0x4d2/0x7b0
[  809.051627]  [<c02d2845>] _spin_unlock+0x15/0x30
[  809.051634]  [<c014cfee>] zap_pte_range+0xae/0x230
[  809.051643]  [<c015de5c>] free_block+0xec/0x180
[  809.051651]  [<c01ec310>] memmove+0x50/0x54
[  809.051663]  [<c015bf06>] poison_obj+0x36/0x60
[  809.051673]  [<c02d2845>] _spin_unlock+0x15/0x30
[  809.051681]  [<c02d2b7f>] lock_kernel+0x2f/0x50
[  809.051689]  [<c0233860>] tty_release+0x0/0x20
[  809.051695]  [<c0233874>] tty_release+0x14/0x20
[  809.051701]  [<c0162763>] __fput+0x1b3/0x1d0
[  809.051713]  [<c0160bad>] filp_close+0x4d/0x80
[  809.051723]  [<c011ebc4>] put_files_struct+0x74/0xb0
[  809.051734]  [<c011f945>] do_exit+0x125/0x440
[  809.051745]  [<c011fcdc>] do_group_exit+0x3c/0xb0
[  809.051754]  [<c0129643>] get_signal_to_deliver+0x243/0x350
[  809.051767]  [<c010311f>] do_signal+0x8f/0x120
[  809.051779]  [<c01ec72c>] copy_to_user+0x6c/0x90
[  809.051788]  [<c022fb09>] extract_entropy_user+0x89/0xf0
[  809.051807]  [<c02d27eb>] _spin_lock+0x1b/0x30
[  809.051818]  [<c0161577>] vfs_read+0x117/0x180
[  809.051829]  [<c01618c1>] sys_read+0x51/0x80
[  809.051838]  [<c01031e7>] do_notify_resume+0x37/0x3c
[  809.051845]  [<c01033a6>] work_notifysig+0x13/0x19
[  809.051860] bash          S C0335160  6900  1459   1424          1467  1425 (NOTLB)
[  809.051889] d975be88 da53ea90 c03ad5a0 c0335160 1ee55e6c 0002c36b de41fbe0 dae8a050 
[  809.051902]        dae8a050 dae8a050 00000512 dac7e1b3 000000b0 da53ea90 da53ebb8 7fffffff 
[  809.051914]        d97bcb64 7fffffff d97bcb58 c02d0fc9 dae8a050 00200046 00000001 d97bccb8 
[  809.051926] Call Trace:
[  809.051938]  [<c02d0fc9>] schedule_timeout+0xa9/0xb0
[  809.051947]  [<c02d2642>] _spin_lock_irqsave+0x22/0x30
[  809.051956]  [<c02d28dd>] _spin_unlock_irqrestore+0x1d/0x40
[  809.051964]  [<c02376d3>] read_chan+0x513/0x610
[  809.051972]  [<c01196a7>] __wake_up_locked+0x27/0x30
[  809.051983]  [<c0119590>] default_wake_function+0x0/0x20
[  809.051992]  [<c02d28dd>] _spin_unlock_irqrestore+0x1d/0x40
[  809.052000]  [<c0119590>] default_wake_function+0x0/0x20
[  809.052009]  [<c02d2bf6>] .text.lock.kernel_lock+0x2b/0x3a
[  809.052018]  [<c0231ff1>] tty_read+0xe1/0xf0
[  809.052029]  [<c016150e>] vfs_read+0xae/0x180
[  809.052040]  [<c01618c1>] sys_read+0x51/0x80
[  809.052050]  [<c0103315>] syscall_call+0x7/0xb
[  809.052065] bash          S C0335160  7016  1467   1424          1548  1459 (NOTLB)
[  809.052094] d7c29e88 d9819580 c03ad5a0 c0335160 11de9c18 0000bef1 de41fbe0 dae8a050 
[  809.052106]        dae8a050 d9819ab0 00000713 bc460012 0000002f d9819580 d98196a8 7fffffff 
[  809.052118]        d97bc358 7fffffff d97bc34c c02d0fc9 c0101a93 dae8a210 d9819580 d97bc4ac 
[  809.052130] Call Trace:
[  809.052143]  [<c02d0fc9>] schedule_timeout+0xa9/0xb0
[  809.052149]  [<c0101a93>] __switch_to+0x23/0x220
[  809.052158]  [<c02d2642>] _spin_lock_irqsave+0x22/0x30
[  809.052166]  [<c02d28dd>] _spin_unlock_irqrestore+0x1d/0x40
[  809.052175]  [<c02376d3>] read_chan+0x513/0x610
[  809.052187]  [<c0119590>] default_wake_function+0x0/0x20
[  809.052195]  [<c02d28dd>] _spin_unlock_irqrestore+0x1d/0x40
[  809.052204]  [<c0119590>] default_wake_function+0x0/0x20
[  809.052212]  [<c02d2b7f>] lock_kernel+0x2f/0x50
[  809.052221]  [<c0231ff1>] tty_read+0xe1/0xf0
[  809.052232]  [<c016150e>] vfs_read+0xae/0x180
[  809.052242]  [<c01618c1>] sys_read+0x51/0x80
[  809.052253]  [<c0103315>] syscall_call+0x7/0xb
[  809.052267] pppd          S 00000032  6408  1478      1          1544  1424 (NOTLB)
[  809.052294] d7965eac dfcdbab0 c03ad5e0 00000032 000000d0 da53e560 00000044 0beb2830 
[  809.052306]        00000032 dfcdbab0 0000758f 0beb977c 00000032 da53e560 da53e688 7fffffff 
[  809.052318]        00000000 0000000a 00000000 c02d0fc9 c02d2642 de469af4 d72a2028 de469af4 
[  809.052329] Call Trace:
[  809.052342]  [<c02d0fc9>] schedule_timeout+0xa9/0xb0
[  809.052349]  [<c02d2642>] _spin_lock_irqsave+0x22/0x30
[  809.052358]  [<c02d28dd>] _spin_unlock_irqrestore+0x1d/0x40
[  809.052366]  [<e0a7c383>] ppp_poll+0x33/0x90 [ppp_generic]
[  809.052386]  [<c0176397>] do_select+0x197/0x300
[  809.052402]  [<c0176030>] __pollwait+0x0/0xd0
[  809.052412]  [<c017680c>] sys_select+0x2cc/0x4b0
[  809.052420]  [<c02d2916>] _spin_unlock_irq+0x16/0x30
[  809.052435]  [<c0103315>] syscall_call+0x7/0xb
[  809.052450] gconfd-2      S 00200296  5988  1544      1          1578  1478 (NOTLB)
[  809.052475] d755bf08 d7a86a90 c03ad5a0 00200296 c02d2642 c03b2ba0 c03b2ba0 d755bf1c 
[  809.052487]        00005fc9 dfc68ab0 00026afe 2ad9b5a7 000000b9 d7a86a90 d7a86bb8 d755bf1c 
[  809.052499]        0007bc46 d755bf60 00005fc9 c02d0f77 d755bf1c 0007bc46 d665a7e0 c03b3598 
[  809.052511] Call Trace:
[  809.052516]  [<c02d2642>] _spin_lock_irqsave+0x22/0x30
[  809.052530]  [<c02d0f77>] schedule_timeout+0x57/0xb0
[  809.052540]  [<c0126970>] process_timeout+0x0/0x10
[  809.052550]  [<c0176b38>] do_poll+0xa8/0xd0
[  809.052561]  [<c0176ce1>] sys_poll+0x181/0x270
[  809.052571]  [<c01216bc>] sys_gettimeofday+0x3c/0x90
[  809.052579]  [<c0176030>] __pollwait+0x0/0xd0
[  809.052588]  [<c0103315>] syscall_call+0x7/0xb
[  809.052602] bash          S C0335160  7028  1548   1424          1587  1467 (NOTLB)
[  809.052631] d7953e88 da53e030 c03ad5a0 c0335160 e586c5f4 0002c0c0 de41fbe0 dae8a050 
[  809.052644]        dae8a050 d4339ab0 000004f0 303a0c42 000000b0 da53e030 da53e158 7fffffff 
[  809.052656]        d63653d0 7fffffff d63653c4 c02d0fc9 c0101a93 dae8a210 da53e030 d6365524 
[  809.052668] Call Trace:
[  809.052680]  [<c02d0fc9>] schedule_timeout+0xa9/0xb0
[  809.052687]  [<c0101a93>] __switch_to+0x23/0x220
[  809.052695]  [<c02d2642>] _spin_lock_irqsave+0x22/0x30
[  809.052704]  [<c02d28dd>] _spin_unlock_irqrestore+0x1d/0x40
[  809.052712]  [<c02376d3>] read_chan+0x513/0x610
[  809.052725]  [<c0119590>] default_wake_function+0x0/0x20
[  809.052733]  [<c02d28dd>] _spin_unlock_irqrestore+0x1d/0x40
[  809.052742]  [<c0119590>] default_wake_function+0x0/0x20
[  809.052750]  [<c02d2b7f>] lock_kernel+0x2f/0x50
[  809.052759]  [<c0231ff1>] tty_read+0xe1/0xf0
[  809.052769]  [<c016150e>] vfs_read+0xae/0x180
[  809.052780]  [<c01618c1>] sys_read+0x51/0x80
[  809.052791]  [<c0103315>] syscall_call+0x7/0xb
[  809.052805] find          D D2069D04  6228  1578      1          1429  1544 (L-TLB)
[  809.052832] d2069cd4 d4339ab0 c03ad5a0 d2069d04 00000000 d2069d0c d2069cac c02d0ece 
[  809.052844]        c14db58c dfc68ab0 00007715 f7a85996 000000b2 d4339ab0 d4339bd8 00000c51 
[  809.052856]        c14db554 d2069d18 c14db58c c012da3a 00000002 c1402400 cf2ad11c 00000002 
[  809.052868] Call Trace:
[  809.052874]  [<c02d0ece>] io_schedule+0xe/0x20
[  809.052887]  [<c012da3a>] flush_cpu_workqueue+0x9a/0x1c0
[  809.052897]  [<c0131ca0>] wake_bit_function+0x0/0x60
[  809.052905]  [<c0131c40>] autoremove_wake_function+0x0/0x60
[  809.052915]  [<c0131c40>] autoremove_wake_function+0x0/0x60
[  809.052927]  [<c012db88>] flush_workqueue+0x28/0x30
[  809.052934]  [<c0233052>] release_dev+0x4d2/0x7b0
[  809.052946]  [<c015de5c>] free_block+0xec/0x180
[  809.052954]  [<c01ec310>] memmove+0x50/0x54
[  809.052963]  [<c0144fba>] free_hot_cold_page+0x11a/0x170
[  809.052973]  [<c015bf06>] poison_obj+0x36/0x60
[  809.052982]  [<c015d71d>] cache_free_debugcheck+0x11d/0x250
[  809.052991]  [<c02d2b7f>] lock_kernel+0x2f/0x50
[  809.052999]  [<c0233860>] tty_release+0x0/0x20
[  809.053005]  [<c0233874>] tty_release+0x14/0x20
[  809.053011]  [<c0162763>] __fput+0x1b3/0x1d0
[  809.053023]  [<c0160bad>] filp_close+0x4d/0x80
[  809.053033]  [<c011ebc4>] put_files_struct+0x74/0xb0
[  809.053043]  [<c011f945>] do_exit+0x125/0x440
[  809.053055]  [<c011fcdc>] do_group_exit+0x3c/0xb0
[  809.053064]  [<c0129643>] get_signal_to_deliver+0x243/0x350
[  809.053076]  [<c010311f>] do_signal+0x8f/0x120
[  809.053095]  [<c016c567>] sys_lstat64+0x37/0x40
[  809.053119]  [<c01031e7>] do_notify_resume+0x37/0x3c
[  809.053126]  [<c01033a6>] work_notifysig+0x13/0x19
[  809.053140] bash          S C0335160  6900  1587   1424                1548 (NOTLB)
[  809.053168] d51b7e88 d51a2ab0 c03ad5a0 c0335160 b314fa96 00029b5e de41fbe0 dae8a050 
[  809.053181]        dae8a050 dfc68ab0 00000724 d7adc60a 000000a6 d51a2ab0 d51a2bd8 7fffffff 
[  809.053193]        d098f290 7fffffff d098f284 c02d0fc9 c0101a93 dae8a210 d51a2ab0 d098f3e4 
[  809.053205] Call Trace:
[  809.053217]  [<c02d0fc9>] schedule_timeout+0xa9/0xb0
[  809.053224]  [<c0101a93>] __switch_to+0x23/0x220
[  809.053232]  [<c02d2642>] _spin_lock_irqsave+0x22/0x30
[  809.053241]  [<c02d28dd>] _spin_unlock_irqrestore+0x1d/0x40
[  809.053249]  [<c02376d3>] read_chan+0x513/0x610
[  809.053261]  [<c0119590>] default_wake_function+0x0/0x20
[  809.053270]  [<c02d28dd>] _spin_unlock_irqrestore+0x1d/0x40
[  809.053279]  [<c0119590>] default_wake_function+0x0/0x20
[  809.053287]  [<c02d2b7f>] lock_kernel+0x2f/0x50
[  809.053296]  [<c0231ff1>] tty_read+0xe1/0xf0
[  809.053307]  [<c016150e>] vfs_read+0xae/0x180
[  809.053317]  [<c01618c1>] sys_read+0x51/0x80
[  809.053328]  [<c0103315>] syscall_call+0x7/0xb
[  809.053342] syslogd       R running  7420  1736   1243          1737       (NOTLB)
[  809.053372] syslogd       R running  7200  1737   1243                1736 (NOTLB)
[  809.053401] 
[  809.053403] Showing all blocking locks in the system:
[  809.053407] S            init:    1 [dffc9a90, 116] (not blocked on mutex)
[  809.053415] R     ksoftirqd/0:    2 [dffc9560, 134] (not blocked on mutex)
[  809.053422] S      watchdog/0:    3 [dffc9030,   0] (not blocked on mutex)
[  809.053429] R        events/0:    4 [dfc68ab0, 120] (not blocked on mutex)
[  809.053436] S         khelper:    5 [dfc68580, 110] (not blocked on mutex)
[  809.053442] S         kthread:    6 [dfc68050, 111] (not blocked on mutex)
[  809.053449] S       kblockd/0:    8 [dfc77a90, 110] (not blocked on mutex)
[  809.053455] S          kacpid:    9 [dfc77560, 120] (not blocked on mutex)
[  809.053462] S         pdflush:  101 [dfcd6ab0, 120] (not blocked on mutex)
[  809.053468] S         pdflush:  102 [dfcd9560, 115] (not blocked on mutex)
[  809.053475] S           aio/0:  104 [dfc77030, 112] (not blocked on mutex)
[  809.053482] S         kswapd0:  103 [dfcdb580, 125] (not blocked on mutex)
[  809.053488] S         kseriod:  689 [dfcdfa90, 110] (not blocked on mutex)
[  809.053495] S       kjournald:  753 [c16b3580, 115] (not blocked on mutex)
[  809.053501] S           khubd:  936 [c169d030, 110] (not blocked on mutex)
[  809.053508] S       kjournald: 1018 [c1680580, 115] (not blocked on mutex)
[  809.053514] S       kjournald: 1019 [dfcdf560, 119] (not blocked on mutex)
[  809.053521] S       kjournald: 1020 [dfcd6050, 115] (not blocked on mutex)
[  809.053528] S      reiserfs/0: 1024 [dfcd6580, 110] (not blocked on mutex)
[  809.053534] R         syslogd: 1243 [dfcdbab0, 125] (not blocked on mutex)
[  809.053541] S           klogd: 1246 [de404ab0, 116] (not blocked on mutex)
[  809.053548] S           acpid: 1277 [c169da90, 121] (not blocked on mutex)
[  809.053554] S           cupsd: 1283 [c16b3ab0, 116] (not blocked on mutex)
[  809.053561] S   dbus-daemon-1: 1286 [dfcd9a90, 118] (not blocked on mutex)
[  809.053568] S             gpm: 1291 [de42b030, 115] (not blocked on mutex)
[  809.053574] S           inetd: 1296 [dfcdf030, 119] (not blocked on mutex)
[  809.053581] S           pdnsd: 1324 [dfcd9030, 118] (not blocked on mutex)
[  809.053588] S           pdnsd: 1327 [de404580, 115] (not blocked on mutex)
[  809.053594] S           pdnsd: 1328 [c169d560, 116] (not blocked on mutex)
[  809.053601] S            sshd: 1334 [de42ba90, 118] (not blocked on mutex)
[  809.053607] S           xinit: 1340 [de404050, 117] (not blocked on mutex)
[  809.053614] S           getty: 1346 [c16b3050, 117] (not blocked on mutex)
[  809.053620] S           getty: 1347 [dfcdb050, 117] (not blocked on mutex)
[  809.053627] S           getty: 1348 [c1680050, 117] (not blocked on mutex)
[  809.053634] S           getty: 1349 [c1680ab0, 117] (not blocked on mutex)
[  809.053640] S           getty: 1350 [de42b560, 117] (not blocked on mutex)
[  809.053647] S           getty: 1353 [de203030, 117] (not blocked on mutex)
[  809.053654] R         XFree86: 1373 [dd4f9580, 105] (not blocked on mutex)
[  809.053660] S x-session-manag: 1378 [de203a90, 115] (not blocked on mutex)
[  809.053667] S       ssh-agent: 1407 [dd4f9050, 115] (not blocked on mutex)
[  809.053673] S   dbus-daemon-1: 1411 [dc211560, 115] (not blocked on mutex)
[  809.053680] S xfce-mcs-manage: 1413 [dc211a90, 115] (not blocked on mutex)
[  809.053687] S           xfwm4: 1416 [de203560, 115] (not blocked on mutex)
[  809.053693] S      xftaskbar4: 1418 [dc211030, 115] (not blocked on mutex)
[  809.053699] S       xfdesktop: 1420 [dae8aab0, 115] (not blocked on mutex)
[  809.053706] S     xfce4-panel: 1422 [dae8a580, 115] (not blocked on mutex)
[  809.053713] R        Terminal: 1424 [dae8a050, 116] (not blocked on mutex)
[  809.053719] S gnome-pty-helpe: 1425 [dd4f9ab0, 116] (not blocked on mutex)
[  809.053725] D             cat: 1429 [d90cd030, 125] (not blocked on mutex)
[  809.053732] S            bash: 1459 [da53ea90, 116] (not blocked on mutex)
[  809.053738] S            bash: 1467 [d9819580, 117] (not blocked on mutex)
[  809.053744] S            pppd: 1478 [da53e560, 115] (not blocked on mutex)
[  809.053751] S        gconfd-2: 1544 [d7a86a90, 116] (not blocked on mutex)
[  809.053757] S            bash: 1548 [da53e030, 117] (not blocked on mutex)
[  809.053763] D            find: 1578 [d4339ab0, 118] (not blocked on mutex)
[  809.053770] S            bash: 1587 [d51a2ab0, 117] (not blocked on mutex)
[  809.053776] R         syslogd: 1736 [d90cda90, 125] (not blocked on mutex)
[  809.053782] R         syslogd: 1737 [d4339580, 125] (not blocked on mutex)
[  809.053788] 
[  809.053791] ---------------------------
[  809.053794] | showing all locks held: |
[  809.053797] ---------------------------
[  809.053800] 
[  809.053802] =============================================
[  809.053805] 
[  829.585023] kobject_uevent
[  829.585055] fill_kobj_path: path = '/class/vc/vcs2'
[  829.585461] kobject vcs2: cleaning up
[  829.585476] kobject_uevent
[  829.585534] fill_kobj_path: path = '/class/vc/vcsa2'
[  829.585745] kobject vcsa2: cleaning up
[  829.586219] kobject_uevent
[  829.586237] fill_kobj_path: path = '/class/vc/vcs3'
[  829.586526] kobject vcs3: cleaning up
[  829.586537] kobject_uevent
[  829.586551] fill_kobj_path: path = '/class/vc/vcsa3'
[  829.586752] kobject vcsa3: cleaning up
[  829.588061] kobject_uevent
[  829.588083] fill_kobj_path: path = '/class/vc/vcs4'
[  829.588368] kobject vcs4: cleaning up
[  829.588379] kobject_uevent
[  829.588636] fill_kobj_path: path = '/class/vc/vcsa4'
[  829.589333] kobject vcsa4: cleaning up
[  829.589572] kobject_uevent
[  829.589592] fill_kobj_path: path = '/class/vc/vcs6'
[  829.590314] kobject vcs6: cleaning up
[  829.590331] kobject_uevent
[  829.590346] fill_kobj_path: path = '/class/vc/vcsa6'
[  829.590902] kobject vcsa6: cleaning up
[  829.591096] kobject_uevent
[  829.591111] fill_kobj_path: path = '/class/vc/vcs5'
[  829.601916] kobject vcs5: cleaning up
[  829.601942] kobject_uevent
[  829.601959] fill_kobj_path: path = '/class/vc/vcsa5'
[  829.602863] kobject vcsa5: cleaning up
[  829.654967] kobject_uevent
[  829.655006] fill_kobj_path: path = '/class/vc/vcs7'
[  829.655370] kobject vcs7: cleaning up
[  829.655385] kobject_uevent
[  829.655399] fill_kobj_path: path = '/class/vc/vcsa7'
[  829.655639] kobject vcsa7: cleaning up
[  844.591519] kobject_uevent
[  844.591556] fill_kobj_path: path = '/class/vc/vcs1'
[  844.591933] kobject vcs1: cleaning up
[  844.591948] kobject_uevent
[  844.591960] fill_kobj_path: path = '/class/vc/vcsa1'
[  844.592178] kobject vcsa1: cleaning up

--=_ums.usu.ru-27340-1137077863-0001-2
Content-Type: text/plain; name=".config"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename=".config"

#
# Automatically generated make config: don't edit
# Linux kernel version: 
# Thu Jan 12 15:20:08 2006
#
CONFIG_X86_32=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION="-home"
# CONFIG_LOCALVERSION_AUTO is not set
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_UID16=y
CONFIG_VM86=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_EMBEDDED=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_DOUBLEFAULT=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
CONFIG_SLAB=y
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0
# CONFIG_SLOB is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y

#
# Block layer
#
# CONFIG_LBD is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_DEFAULT_AS=y
# CONFIG_DEFAULT_DEADLINE is not set
# CONFIG_DEFAULT_CFQ is not set
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="anticipatory"

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
CONFIG_M686=y
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_PPRO_FENCE=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_HPET_TIMER=y
# CONFIG_SMP is not set
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_BKL=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=m
CONFIG_X86_MCE_P4THERMAL=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
CONFIG_X86_REBOOTFIXUPS=y
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m

#
# Firmware Drivers
#
# CONFIG_EDD is not set
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_SPLIT_PTLOCK_CPUS=4
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_EFI is not set
# CONFIG_REGPARM is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_KEXEC=y
CONFIG_PHYSICAL_START=0x100000

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
CONFIG_PM_LEGACY=y
# CONFIG_PM_DEBUG is not set
# CONFIG_SOFTWARE_SUSPEND is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
# CONFIG_ACPI_SLEEP_PROC_SLEEP is not set
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_HOTKEY=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
CONFIG_ACPI_ASUS=m
CONFIG_ACPI_IBM=m
CONFIG_ACPI_TOSHIBA=m
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_PM_TIMER=y
# CONFIG_ACPI_CONTAINER is not set

#
# APM (Advanced Power Management) BIOS Support
#
CONFIG_APM=m
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
CONFIG_APM_RTC_IS_GMT=y
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCI_MSI=y
# CONFIG_PCI_LEGACY_PROC is not set
# CONFIG_PCI_DEBUG is not set
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_MISC=m

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=m
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=y
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_TUNNEL is not set
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_BIC=y
# CONFIG_IPV6 is not set
# CONFIG_NETFILTER is not set

#
# DCCP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_DCCP is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_IEEE80211 is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=m
# CONFIG_DEBUG_DRIVER is not set

#
# Connector - unified userspace <-> kernelspace linker
#
CONFIG_CONNECTOR=m

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_GSC is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play support
#
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
CONFIG_ISAPNP=y
CONFIG_PNPBIOS=y
CONFIG_PNPBIOS_PROC_FS=y
CONFIG_PNPACPI=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_UB=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=8192
CONFIG_BLK_DEV_INITRD=y
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_IDE_GENERIC is not set
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_CS5535 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_ARM is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=m
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=m
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y

#
# SCSI Transport Attributes
#
# CONFIG_SCSI_SPI_ATTRS is not set
CONFIG_SCSI_FC_ATTRS=m
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_ISCSI_TCP is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_SATA is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA2XXX=m
# CONFIG_SCSI_QLA2XXX_EMBEDDED_FIRMWARE is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
# CONFIG_BLK_DEV_MD is not set
CONFIG_BLK_DEV_DM=y
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_MIRROR=m
CONFIG_DM_ZERO=m
# CONFIG_DM_MULTIPATH is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_FC is not set
# CONFIG_FUSION_SAS is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Network device support
#
CONFIG_NETDEVICES=y
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
CONFIG_TUN=m
# CONFIG_NET_SB1000 is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# PHY device support
#

#
# Ethernet (10 or 100Mbit)
#
# CONFIG_NET_ETHERNET is not set
CONFIG_MII=m

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_CHELSIO_T1 is not set
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPP_MPPE=m
CONFIG_PPPOE=m
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_TSDEV=m
CONFIG_INPUT_TSDEV_SCREEN_X=240
CONFIG_INPUT_TSDEV_SCREEN_Y=320
CONFIG_INPUT_EVDEV=m
CONFIG_INPUT_EVBUG=m

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=m
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=m
# CONFIG_SERIO_CT82C710 is not set
CONFIG_SERIO_PARKBD=m
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_CONSOLE is not set
# CONFIG_SERIAL_8250_ACPI is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
CONFIG_SERIAL_8250_DETECT_IRQ=y
CONFIG_SERIAL_8250_RSA=y
# CONFIG_SERIAL_8250_FOURPORT is not set
# CONFIG_SERIAL_8250_ACCENT is not set
# CONFIG_SERIAL_8250_BOCA is not set
# CONFIG_SERIAL_8250_HUB6 is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
# CONFIG_TIPAR is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
CONFIG_NVRAM=m
CONFIG_RTC=m
# CONFIG_GEN_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=m
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
CONFIG_AGP_INTEL=m
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
CONFIG_AGP_VIA=m
# CONFIG_AGP_EFFICEON is not set
CONFIG_DRM=m
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
CONFIG_DRM_RADEON=m
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_I830 is not set
# CONFIG_DRM_I915 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set
# CONFIG_MWAVE is not set
# CONFIG_CS5535_GPIO is not set
# CONFIG_RAW_DRIVER is not set
CONFIG_HPET=y
# CONFIG_HPET_RTC_IRQ is not set
CONFIG_HPET_MMAP=y
# CONFIG_HANGCHECK_TIMER is not set

#
# TPM devices
#
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_CHARDEV=m

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ALGOPCF=m
# CONFIG_I2C_ALGOPCA is not set

#
# I2C Hardware Bus support
#
CONFIG_I2C_ALI1535=m
CONFIG_I2C_ALI1563=m
CONFIG_I2C_ALI15X3=m
CONFIG_I2C_AMD756=m
# CONFIG_I2C_AMD756_S4882 is not set
CONFIG_I2C_AMD8111=m
CONFIG_I2C_ELEKTOR=m
CONFIG_I2C_I801=m
CONFIG_I2C_I810=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_PARPORT=m
CONFIG_I2C_PARPORT_LIGHT=m
CONFIG_I2C_PROSAVAGE=m
CONFIG_I2C_SAVAGE4=m
CONFIG_SCx200_ACB=m
CONFIG_I2C_SIS5595=m
CONFIG_I2C_SIS630=m
CONFIG_I2C_SIS96X=m
# CONFIG_I2C_STUB is not set
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m
CONFIG_I2C_VOODOO3=m
# CONFIG_I2C_PCA_ISA is not set

#
# Miscellaneous I2C Chip support
#
# CONFIG_SENSORS_DS1337 is not set
# CONFIG_SENSORS_DS1374 is not set
CONFIG_SENSORS_EEPROM=m
CONFIG_SENSORS_PCF8574=m
# CONFIG_SENSORS_PCA9539 is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_SENSORS_RTC8564=m
# CONFIG_SENSORS_MAX6875 is not set
# CONFIG_RTC_X1205_I2C is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Hardware Monitoring support
#
# CONFIG_HWMON is not set
# CONFIG_HWMON_VID is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia Capabilities Port drivers
#

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
CONFIG_FB=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
# CONFIG_FB_MACMODES is not set
CONFIG_FB_MODE_HELPERS=y
# CONFIG_FB_TILEBLITTING is not set
CONFIG_FB_CIRRUS=m
# CONFIG_FB_PM2 is not set
CONFIG_FB_CYBER2000=m
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
CONFIG_FB_VGA16=m
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I810 is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON_OLD is not set
CONFIG_FB_RADEON=m
CONFIG_FB_RADEON_I2C=y
# CONFIG_FB_RADEON_DEBUG is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
CONFIG_FB_SAVAGE=m
# CONFIG_FB_SAVAGE_I2C is not set
CONFIG_FB_SAVAGE_ACCEL=y
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_CYBLA is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_GEODE is not set
CONFIG_FB_VIRTUAL=m

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_MDA_CONSOLE=m
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=m
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Logo configuration
#
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

#
# Sound
#
CONFIG_SOUND=m

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
CONFIG_SND_SEQ_RTCTIMER_DEFAULT=y
# CONFIG_SND_DYNAMIC_MINORS is not set
# CONFIG_SND_SUPPORT_OLD_API is not set
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OPL3_LIB=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_AC97_BUS=m
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# ISA devices
#
# CONFIG_SND_AD1816A is not set
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_ALS100 is not set
# CONFIG_SND_AZT2320 is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4232 is not set
# CONFIG_SND_CS4236 is not set
# CONFIG_SND_DT019X is not set
# CONFIG_SND_ES968 is not set
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
# CONFIG_SND_GUSCLASSIC is not set
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
# CONFIG_SND_SB8 is not set
# CONFIG_SND_SB16 is not set
# CONFIG_SND_SBAWE is not set
# CONFIG_SND_SGALAXY is not set
# CONFIG_SND_SSCAPE is not set
# CONFIG_SND_WAVEFRONT is not set

#
# PCI devices
#
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS5535AUDIO is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
CONFIG_SND_FM801=m
# CONFIG_SND_FM801_TEA575X is not set
# CONFIG_SND_HDA_INTEL is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set

#
# USB devices
#
# CONFIG_SND_USB_AUDIO is not set
# CONFIG_SND_USB_USX2Y is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
CONFIG_USB_DYNAMIC_MINORS=y
# CONFIG_USB_SUSPEND is not set
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_EHCI_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=m
# CONFIG_USB_SL811_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_OBSOLETE_OSS_USB_DRIVER is not set
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=m

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
#

#
# may also be needed; see USB_STORAGE Help for more information
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_USBAT=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y
CONFIG_USB_STORAGE_ALAUDA=y
# CONFIG_USB_LIBUSUAL is not set

#
# USB Input Devices
#
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
# CONFIG_USB_HIDDEV is not set

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_ACECAD is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_MTOUCH is not set
# CONFIG_USB_ITMTOUCH is not set
# CONFIG_USB_EGALAX is not set
# CONFIG_USB_YEALINK is not set
# CONFIG_USB_XPAD is not set
# CONFIG_USB_ATI_REMOTE is not set
# CONFIG_USB_ATI_REMOTE2 is not set
# CONFIG_USB_KEYSPAN_REMOTE is not set
# CONFIG_USB_APPLETOUCH is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set

#
# Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network Adapters
#
CONFIG_USB_CATC=m
CONFIG_USB_KAWETH=m
CONFIG_USB_PEGASUS=m
CONFIG_USB_RTL8150=m
# CONFIG_USB_USBNET is not set
# CONFIG_USB_MON is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_AIRPRIME is not set
# CONFIG_USB_SERIAL_ANYDATA is not set
CONFIG_USB_SERIAL_BELKIN=m
# CONFIG_USB_SERIAL_WHITEHEAT is not set
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
# CONFIG_USB_SERIAL_CP2101 is not set
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
# CONFIG_USB_SERIAL_GARMIN is not set
# CONFIG_USB_SERIAL_IPW is not set
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
# CONFIG_USB_SERIAL_KEYSPAN_MPR is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XA is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XB is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA18X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19W is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19QW is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19QI is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA49W is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA49WLC is not set
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
CONFIG_USB_SERIAL_PL2303=m
# CONFIG_USB_SERIAL_HP4X is not set
CONFIG_USB_SERIAL_SAFE=m
# CONFIG_USB_SERIAL_SAFE_PADDED is not set
# CONFIG_USB_SERIAL_TI is not set
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_EZUSB=y

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGETKIT is not set
# CONFIG_USB_PHIDGETSERVO is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TEST is not set

#
# USB DSL modem support
#

#
# USB Gadget Support
#
CONFIG_USB_GADGET=m
# CONFIG_USB_GADGET_DEBUG_FILES is not set
CONFIG_USB_GADGET_SELECTED=y
CONFIG_USB_GADGET_NET2280=y
CONFIG_USB_NET2280=m
# CONFIG_USB_GADGET_PXA2XX is not set
# CONFIG_USB_GADGET_GOKU is not set
# CONFIG_USB_GADGET_LH7A40X is not set
# CONFIG_USB_GADGET_OMAP is not set
# CONFIG_USB_GADGET_DUMMY_HCD is not set
CONFIG_USB_GADGET_DUALSPEED=y
CONFIG_USB_ZERO=m
CONFIG_USB_ETH=m
CONFIG_USB_ETH_RNDIS=y
CONFIG_USB_GADGETFS=m
CONFIG_USB_FILE_STORAGE=m
# CONFIG_USB_FILE_STORAGE_TEST is not set
CONFIG_USB_G_SERIAL=m

#
# MMC/SD Card support
#
# CONFIG_MMC is not set

#
# InfiniBand support
#
# CONFIG_INFINIBAND is not set

#
# SN Devices
#

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_REISERFS_FS_XATTR is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y
# CONFIG_XFS_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_INOTIFY=y
CONFIG_QUOTA=y
CONFIG_QFMT_V1=m
CONFIG_QFMT_V2=m
CONFIG_QUOTACTL=y
CONFIG_DNOTIFY=y
CONFIG_AUTOFS_FS=m
CONFIG_AUTOFS4_FS=m
CONFIG_FUSE_FS=m

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=y

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y
CONFIG_RELAYFS_FS=m
# CONFIG_CONFIGFS_FS is not set

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=y
CONFIG_NFS_DIRECTIO=y
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_NFS_ACL_SUPPORT=m
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=m
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_RPCSEC_GSS_SPKM3 is not set
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS is not set
# CONFIG_CIFS_XATTR is not set
# CONFIG_CIFS_EXPERIMENTAL is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_EFI_PARTITION is not set

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="cp437"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_UTF8=m

#
# Instrumentation Support
#
# CONFIG_PROFILING is not set
# CONFIG_KPROBES is not set

#
# Kernel hacking
#
CONFIG_PRINTK_TIME=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_KERNEL=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_DETECT_SOFTLOCKUP=y
# CONFIG_SCHEDSTATS is not set
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_PREEMPT=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_DEBUG_KOBJECT=y
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_FS is not set
CONFIG_DEBUG_VM=y
# CONFIG_FRAME_POINTER is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_EARLY_PRINTK=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACK_USAGE=y
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_DEBUG_RODATA is not set
# CONFIG_4KSTACKS is not set
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
# CONFIG_CRYPTO_WP512 is not set
# CONFIG_CRYPTO_TGR192 is not set
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_AES_586=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_KHAZAD=m
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_CRC32C=m
CONFIG_CRYPTO_TEST=m

#
# Hardware crypto devices
#
# CONFIG_CRYPTO_DEV_PADLOCK is not set

#
# Library routines
#
CONFIG_CRC_CCITT=m
CONFIG_CRC16=m
CONFIG_CRC32=y
CONFIG_LIBCRC32C=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_KTIME_SCALAR=y

--=_ums.usu.ru-27340-1137077863-0001-2--
