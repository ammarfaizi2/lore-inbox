Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130013AbQLTNlG>; Wed, 20 Dec 2000 08:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129811AbQLTNk4>; Wed, 20 Dec 2000 08:40:56 -0500
Received: from db0bm.automation.fh-aachen.de ([193.175.144.197]:50449 "EHLO
	db0bm.ampr.org") by vger.kernel.org with ESMTP id <S129716AbQLTNkl>;
	Wed, 20 Dec 2000 08:40:41 -0500
Date: Wed, 20 Dec 2000 14:09:56 +0100
From: f5ibh <f5ibh@db0bm.ampr.org>
Message-Id: <200012201309.OAA08128@db0bm.ampr.org>
To: linux-kernel@vger.kernel.org
Subject: 2.2.19/2.4.0-test and usbdevfs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I use the usb bus. Mostly it is for a mouse and today, I have installed a
scanner. I've read the documentation (yes!) in
        /usr/src/linux/Documentation/usb/scanner.txt
There is a mention about the usbdevfs and an advice to add a line in
/etc/fstab. 

I have added the line "none /proc/bus/usb usbdevfs defaults 0 0", I expected to
have access to /proc/bus/usb/devices without any extra manipulation.

# /etc/fstab: static file system information.
#
# <file system> <mount point> <type> <options>                  <dump> <pass>
/dev/hda2       /             ext2   defaults,errors=remount-ro 0     	1
/dev/hdc1       none          swap   sw                         0   	0
proc            /proc         proc   defaults                   0	0
none            /dev/shm      shm    defaults       		0	0
none		/proc/bus/usb usbdevfs defaults 		0	0

At boot time, I get the messages :

Mounting local file systems...
modprobe: modprobe: Can't locate module shm
mount: fs type shm not supported by kernel
modprobe: modprobe: Can't locate module usbdevfs
mount: fs type usbdevfs not supported by kernel
Running dns-clean.

It is ok fr shm : I have the same fstab for both 2.2.19pre and 2.4.0-test and I
boot 2.2.19pre... And the I've nothing in /proc/bus/usb

If I enter the command 'by hand' :
mount -t usbdevfs /proc/bus/usb /proc/bus/usb
The system accepts the command and I can do a cat /proc/bus/usb/devices :

[root@debian-f5ibh] ~ # mount -t usbdevfs /proc/bus/usb /proc/bus/usb
[root@debian-f5ibh] ~ # cat /proc/bus/usb/devices
T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI Root Hub
S:  SerialNumber=6100
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=ff(vend.) Sub=ff Prot=ff MxPS=64 #Cfgs=  1
P:  Vendor=04b8 ProdID=010a Rev= 1.04
S:  Manufacturer=EPSON
S:  Product=Perfection1640
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  2mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#=  3 Spd=1.5 MxCh= 0
D:  Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=04b4 ProdID=0001 Rev= 0.00
S:  Manufacturer=Cypress Sem.
S:  Product=Cypress USB Mouse
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=hid
E:  Ad=81(I) Atr=03(Int.) MxPS=   3 Ivl= 10ms

[root@debian-f5ibh] ~ # cat /proc/bus/usb/drivers
         hid
         hub
         usbdevfs
			   

Do I missed something in my usb configuration or in my modules managements ?
Remark : The problem. is the same with 2.4.0-test13

System is :
-----------
Pentium 200MMX /64 Mb with :

-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux debian-f5ibh 2.2.19pre1 #1 sam déc 16 10:30:50 CET 2000 i586 unknown
Kernel modules         2.3.23
Gnu C                  2.95.2
Binutils               2.9.5.0.41
Linux C Library        2.1.3
Dynamic linker         ldd: version 1.9.11
Procps                 2.0.6
Mount                  2.10o
Net-tools              2.05
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded         af_packet scc ax25 parport_pc lp parport mousedev usb-uhci hid usbcore input autofs lockd sunrpc unix serial

.config  file is (many lines removed) :
---------------------------------------
#
CONFIG_EXPERIMENTAL=y

CONFIG_M586TSC=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_TSC=y
CONFIG_MODULES=y
CONFIG_KMOD=y

CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_QUIRKS=y
CONFIG_PCI_OPTIMIZE=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
#
# USB support
#
CONFIG_USB=m
CONFIG_USB_DEVICEFS=y
CONFIG_HOTPLUG=y
CONFIG_USB_UHCI=m
CONFIG_USB_SCANNER=m
CONFIG_USB_HID=m
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
------------------
Regards

		Jean-Luc
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
