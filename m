Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264706AbSKSBD5>; Mon, 18 Nov 2002 20:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264939AbSKSBD5>; Mon, 18 Nov 2002 20:03:57 -0500
Received: from air-2.osdl.org ([65.172.181.6]:31469 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S264706AbSKSBDw>;
	Mon, 18 Nov 2002 20:03:52 -0500
Subject: Re: [ANNOUNCE][CFT] kexec for v2.5.48 && kexec-tools-1.7 -- Success
	Story!
From: Andy Pfiffer <andyp@osdl.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Werner Almesberger <wa@almesberger.net>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Mike Galbraith <efault@gmx.de>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>,
       Linuxbios <linuxbios@clustermatic.org>
In-Reply-To: <m11y5j2r9t.fsf_-_@frodo.biederman.org>
References: <Pine.LNX.4.44.0211091901240.2336-100000@home.transmeta.com>
	<m1vg349dn5.fsf@frodo.biederman.org> <1037055149.13304.47.camel@andyp>
	<m1isz39rrw.fsf@frodo.biederman.org> <1037148514.13280.97.camel@andyp>
	<m1k7jb3flo.fsf_-_@frodo.biederman.org>
	<m1el9j2zwb.fsf@frodo.biederman.org> 
	<m11y5j2r9t.fsf_-_@frodo.biederman.org>
Content-Type: multipart/mixed; boundary="=-+OkhnJ7T5oEp7prO04YW"
X-Mailer: Ximian Evolution 1.0.5 
Date: 18 Nov 2002 17:10:38 -0800
Message-Id: <1037668241.10400.48.camel@andyp>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+OkhnJ7T5oEp7prO04YW
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2002-11-18 at 00:53, Eric W. Biederman wrote:
> kexec is a set of systems call that allows you to load another kernel
> from the currently executing Linux kernel.  The current implementation
> has only been tested, and had the kinks worked out on x86, but the
> generic code should work on any architecture.

Great News, Eric.  For the first time *ever* I got a kexec reboot to
work on my most troublesome machine (see below).

Current .config settings:
# CONFIG_SMP is not set
CONFIG_X86_GOOD_APIC=y
# CONFIG_X86_UP_APIC is not set
CONFIG_KEXEC=y

Oddly, kexec_test still hangs.
# ./kexec-1.7 --force ./kexec_test-1.7
FIXME assuming 6Synchronizing SCSI caches: 4M of ram

Shutting down devices
Starting new kernel
kexec_test 1.7 starting...
eax: 0E1FB007 ebx: 0000111C ecx: 00000000 edx: 00000000
esi: 00000000 edi: 00000000 esp: 00000000 ebp: 00000000
idt: 00000000 C0000000
gdt: 0000006F 000010A0
Switching descriptors.
Descriptors changed.
Legacy pic setup.
In real mode.
<hang>

Complete kernel boot-up log attached below.  I'm going to try to find my
other 576MB of RAM with the right command-line magic... ;^)

For those looking to replicate:


    0. apply these two patches to 2.5.48 (bk Changeset 1.842)
    http://www.xmission.com/~ebiederm/files/kexec/linux-2.5.48.x86kexec.diff
    http://www.xmission.com/~ebiederm/files/kexec/linux-2.5.48.x86kexec-hwfixes.diff
    
    2. compile this:
    http://www.xmission.com/~ebiederm/files/kexec/kexec-tools-1.7.tar.gz
    
    3. my recipe for rebooting:
    a) I have a script that I execute by hand after "init 1" to unmount
    my filesystems and then remount / and /boot read-only.
    b) I have the kexec binary installed in /boot.
    c) ./kexec-1.7 --force --debug "--command-line=ro root=805
    console=ttyS0,9600n8" ./linux-2.5

Thanks, Eric!

Andy


--=-+OkhnJ7T5oEp7prO04YW
Content-Description: 
Content-Disposition: inline; filename=it-worked
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1

# ./kexec-1.7 --force --debug "--command-line=3Dro root=3D805 console=3Dtty=
S0,9600n8" ./linux-2.5
FIXME assuming 64M of ram
setup16_end: 00091b1f
FIXME assuming 64M of ram
Synchronizing SCSI caches:=20
Shutting down devices
Starting new kernel
Linux version 2.5.48 (andyp@joe) (gcc version 2.95.3 20010315 (SuSE)) #1 Mo=
n Nov 18 15:03:14 PST 2002
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000001000 - 000000000009ffff (usable)
 BIOS-e820: 0000000000100000 - 0000000003ffffff (usable)
63MB LOWMEM available.
hm, page 00000000 reserved twice.
On node 0 totalpages: 16383
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 12287 pages, LIFO batch:2
  HighMem zone: 0 pages, LIFO batch:1
IBM machine detected. Enabling interrupts during APM calls.
IBM machine detected. Disabling SMBus accesses.
Building zonelist for node : 0
Kernel command line: ro root=3D805 console=3DttyS0,9600n8
Initializing CPU#0
Detected 799.717 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1581.05 BogoMIPS
Memory: 60868k/65532k available (2087k kernel code, 4204k reserved, 825k da=
ta, 304k init, 0k highmem)
Security Scaffold v1.0.0 initialized
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Coppermine) stepping 0a
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.9 (c) Adam Belay
PCI: PCI BIOS revision 2.10 entry at 0xfd5dc, last bus=3D1
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 116 entries (12 bytes)
biovec pool[1]:   4 bvecs: 116 entries (48 bytes)
biovec pool[2]:  16 bvecs:  58 entries (192 bytes)
biovec pool[3]:  64 bvecs:  29 entries (768 bytes)
biovec pool[4]: 128 bvecs:  14 entries (1536 bytes)
biovec pool[5]: 256 bvecs:   7 entries (3072 bytes)
block request queues:
 112 requests per read queue
 112 requests per write queue
 8 requests per batch
 enter congestion at 27
 exit congestion at 29
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Discovered peer bus 01
Starting kswapd
aio_setup: sizeof(struct page) =3D 40
[c3fb2040] eventpoll: successfully initialized.
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
Capability LSM initialized
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
parport0: PC-style at 0x378 [PCSPP]
pty: 256 Unix98 ptys configured
lp0: using parport0 (polling).
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 27M
agpgart: unable to determine aperture size.
agpgart: Maximum main memory to use for agp memory: 27M
agpgart: unable to determine aperture size.
[drm] Initialized radeon 1.7.0 20020828 on minor 0
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
Intel(R) PRO/100 Network Driver - version 2.1.24-k2
Copyright (c) 2002 Intel Corporation

e100: eth0: Intel(R) PRO/100+ Server Adapter (PILA8470B)
  Mem:0xfeb7f000  IRQ:11  Speed:0 Mbps  Dx:N/A
  Hardware receive checksums enabled
  cpu cycle saver enabled

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
hda: LG CD-ROM CRD-8484B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 48X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
end_request: I/O error, dev hda, sector 0
SCSI subsystem driver Revision: 1.00
PCI: Enabling device 01:03.0 (0156 -> 0157)
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
        <Adaptec aic7892 Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=3D7, 32/253 SCBs

(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 31, 16bit)
  Vendor: IBM-PSG   Model: ST318436LC    !#  Rev: 3281
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi0:A:1): 160.000MB/s transfers (80.000MHz DT, offset 31, 16bit)
  Vendor: IBM-PSG   Model: ST318436LC    !#  Rev: 3281
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: IBM       Model: YGLv3 S2          Rev: 0  =20
  Type:   Processor                          ANSI SCSI revision: 02
scsi0:A:0:0: Tagged Queuing enabled.  Depth 64
SCSI device sda: drive cache: write through
SCSI device sda: 35548320 512-byte hdwr sectors (18201 MB)
 sda: sda1 sda2 < sda5 sda6 sda7 sda8 sda9 sda10 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
scsi0:A:1:0: Tagged Queuing enabled.  Depth 64
SCSI device sdb: drive cache: write through
SCSI device sdb: 35548320 512-byte hdwr sectors (18201 MB)
 sdb: sdb1
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
Attached scsi generic sg2 at scsi0, channel 0, id 8, lun 0,  type 3
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
mice: PS/2 mouse device common for all mice
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
Advanced Linux Sound Architecture Driver Version 0.9.0rc5 (Sun Nov 10 19:48=
:18 2002 UTC).
request_module[snd-card-0]: not ready
request_module[snd-card-1]: not ready
request_module[snd-card-2]: not ready
request_module[snd-card-3]: not ready
request_module[snd-card-4]: not ready
request_module[snd-card-5]: not ready
request_module[snd-card-6]: not ready
request_module[snd-card-7]: not ready
ALSA device list:
  No soundcards found.
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 304k freed
INIT: version 2.82 booting
Running /etc/init.d/boot
Mounting /proc device                                                done
Mounting /dev/ptsblogd: console=3D/dev/console, stdin=3D/dev/console, must =
differ, boot logging disabled
showconsole: Warning: the ioctl TIOCGDEV is not known by the kerAdding 5301=
04k swap on /dev/sda6.  Priority:42 extents:1
nel
Activating swap-devices in /etc/fstab...                             done
showconsole: Warning: the ioctl TIOCGDEV is not known by the kernel
Checking file systems...
fsck 1.26 (3-Feb-2002)
/dev/sda5: clean, 16935/66264 files, 104836/265041 blocks
/dev/sda1: clean, 55/10040 files, 24115/40131 blocks
/dev/sdb1: clean, 11/2223872 files, 78008/4441964 blocks
/dev/sda10: clean, 523256/1198208 files, 2052639/2393677 blocks
/dev/sda9: clean, 51895/263296 files, 310582/526120 blocks
/dev/sda8: clean, 140195/525888 files, 590977/1050241 blocks
/dev/sda7: clean, EXT3 FS 2.4-0.9.16, 02 Dec 2001 on sd(8,5), 2747/131616 f=
ileinternal journal
s, 111363/263056 blocks                                              done
Setting up /lib/modules/2.5.48                                       failed
Mounting local file systems...
kjournald starting.  Commit interval 5 seconds
proc on /proc tyEXT3 FS 2.4-0.9.16, 02 Dec 2001 on sd(8,17), pe proc (rw)
deinternal journal
vpts on /dev/ptsEXT3-fs: mounted filesystem with ordered data mode.
 type devpts (rw,mode=3D0620,gid=3D5)
/dev/sdb1 on /2nd type ext3 (kjournald starting.  Commit interval 5 seconds
rw)
/dev/sda1 oEXT3 FS 2.4-0.9.16, 02 Dec 2001 on sd(8,10), n /boot type extint=
ernal journal
2 (rw)
EXT3-fs: mounted filesystem with ordered data mode.
/dev/sda10 on /home type ext3 (rw)
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on sd(8,9), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
/dev/sda9 on /opt type ext3 (rw)
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on sd(8,8), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
/dev/sda8 on /usr type ext3 (rw)
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on sd(8,7), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
/dev/sda7 on /var type ext3 (rw)                                     done
Restore device permissions                                           done
Activating remaining swap-devices in /etc/fstab...                   done
Setting up the CMOS clock                                            done
Setting up timezone data                                             done
Configuring serial ports...
ttyS0 at 0x03f8 (irq =3D 4) is a 16550A
ttyS1 at 0x02f8 (irq =3D 3) is a 16550A
Configured serial ports                                              done
Setting up hostname 'joe'                                            done
Setting up loopback interface                                        done
Creating /var/log/boot.msg                                           done
showconsole: Warning: the ioctl TIOCGDEV is not known by the kernel
INIT: Entering runlevel: 5
blogd: console=3D/dev/console, stdin=3D/dev/console, must differ, boot logg=
ing disabled
Master Resource Control: previous runlevel: N, switching to runlevel:5
Starting personal-firewall (initial) [not active]                    unused
Initializing random number generator                                 done
Setting up network interfaces:
    lo                                                               done
    eth0      (DHCP) IP address: 172.20.1.38                         done
Starting syslog services                                             done
Starting hotplugging services [ net pci usb ]                        failed
Starting hardware scan on boote100: eth0 NIC Link is Up 100 Mbps Full duple=
x
                                                                     done
Starting RPC portmap daemon                                          done
Starting SSH daemon                                                  done
Starting sound driver:  already running                              done
Starting service at daemon                                           done
Initializing SMTP port (sendmail)                                    done
Loading keymap qwerty/us.map.gz                                      done
Loading compose table winkeys shiftctrl latin1.add                   done
Loading console font lat1-16.psfu                                    done
Loading screenmap none                                               done
Setting up console ttys                                              done
Starting service kdm                                                 done
Starting CRON daemon                                                 done
Starting Name Service Cache Daemon                                   done
Starting inetd                                                       done
Starting personal-firewall (final) [not active]                      unused
Master Resource Control: runlevel 5 has been                         reache=
d
Failed services in runlevel 5:                                   hotplug
Skipped services in runlevel 5:  personal-firewall.initial splash personal-=
firewall.final


--=-+OkhnJ7T5oEp7prO04YW--

