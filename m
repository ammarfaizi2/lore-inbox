Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280091AbRJaGgk>; Wed, 31 Oct 2001 01:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280093AbRJaGga>; Wed, 31 Oct 2001 01:36:30 -0500
Received: from slide.SoftHome.net ([66.54.152.30]:28118 "HELO
	waltz.SoftHome.net") by vger.kernel.org with SMTP
	id <S280091AbRJaGgK>; Wed, 31 Oct 2001 01:36:10 -0500
Message-ID: <20011031060043.14799.qmail@softhome.net>
From: krajput@softhome.net
To: linux-kernel@vger.kernel.org
Subject: Oops msg after upgrading to 2.4.10
Date: Wed, 31 Oct 2001 06:00:43 GMT
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have tried to upgrade my Linux 7.1 (kernel version 2.4.2) to kernel
version 2.4.10 but to no avail. The kernel does install but fails to load
the USB uhci subsytem. Infact when i do "lsmod" after the upgrade it shows
me an empty table. Here are the steps that i undertook for the total
upgrade

1. Copied and untarred the linux-2.4.10.tzr.gz file in a seperate directory
   (/usr/scr/linux)
2. cd /usr/src/linux
3. make menuconfig (Did not alter its original 7.1 configuration in which 
Uhci was installed)
4. make dep
5. make clean
6. make bzImage
7. make modules
8. make modules_install
9. cp arch/i386/boot/bzImage /boot/bzImage-2.4.10
10. rm /boot/System.map
11. cp System.map /boot/System.map-2.4.10
12. ln -s /boot/System.map-2.4.10 /boot/System.map
13. pico /etc/lilo.conf ( and changed the image=/boot/bzImage-2.4.10)
14. /sbin/lilo
15. Reboot

 When i connected a USB mouse after the upgrade, this is what i was able to
gather form the 'dmesg' command. Do note the oops message.

Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
bluetooth.c: USB Bluetooth support registered
usb.c: registered new driver bluetooth
bluetooth.c: USB Bluetooth tty driver v0.12
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 16Kbytes
TCP: Hash tables configured (established 8192 bind 10922)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ds: no socket drivers loaded!
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 228k freed
Adding Swap: 819272k swap-space (priority -1)
usb-uhci.c: $Revision: 1.268 $ time 21:33:18 Oct 30 2001
usb-uhci.c: High bandwidth mode enabled
PCI: Setting latency timer of device 00:1f.2 to 64
usb-uhci.c: USB UHCI at I/O 0xd000, IRQ 12
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
usb.c: kmalloc IF cfe193d4, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB UHCI Root Hub
SerialNumber: d000
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface cfe193d4
usb.c: kusbd: /sbin/hotplug add 1
hub.c: port 2 connection change
hub.c: port 2, portstatus 301, change 1, 1.5 Mb/s
usb-uhci.c: v1.268:USB Universal Host Controller Interface driver
usb.c: USB disconnect on device 1
usb.c: kusbd: /sbin/hotplug remove 1
usb.c: USB bus 1 deregistered
Unable to handle kernel paging request at virtual address 7375626f
 printing eip:
c021e1c4
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c021e1c4>]
EFLAGS: 00010246
eax: 7375622f   ebx: cfe34c00   ecx: 00000000   edx: c1457000
esi: 7375622f   edi: cfe34d44   ebp: cf48f800   esp: cfe17f44
ds: 0018   es: 0018   ss: 0018
Process khubd (pid: 7, stackpage=cfe17000)
Stack: c021ec06 7375622f cfe34c00 7375622f 000000c8 c022273c cfe34c00
7375622f cf48f400 00000000 00001a6f 00000001 00000286 00000001 c0386ee3
cfe17fbc 00000001 cfe34c00 00000002 c02229c8 cfe34c00 00000001 cfe17fbc
c02dffe0 
Call Trace: [<c021ec06>] [<c022273c>] [<c02229c8>] [<c0222bf5>]
[<c0105000>] [<c0105756>] [<c0222b80>] 

Code: f0 ff 40 40 c3 8d b4 26 00 00 00 00 8b 54 24 04 f0 ff 4a 40 

Thanking you in advance for any assistance.

Kashif!
