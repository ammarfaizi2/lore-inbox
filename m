Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271115AbTGPU51 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 16:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271123AbTGPU50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 16:57:26 -0400
Received: from eta.fastwebnet.it ([213.140.2.50]:27826 "EHLO eta.fastwebnet.it")
	by vger.kernel.org with ESMTP id S271115AbTGPU4R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 16:56:17 -0400
Date: Wed, 16 Jul 2003 23:14:21 +0200
From: Mattia Dongili <dongili@supereva.it>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: swsusp + synaptics + usb: 2 issues 1 workaround
Message-ID: <20030716211421.GA29335@inferi.kami.home>
Reply-To: dongili@supereva.it
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm testing swsusp with the 2.6.0-test1 kernel. I'm experiencing
problems when suspending (S4) with usb modules loaded (still hve to
narow down which one gives problem - ready to help debugging if not a
known issue).

the 2 problems are:
1. cannot suspend with usb modules loaded (as said) and I have to stop
hotplug to be able to go S4
2. after resuming an X session the synaptics touchpad goes nuts (not
imeediately anyway)

the common workaround is reloading usb modules after resuming restores
the synaptics tp too :)

NB: I also have an USB mouse attached

when suspending I just issue a 
/etc/init.d/hotplug stop && echo 4 > /proc/acpi/sleep

here' some logs (I can provide any other useful info):

** relevant kernel config

CONFIG_USB=m
CONFIG_USB_DEVICEFS=y
CONFIG_USB_UHCI_HCD=m
CONFIG_USB_PRINTER=m
CONFIG_USB_STORAGE=m
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_INPUT_MOUSE=y

** from /v/l/messages

Jul 16 22:52:02 inferi kernel: pdflush left refrigerator
--> Jul 16 22:54:18 inferi kernel: psmouse.c: Lost synchronization, throwing 2 bytes away.
here the TP is gone

Jul 16 22:54:37 inferi kernel: drivers/usb/core/usb.c: registered new driver usbfs
Jul 16 22:54:37 inferi kernel: drivers/usb/core/usb.c: registered new driver hub
Jul 16 22:54:37 inferi kernel: drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
Jul 16 22:54:37 inferi kernel: uhci-hcd 0000:00:1d.0: Intel Corp.  82801CA/CAM USB (Hub
Jul 16 22:54:37 inferi kernel: uhci-hcd 0000:00:1d.0: irq 9, io base 00001800
Jul 16 22:54:38 inferi kernel: uhci-hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
Jul 16 22:54:38 inferi kernel: hub 1-0:0: USB hub found
Jul 16 22:54:38 inferi kernel: hub 1-0:0: 2 ports detected
Jul 16 22:54:38 inferi kernel: uhci-hcd 0000:00:1d.1: Intel Corp.  82801CA/CAM USB (Hub
Jul 16 22:54:38 inferi kernel: uhci-hcd 0000:00:1d.1: irq 9, io base 00001820
Jul 16 22:54:38 inferi kernel: uhci-hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
Jul 16 22:54:38 inferi kernel: hub 2-0:0: USB hub found
Jul 16 22:54:38 inferi kernel: hub 2-0:0: 2 ports detected
Jul 16 22:54:38 inferi kernel: uhci-hcd 0000:00:1d.2: Intel Corp.  82801CA/CAM USB (Hub
Jul 16 22:54:38 inferi kernel: uhci-hcd 0000:00:1d.2: irq 9, io base 00001840
Jul 16 22:54:38 inferi kernel: uhci-hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
Jul 16 22:54:38 inferi kernel: hub 3-0:0: USB hub found
Jul 16 22:54:38 inferi kernel: hub 3-0:0: 2 ports detected
Jul 16 22:54:38 inferi usb.agent: ... no modules for USB product 0/0/206
Jul 16 22:54:38 inferi usb.agent: ... no modules for USB product 0/0/206
Jul 16 22:54:38 inferi kernel: hub 2-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
Jul 16 22:54:39 inferi kernel: hub 2-0:0: new USB device on port 1, assigned address 2
Jul 16 22:54:39 inferi kernel: input: USB HID v1.10 Mouse [Logitech USB Mouse] on usb-0000:00:1d.1-1
Jul 16 22:54:39 inferi kernel: drivers/usb/core/usb.c: registered new driver hid
Jul 16 22:54:39 inferi kernel: drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Jul 16 22:54:39 inferi kernel: hub 3-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
Jul 16 22:54:39 inferi kernel: hub 3-0:0: new USB device on port 1, assigned address 2
Jul 16 22:54:39 inferi kernel: Initializing USB Mass Storage driver...
Jul 16 22:54:39 inferi kernel: scsi3 : SCSI emulation for USB Mass Storage devices
Jul 16 22:54:39 inferi kernel:   Vendor: Sony      Model: MSC-U02 Rev: 1.00
Jul 16 22:54:39 inferi kernel:   Type:   Direct-Access ANSI SCSI revision: 02
Jul 16 22:54:40 inferi scsi.agent: how to add device type= at /devices/pci0000:00/0000:00:1d.2/usb3/3-1/3-1:0/host3/3:0:0:0 ??
Jul 16 22:54:40 inferi kernel: Attached scsi removable disk sda at scsi3, channel 0, id 0, lun 0
Jul 16 22:54:40 inferi kernel: Attached scsi generic sg0 at scsi3, channel 0, id 0, lun 0,  type 0
Jul 16 22:54:40 inferi kernel: drivers/usb/core/usb.c: registered new driver usb-storage
Jul 16 22:54:40 inferi kernel: USB Mass Storage support registered.


** lsmod

Module                  Size  Used by
usb_storage            27648  0 
hid                    23680  0 
uhci_hcd               30088  0 
usbcore                97748  5 usb_storage,hid,uhci_hcd
nls_iso8859_1           3968  0 
isofs                  31672  0 
zlib_inflate           21760  1 isofs
sg                     30348  0 
parport_pc             21636  0 
parport                23104  1 parport_pc
nfs                    92716  8 
lockd                  59344  2 nfs,[unsafe]
sunrpc                119876  11 nfs,lockd
ds                     11392  4 
yenta_socket           11008  0 
pcmcia_core            59776  2 ds,yenta_socket
e100                   60548  0 
sd_mod                 12192  0 
ipt_state               1536  1 
ip_conntrack           26004  1 ipt_state
iptable_filter          2304  1 
ip_tables              16512  2 ipt_state,iptable_filter
scsi_mod               64788  3 usb_storage,sg,sd_mod
snd_seq_oss            32768  0 
snd_seq_midi_event      6144  1 snd_seq_oss
snd_seq                53200  4 snd_seq_oss,snd_seq_midi_event
snd_pcm_oss            49924  0 
snd_mixer_oss          17408  2 snd_pcm_oss
snd_intel8x0           27844  1 
snd_ac97_codec         49284  1 snd_intel8x0
snd_pcm                88704  2 snd_pcm_oss,snd_intel8x0
snd_timer              22144  2 snd_seq,snd_pcm
snd_page_alloc          8196  2 snd_intel8x0,snd_pcm
snd_mpu401_uart         6400  1 snd_intel8x0
snd_rawmidi            20736  1 snd_mpu401_uart
snd_seq_device          6660  3 snd_seq_oss,snd_seq,snd_rawmidi
snd                    44292  12 snd_seq_oss,snd_seq_midi_event,snd_seq,snd_pcm_oss,snd_mixer_oss,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device
soundcore               7232  2 snd
rtc                    10916  0 

** /proc/usb

T:  Bus=03 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.0-test1 uhci-hcd
S:  Product=Intel Corp. 82801CA/CAM USB (Hub
S:  SerialNumber=0000:00:1d.2
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=03 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=054c ProdID=0056 Rev= 1.80
S:  Manufacturer=Sony
S:  Product=USB Memory Stick Slot
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=08(stor.) Sub=05 Prot=00 Driver=usb-storage
E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=83(I) Atr=03(Int.) MxPS=   2 Ivl=1ms

T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc= 93/900 us (10%), #Int=  1, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.0-test1 uhci-hcd
S:  Product=Intel Corp. 82801CA/CAM USB (Hub
S:  SerialNumber=0000:00:1d.1
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=1.5 MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=046d ProdID=c001 Rev= 4.10
S:  Manufacturer=Logitech
S:  Product=USB Mouse
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr= 50mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=hid
E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=10ms

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.0-test1 uhci-hcd
S:  Product=Intel Corp. 82801CA/CAM USB (Hub
S:  SerialNumber=0000:00:1d.0
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

** lspci

00:00.0 Host bridge: Intel Corp. 82830 830 Chipset Host Bridge (rev 02)
00:01.0 PCI bridge: Intel Corp. 82830 830 Chipset AGP Bridge (rev 02)
00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 01)
00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #2) (rev 01)
00:1d.2 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #3) (rev 01)
00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 41)
00:1f.0 ISA bridge: Intel Corp. 82801CAM ISA Bridge (LPC) (rev 01)
00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 01)
00:1f.3 SMBus: Intel Corp. 82801CA/CAM SMBus (rev 01)
00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio (rev 01)
00:1f.6 Modem: Intel Corp. 82801CA/CAM AC'97 Modem (rev 01)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M6 LY
02:02.0 FireWire (IEEE 1394): Texas Instruments TSB43AA22 IEEE-1394 Controller (PHY/Link Integrated) (rev 02)
02:05.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
02:05.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
02:08.0 Ethernet controller: Intel Corp. 82801CAM (ICH3) PRO/100 VE (LOM) Ethernet Controller (rev 41)
-- 
mattia
:wq!
