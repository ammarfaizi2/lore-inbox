Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274226AbRIXWqA>; Mon, 24 Sep 2001 18:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274228AbRIXWpy>; Mon, 24 Sep 2001 18:45:54 -0400
Received: from paloma17.e0k.nbg-hannover.de ([62.159.219.17]:19685 "HELO
	paloma17.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S274227AbRIXWpi>; Mon, 24 Sep 2001 18:45:38 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: ReiserFS List <reiserfs-list@namesys.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux SCSI List <linux-scsi@vger.kernel.org>
Subject: URGENCY: IBM U160 SCSI disk spin-down from time to time
Date: Tue, 25 Sep 2001 00:45:57 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Chris Mason <mason@suse.com>, Nikita Danilov <Nikita@namesys.com>,
        "Vladimir V. Saveliev" <vs@namesys.com>,
        Hans Reiser <reiser@namesys.com>, support@storage.ibm.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20010924224544Z274227-760+16428@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, that I've cross posted but this is one of the worst cases...

First my system spec:

Athlon II 1 GHz (0.18µm)
MSI MS-6167 Rev 1.0B (AMD Irongate C4, without bypass)
640 MB PC100-2-2-2 SDRAM
AHA-2940UW (40 MB/sec)	I know it could be to slow, but it should be compatible
IBM DDYS-T18350N
IBM DDRS-34560D
IBM DDRS-34560W
TEAC CD-W512SB
PIONEER CD-ROM DR-U12X
3dfx Voodoo5 5500 AGP
Intel EtherExpress Pre100+
3Com 3c509 PnP ISA
SB Live!

All spin-downs occur during heavy dbench (16/32/+ clients) on the same 
partition (/dev/sda8; the last one).

Linux 2.4.10-preempt --- 1 time, only some hours ago :-(((
2.4.7ac3 --- 1 time
2.4.9-acX --- 3 times
2.410-preX --- 2 times

All with ReiserFS 3.6.25.
I've tried with APM and ACPI --- NO difference.
Nothing in the logs:-(

"Only" ReiserFS replay during reboot and after that I have to do
reiserfsck --rebuild-tree /dev/sdaXX to get some space back.
That's why I'm asking for the "unlink patch" ever and ever, again.
Chris? Nikita? Vladimir?

The very very bad thing is that IBM have to replace my first DDYS because it 
had "excessive shock error" message with there own diagnostic tool (DFT 
http://www.storage.ibm.com/hdd/support/download.htm) after two weeks.

Now this bad behavior.
Is the disk bad?
AHA-2940UW?
Linux SCSI driver to blame? --- I think both versions (the old and current) 
are used.
300W Athlon approved power supply to week? 
Power management?

Here comes my boot.msg file:

Inspecting /boot/System.map
Loaded 14634 symbols from /boot/System.map.
Symbols match kernel version 2.4.10.
Loaded 33 symbols from 2 modules.
klogd 1.3-3, log source = ksyslog started.
<4>Linux version 2.4.10-preempt (root@SunWave1) (gcc version 2.95.2 19991024 
(release)) #1 Mon Sep 24 17:18:25 CEST 2001
<6>BIOS-provided physical RAM map:
<4> BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
<4> BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
<4> BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
<4> BIOS-e820: 0000000000100000 - 0000000027ff0000 (usable)
<4> BIOS-e820: 0000000027ff0000 - 0000000027ff3000 (ACPI NVS)
<4> BIOS-e820: 0000000027ff3000 - 0000000028000000 (ACPI data)
<4> BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
<4>On node 0 totalpages: 163824
<4>zone(0): 4096 pages.
<4>zone(1): 159728 pages.
<4>zone(2): 0 pages.
<4>Local APIC disabled by BIOS -- reenabling.
<4>Found and enabled local APIC!
<4>Kernel command line: auto BOOT_IMAGE=linux ro root=803 
BOOT_FILE=/boot/vmlinuz reboot=warm
<6>Initializing CPU#0
<4>Detected 998.080 MHz processor.
<4>Console: colour VGA+ 80x25
<4>Calibrating delay loop... 1992.29 BogoMIPS
<4>Memory: 642628k/655296k available (1274k kernel code, 12280k reserved, 
303k data, 196k init, 0k highmem)
<4>Dentry-cache hash table entries: 131072 (order: 8, 1048576 bytes)
<4>Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
<4>Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
<4>Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
<4>Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
<7>CPU: Before vendor init, caps: 0183fbff c1c3fbff 00000000, vendor = 2
<6>Intel machine check architecture supported.
<6>Intel machine check reporting enabled on CPU#0.
<6>CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
<6>CPU: L2 Cache: 512K (64 bytes/line)
<7>CPU: After vendor init, caps: 0183fbff c1c3fbff 00000000 00000000
<7>CPU:     After generic, caps: 0183fbff c1c3fbff 00000000 00000000
<7>CPU:             Common caps: 0183fbff c1c3fbff 00000000 00000000
<4>CPU: AMD Athlon(tm) Processor stepping 02
<6>Enabling fast FPU save and restore... done.
<6>Checking 'hlt' instruction... OK.
<4>POSIX conformance testing by UNIFIX
<4>enabled ExtINT on CPU#0
<4>ESR value before enabling vector: 00000000
<4>ESR value after enabling vector: 00000000
<4>Using local APIC timer interrupts.
<4>calibrating APIC timer ...
<4>..... CPU clock speed is 998.1024 MHz.
<4>..... host bus clock speed is 199.6204 MHz.
<4>cpu: 0, clocks: 1996204, slice: 998102
<4>CPU0<T0:1996192,T1:998080,D:10,S:998102,C:1996204>
<4>mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
<4>mtrr: detected mtrr type: Intel
<4>PCI: PCI BIOS revision 2.10 entry at 0xfb430, last bus=1
<4>PCI: Probing PCI hardware
<6>Linux NET4.0 for Linux 2.4
<6>Based upon Swansea University Computer Society NET3.039
<4>Initializing RT netlink socket
<4>Starting kswapd
<6>ACPI: Core Subsystem version [20010831]
<6>ACPI: Subsystem enabled
<4>ACPI: System firmware supports S0 S1 S4 S5
<4>Processor[0]: C0 C1 C2, throttling states: 2
<6>Power Button: found
<6>Power Button: found
<6>Sleep Button: found
<4>pty: 256 Unix98 ptys configured
<6>Real Time Clock Driver v1.10e
<4>block: 128 slots per queue, batch=16
<6>SCSI subsystem driver Revision: 1.00
<4>spurious 8259A interrupt: IRQ7.
<6>scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.1
<4>        <Adaptec 2940 Ultra SCSI adapter>
<4>        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/255 SCBs
<4>
<4>  Vendor: IBM       Model: DDYS-T18350N      Rev: S96H
<4>  Type:   Direct-Access                      ANSI SCSI revision: 03
<4>  Vendor: IBM       Model: DDRS-34560D       Rev: DC1B
<4>  Type:   Direct-Access                      ANSI SCSI revision: 02
<4>  Vendor: IBM       Model: DDRS-34560W       Rev: S71D
<4>  Type:   Direct-Access                      ANSI SCSI revision: 02
<4>  Vendor: TEAC      Model: CD-W512SB         Rev: 1.0B
<4>  Type:   CD-ROM                             ANSI SCSI revision: 02
<4>  Vendor: PIONEER   Model: CD-ROM DR-U12X    Rev: 1.06
<4>  Type:   CD-ROM                             ANSI SCSI revision: 02
<4>scsi0:0:0:0: Tagged Queuing enabled.  Depth 253
<4>scsi0:0:1:0: Tagged Queuing enabled.  Depth 253
<4>scsi0:0:2:0: Tagged Queuing enabled.  Depth 253
<4>Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
<4>Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
<4>Attached scsi disk sdc at scsi0, channel 0, id 2, lun 0
<4>(scsi0:A:0): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
<4>SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)
<6>Partition check:
<6> sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 >
<4>(scsi0:A:1): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
<4>SCSI device sdb: 8925000 512-byte hdwr sectors (4570 MB)
<6> sdb: sdb1 sdb2 < sdb5 sdb6 sdb7 sdb8 >
<4>(scsi0:A:2): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
<4>SCSI device sdc: 8925000 512-byte hdwr sectors (4570 MB)
<6> sdc: sdc1
<6>NET4: Linux TCP/IP 1.0 for NET4.0
<6>IP Protocols: ICMP, UDP, TCP
<4>IP: routing cache hash table of 8192 buckets, 64Kbytes
<4>TCP: Hash tables configured (established 262144 bind 65536)
<6>NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
<4>reiserfs: checking transaction log (device 08:03) ...
<4>Using r5 hash to sort names
<4>ReiserFS version 3.6.25
<4>VFS: Mounted root (reiserfs filesystem) readonly.
<4>Freeing unused kernel memory: 196k freed
<6>Adding Swap: 1028120k swap-space (priority -1)
<4>reiserfs: checking transaction log (device 08:02) ...
<4>Using r5 hash to sort names
<4>ReiserFS version 3.6.25
<4>reiserfs: checking transaction log (device 08:05) ...
<4>Using r5 hash to sort names
<4>ReiserFS version 3.6.25
<4>reiserfs: checking transaction log (device 08:06) ...
<4>Using r5 hash to sort names
<4>ReiserFS version 3.6.25
<4>reiserfs: checking transaction log (device 08:07) ...
<4>Using r5 hash to sort names
<4>ReiserFS version 3.6.25
<4>reiserfs: checking transaction log (device 08:08) ...
<4>Using r5 hash to sort names
<4>ReiserFS version 3.6.25
<4>reiserfs: checking transaction log (device 08:11) ...
<4>Using r5 hash to sort names
<4>ReiserFS version 3.6.25
<4>reiserfs: checking transaction log (device 08:15) ...
<4>Using r5 hash to sort names
<4>ReiserFS version 3.6.25
<4>reiserfs: checking transaction log (device 08:16) ...
<4>Using r5 hash to sort names
<4>ReiserFS version 3.6.25
<4>reiserfs: checking transaction log (device 08:17) ...
<4>Using r5 hash to sort names
<4>ReiserFS version 3.6.25
<4>reiserfs: checking transaction log (device 08:18) ...
<4>Using r5 hash to sort names
<4>ReiserFS version 3.6.25
<6>isapnp: Scanning for PnP cards...
<6>isapnp: Card '3Com 3C509B EtherLink III'
<6>isapnp: 1 Plug & Play card detected total
<6>Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ 
SERIAL_PCI ISAPNP enabled
<6>ttyS00 at 0x03f8 (irq = 4) is a 16550A
<6>ttyS01 at 0x02f8 (irq = 3) is a 16550A
Kernel logging (ksyslog) stopped.
Kernel log daemon terminating.
Boot logging started at Mon Sep 24 18:59:06 2001
Activating swap-devices in /etc/fstab...
 done
Checking file systems...
Parallelizing fsck version 1.19a (13-Jul-2000)

<-------------reiserfsck, 2001------------->
reiserfsprogs 3.x.0k-pre10


<-------------reiserfsck, 2001------------->
reiserfsprogs 3.x.0k-pre10


<-------------reiserfsck, 2001------------->
reiserfsprogs 3.x.0k-pre10


<-------------reiserfsck, 2001------------->
reiserfsprogs 3.x.0k-pre10


<-------------reiserfsck, 2001------------->
reiserfsprogs 3.x.0k-pre10


<-------------reiserfsck, 2001------------->
reiserfsprogs 3.x.0k-pre10


<-------------reiserfsck, 2001------------->
reiserfsprogs 3.x.0k-pre10


<-------------reiserfsck, 2001------------->
reiserfsprogs 3.x.0k-pre10


<-------------reiserfsck, 2001------------->
reiserfsprogs 3.x.0k-pre10


<-------------reiserfsck, 2001------------->
reiserfsprogs 3.x.0k-pre10


<-------------reiserfsck, 2001------------->
reiserfsprogs 3.x.0k-pre10

 done
Mounting local file systems...
proc on /proc type proc (rw)
devpts on /dev/pts type devpts (rw,mode=0620,gid=5)
/dev/sda2 on /tmp type reiserfs (rw,notail)
/dev/sda5 on /var type reiserfs (rw,notail)
/dev/sda6 on /home type reiserfs (rw,notail)
/dev/sda7 on /usr type reiserfs (rw,notail)
/dev/sda8 on /opt type reiserfs (rw,notail)
/dev/sdb1 on /Pakete type reiserfs (rw,notail)
/dev/sdb5 on /database/db1 type reiserfs (rw,notail)
/dev/sdb6 on /database/db2 type reiserfs (rw,notail)
/dev/sdb7 on /database/db3 type reiserfs (rw,notail)
/dev/sdb8 on /database/db4 type reiserfs (rw,notail)
 done
Setting up the CMOS clock done
Setting up timezone data done
Setting up loopback device done
Setting up hostname done
Mount TMP FS on /dev/shm done
Configuring serial ports...
ttyS0 at 0x03f8 (irq = 4) is a 16550A
ttyS1 at 0x02f8 (irq = 3) is a 16550A
Configuring serial ports
 done
Running /etc/init.d/boot.local
Configuring MTTR for Intel Corporation EtherExpress PRO/100+...
 done
Creating /var/log/boot.msg
 done
Enabling syn flood protection done
Enabling IP forwarding done
Boot logging started at Mon Sep 24 20:59:12 2001
Master Resource Control: previous runlevel: N, switching to runlevel: 3
Starting personal-firewall (initial)/sbin/SuSEpersonal-firewall: 
/proc/sys/net/ipv4/icmp_echoreply_rate: No such file or directory
 [active] done
Initializing random number generator done
Setting up network device eth0
 done
Setting up network device eth1
 done
Setting up routing (using /etc/route.conf) done
Bringing up ADSL link done
Starting SSH daemon done
Starting syslog services done
Starting service usbmgr done
Starting service at daemon: done
Starting cupsd done
Loading keymap qwertz/de-latin1-nodeadkeys.map.gz
 done
Loading compose table winkeys shiftctrl latin1.add done
Loading console font lat9w-16.psfu.gz
 done
Loading unimap lat1u.uni
 done
Setting up console ttys
 done
Starting name server. done
Initializing SMTP port. (sendmail) done
Starting SAMBA nmbd : done
Starting SAMBA smbd : done
Starting CRON daemon done
Starting lan browser daemon for KDE done
Starting Name Service Cache Daemon done
Starting console mouse support (gpm): done
Starting inetd done
Starting httpd [ SuSEHelp contrib ] done
Starting personal-firewall (final)/sbin/SuSEpersonal-firewall: 
/proc/sys/net/ipv4/icmp_echoreply_rate: No such file or directory
 [active] done
Starting WWW-proxy squid: done
Master Resource Control: runlevel 3 has been reached

Any hints, tips are very well come.
Thank you very much in advance.

-Dieter
-- 
Dieter Nützel
Graduate Student, Computer Science

