Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266002AbTGDLna (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 07:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266004AbTGDLna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 07:43:30 -0400
Received: from [81.89.69.194] ([81.89.69.194]:30886 "EHLO tretyak.sun.mcst.ru")
	by vger.kernel.org with ESMTP id S266002AbTGDLn0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 07:43:26 -0400
Message-ID: <3F056D0D.3050101@mcst.ru>
Date: Fri, 04 Jul 2003 16:03:25 +0400
From: "Ilia A. Petrov" <masmas@mcst.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: PROBLEM: when booting from USB-HDD device kernel 2.4.21 is trying
 to mount root file system too early before usb device is found on the usb-bus
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When kernel is mounting root file system it is doing it too fast so 
usb-support have not ime to scan bus for mass-storage devices and 
connect them.

i've tested bios usb support, so i've checked how fine different OSes 
boot from USB mass-storage divices. here is my linux test:
	kernel 2.4.21, with compiled-in usb support (core, HID and mass-storage 
devices) and scsi generic support
	USB-HDD device supports bulk-only & scsi commands
	PC with BIOS that supports USB-booting

i've executed "rdev" to point kernel that root file system will be on 
/dev/sda1 (cause USB-HDD uses scsi commands, it's seen as an SCSI drive)

but when i tried to boot it i've found that kernel tries to mount root 
file system before is scans usb-bus for devices so it falls to panic :(

when i checked sources i've found that there is no way to delay this 
like it's doing when mounting floppy RAMDISK.

here is my system:

Linux version 2.4.21 (root@ejik) (gcc version 2.95.3 20010315 (release)) 
#4 Thu Jun 19 19:41:08 MSD 2003

Linux ejik 2.4.21 #4 Thu Jun 19 19:41:08 MSD 2003 i686 unknown

Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.11.90.0.19
util-linux             2.11f
mount                  2.11b
modutils               2.4.6
e2fsprogs              1.22
reiserfsprogs          3.x.0j
pcmcia-cs              3.1.26
PPP                    2.4.1
Linux C Library        2.2.3
Dynamic linker (ldd)   2.2.3
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
Modules Loaded         nvidia vmnet vmmon 3c59x

bash-2.05# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 1
model name      : Intel(R) Pentium(R) 4 CPU 1.70GHz
stepping        : 2
cpu MHz         : 1716.958
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 3420.97

bash-2.05# cat /proc/modules
nvidia               1540272  10 (autoclean)
vmnet                  21120   9
vmmon                  20000   0 (unused)
3c59x                  25120   1

bash-2.05# cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
5000-500f : Intel Corp. 82801BA/BAM SMBus
c000-c07f : 3Com Corporation 3c905C-TX/TX-M [Tornado]
   c000-c07f : 02:03.0
d000-d01f : Intel Corp. 82801BA/BAM USB (Hub #1)
   d000-d01f : usb-uhci
d800-d81f : Intel Corp. 82801BA/BAM USB (Hub #2)
   d800-d81f : usb-uhci
dc00-dcff : Intel Corp. 82801BA/BAM AC'97 Audio
   dc00-dcff : Intel ICH2
e000-e03f : Intel Corp. 82801BA/BAM AC'97 Audio
   e000-e03f : Intel ICH2
f000-f00f : Intel Corp. 82801BA IDE U100
   f000-f007 : ide0
   f008-f00f : ide1

bash-2.05# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000d0000-000d07ff : Extension ROM
000f0000-000fffff : System ROM
00100000-0ffeffff : System RAM
   00100000-002df321 : Kernel code
   002df322-0039c1b7 : Kernel data
0fff0000-0fff2fff : ACPI Non-volatile Storage
0fff3000-0fffffff : ACPI Tables
e0000000-e7ffffff : PCI Bus #01
   e0000000-e7ffffff : nVidia Corporation NV11 [GeForce2 MX]
     e0000000-e0bfffff : vesafb
e8000000-ebffffff : Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge
ec000000-edffffff : PCI Bus #01
   ec000000-ecffffff : nVidia Corporation NV11 [GeForce2 MX]
ef000000-ef00007f : 3Com Corporation 3c905C-TX/TX-M [Tornado]
fec00000-ffffffff : reserved

bash-2.05# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
   Vendor: IC25N020 Model: ATCS04-0         Rev: CA2O
   Type:   Direct-Access                    ANSI SCSI revision: 02


i've made a temporary solution- just copied a code that prints "insert 
floppy with ramdisk and press enter" a waits for keypress:

from function "change_floppy" in init/do_mounts.c:

	struct termios termios;
	char c;
	int fd;
	printk(KERN_NOTICE "VFS: Insert %s and press ENTER\n", buf);
	fd = open("/dev/console", O_RDWR, 0);
	if (fd >= 0) {
		sys_ioctl(fd, TCGETS, (long)&termios);
		termios.c_lflag &= ~ICANON;
		sys_ioctl(fd, TCSETSF, (long)&termios);
		read(fd, &c, 1);
		termios.c_lflag |= ICANON;
		sys_ioctl(fd, TCSETSF, (long)&termios);
		close(fd);
	}

to function "mount_block_root" in init/do_mounts.c before 
"get_fs_names(fs_names)" call.

it works fine: i wait for message that kernel found USB mass-storage 
device and then press enter, but i think it isn't a best solution.
first u always need press a key to boot
second - if pc has only usb-keyboard connected and no pc\2 or com- user 
couldn't mount root fs because it waits input in /dev/console

so i think it's better to add some kind of delay before mounting root, 
or, imho better way, - when completing init of usb bus, first scans it 
and connect all devices and only after all devices were connected 
returns to main kernel code.

regards,
	Ilia Petrov


