Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316621AbSE3Mrf>; Thu, 30 May 2002 08:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316623AbSE3Mrf>; Thu, 30 May 2002 08:47:35 -0400
Received: from altern.org ([80.67.174.57]:50864 "HELO altern.org")
	by vger.kernel.org with SMTP id <S316621AbSE3Mr3>;
	Thu, 30 May 2002 08:47:29 -0400
Date: Thu, 30 May 2002 14:47:11 +0200 (CEST)
From: <archi2k@altern.org>
Subject: 2.4.18 cat /proc/219/cmdline => segfaults ; ps aux => oops
To: linux-kernel@vger.kernel.org, archi2k@altern.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Message-Id: <20020530124729Z316621-22651+70018@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

dunno why, but I wasn't able to ps aux one of my machines
this morning (woody + unpatched virgin 2.4.18 kernel): 
ps aux seg fault. Same pb with top, etc...
After a little more investigation, I found that I
couldn't cat /proc/219/cmdline (sshd process).
I was still able to use sshd and other services on the
box, though.
Anyway, lots of oops on my syslog output.
Here is the 2 first ones, and various stuff. 
If you think somethin' else is missing to my report 
please ask me for it.
Cheers

a2k

Please cc me, I'm not on the list

Note:   Uptime was 3 days when it happened.
	This box ran potato/kernel.2.2.x without any 
	problem (an with big uptimes)
	I hade to upgrade because of LVM and large files.

********* VARIOUS (maybe useful, maybe not) STUFF***************

maia:/home/misterfx# cd /proc/
maia:/proc# ls
1      169    20447  20653  211    288   bus          kcore       stat
11335  176    20448  20654  216    289   cmdline      kmsg        swaps
11400  186    20449  20655  219    3     cpuinfo      loadavg     sys
12753  191    20460  20656  222    4     devices      locks       sysvipc
12755  2      20479  20657  22908  5     dma          lvm         tty
12757  20373  20644  20658  24605  6     driver       meminfo     uptime
12758  20374  20645  20659  24734  6579  execdomains  misc        version
12773  20380  20646  20660  24960  6804  filesystems  mounts
12780  20383  20647  20661  25120  6965  fs           net
12781  20442  20648  20662  25121  7     ide          partitions
12782  20443  20649  20667  279    7194  interrupts   pci
15347  20444  20650  20671  281    7197  iomem        scsi
163    20445  20651  20672  283    8     ioports      self
167    20446  20652  209    285    apm   irq          slabinfo
maia:/proc# cat /proc/219/cmdline 
Segmentation fault
maia:/proc# /etc/init.d/sshd restart
Stopping ssh daemon: sshd

<blocked>

[1]+  Stopped                 /etc/init.d/sshd restart
maia:/proc# 
maia:/proc# 
maia:/proc# ps aux
USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.0  1272  436 ?        S    May26   0:04 init [2] 
root         2  0.0  0.0     0    0 ?        SW   May26   0:00 [keventd]
root         3  0.0  0.0     0    0 ?        SW   May26   0:00 [kapmd]
root         4  0.0  0.0     0    0 ?        SWN  May26   0:00 [ksoftirqd_CPU0]
root         5  0.0  0.0     0    0 ?        Z    May26   3:27 [kswapd <defunct>
root         6  0.0  0.0     0    0 ?        SW   May26   0:04 [bdflush]
root         7  0.0  0.0     0    0 ?        SW   May26   0:07 [kupdated]
root         8  0.0  0.0     0    0 ?        SW   May26   0:00 [scsi_eh_0]
root       163  0.0  0.1  1344  544 ?        S    May26   0:00 /sbin/syslogd
root       167  0.0  0.1  1436  564 ?        S    May26   0:00 /usr/local/sbin/s
root       169  0.0  0.0  1780  488 ?        S    May26   0:00 /sbin/klogd
root       176  0.0  0.1  1996  560 ttyS0    S    May26   0:00 /usr/sbin/pppd pe
root       186  0.0  0.3  1668 1660 ?        SL   May26   0:00 /usr/local/bin/nt
root       191  0.0  0.0  1248   80 ?        S    May26   0:00 /usr/sbin/inetd
root       209  0.0  0.0  1328    4 ?        S    May26   0:00 /sbin/upsmon
nut        211  0.0  0.0  1464  152 ?        S    May26   0:00 /sbin/upsmon
Segmentation fault

************* FIRST OOPS ****************

maia:/var/log/maia/2002/05/30# ksymoops -K   -L -O -m /boot/System.map-2.4.18mfx1 < /tmp/uche                      
ksymoops 2.4.5 on i686 2.4.18mfx1.  Options used
     -V (default)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /boot/System.map-2.4.18mfx1 (specified)

c011e97a
00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c011e97a>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 090d01e8   ebx: bffff000   ecx: 00000000   edx: 090d0200
esi: c6e819c0   edi: bffffeec   ebp: bffff000   esp: c7667eb8
ds: 0018   es: 0018   ss: 0018
Process top (pid: 15000, stackpage=c7667000)
Stack: 00000000 c6e819c0 c011ea6c c6e819c0 bffff000 00000000 c6e819c0 bffffeec 
c7666000 df59ea40 c011d092 c6e819c0 bffffeec 00000000 c6e819c0 d58c9000 
d58c9000 00000010 c0117679 c7666000 c6e819c0 bffffeec 00000001 00000000 
Call Trace: [<c011ea6c>] [<c011d092>] [<c0117679>] [<c0146d39>] [<c0146f8a>] 
[<c012b0d6>] [<c0106c5b>] 
Code: 39 5a f0 76 f1 89 c1 39 5a ec 77 e2 85 c9 74 03 89 4e 08 89 


>>EIP; c011e97a <find_vma+3a/60>   <=====

>>eax; 090d01e8 Before first symbol
>>ebx; bffff000 Before first symbol
>>edx; 090d0200 Before first symbol
>>esi; c6e819c0 <END_OF_CODE+6bbf90c/????>
>>edi; bffffeec Before first symbol
>>ebp; bffff000 Before first symbol
>>esp; c7667eb8 <END_OF_CODE+73a5e04/????>

Trace; c011ea6c <find_extend_vma+1c/b0>
Trace; c011d092 <get_user_pages+52/180>
Trace; c0117679 <access_process_vm+109/150>
Trace; c0146d39 <proc_pid_cmdline+49/e0>
Trace; c0146f8a <proc_info_read+5a/120>
Trace; c012b0d6 <sys_read+96/f0>
Trace; c0106c5b <system_call+33/38>

Code;  c011e97a <find_vma+3a/60>
00000000 <_EIP>:
Code;  c011e97a <find_vma+3a/60>   <=====
   0:   39 5a f0                  cmp    %ebx,0xfffffff0(%edx)   <=====
Code;  c011e97d <find_vma+3d/60>
   3:   76 f1                     jbe    fffffff6 <_EIP+0xfffffff6> c011e970 <find_vma+30/60>
Code;  c011e97f <find_vma+3f/60>
   5:   89 c1                     mov    %eax,%ecx
Code;  c011e981 <find_vma+41/60>
   7:   39 5a ec                  cmp    %ebx,0xffffffec(%edx)
Code;  c011e984 <find_vma+44/60>
   a:   77 e2                     ja     ffffffee <_EIP+0xffffffee> c011e968 <find_vma+28/60>
Code;  c011e986 <find_vma+46/60>
   c:   85 c9                     test   %ecx,%ecx
Code;  c011e988 <find_vma+48/60>
   e:   74 03                     je     13 <_EIP+0x13> c011e98d <find_vma+4d/60>
Code;  c011e98a <find_vma+4a/60>
  10:   89 4e 08                  mov    %ecx,0x8(%esi)
Code;  c011e98d <find_vma+4d/60>
  13:   89 00                     mov    %eax,(%eax)

************* END OF FIRST OOPS *****************


************* SECOND OOPS ***********************
maia:/home/misterfx# ksymoops -K   -L -O -m /boot/System.map-2.4.18 < /tmp/uic                       
ksymoops 2.4.5 on i686 2.4.18.  Options used
     -V (default)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /boot/System.map-2.4.18mfx1 (specified)

Invalid operand: 0000
CPU:    0
EIP:    0010:[<c0125652>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 08040000   ebx: 0804b000   ecx: 0804b000   edx: c1925000
esi: dfe3e140   edi: 00000001   ebp: dfd5a12c   esp: c1837efc
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 5, stackpage=c1837000)
Stack: 00000000 c1561200 0000001a ffffffff 0804b000 08448000 c1836000 04974047 
00000001 0804b000 c1925084 0804b000 08400000 08040000 c1925080 d9e4fac0 
00000012 c1836000 dfe3e140 c02479e8 00677400 c0125c08 00000020 000001d0 
Call Trace: [<c0125c08>] [<c0125db6>] [<c0125e2c>] [<c0125ec3>] [<c0125f26>] 
[<c012603d>] [<c01054e8>] 
Code: 0f 0b 89 4c 24 30 89 fb 8b 54 24 38 8b 74 24 34 89 54 24 28 


>>EIP; c0125652 <swap_out+122/470>   <=====

>>eax; 08040000 Before first symbol
>>ebx; 0804b000 Before first symbol
>>ecx; 0804b000 Before first symbol
>>edx; c1925000 <END_OF_CODE+1662f4c/????>
>>esi; dfe3e140 <END_OF_CODE+1fb7c08c/????>
>>ebp; dfd5a12c <END_OF_CODE+1fa98078/????>
>>esp; c1837efc <END_OF_CODE+1575e48/????>

Trace; c0125c08 <shrink_cache+268/2f0>
Trace; c0125db6 <shrink_caches+56/90>
Trace; c0125e2c <try_to_free_pages+3c/60>
Trace; c0125ec3 <kswapd_balance_pgdat+43/90>
Trace; c0125f26 <kswapd_balance+16/30>
Trace; c012603d <kswapd+9d/c0>
Trace; c01054e8 <kernel_thread+28/40>

Code;  c0125652 <swap_out+122/470>
00000000 <_EIP>:
Code;  c0125652 <swap_out+122/470>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0125654 <swap_out+124/470>
   2:   89 4c 24 30               mov    %ecx,0x30(%esp,1)
Code;  c0125658 <swap_out+128/470>
   6:   89 fb                     mov    %edi,%ebx
Code;  c012565a <swap_out+12a/470>
   8:   8b 54 24 38               mov    0x38(%esp,1),%edx
Code;  c012565e <swap_out+12e/470>
   c:   8b 74 24 34               mov    0x34(%esp,1),%esi
Code;  c0125662 <swap_out+132/470>
  10:   89 54 24 28               mov    %edx,0x28(%esp,1)

************* EO SECOND OOPS ****************

dmesg :

Linux version 2.4.18mfx1 (root@maia) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 Sun May 26 13:59:43 CEST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ffec000 (usable)
 BIOS-e820: 000000001ffec000 - 000000001ffef000 (ACPI data)
 BIOS-e820: 000000001ffef000 - 000000001ffff000 (reserved)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 131052
zone(0): 4096 pages.
zone(1): 126956 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=.o00o. ro root=303
Initializing CPU#0
Detected 1343.053 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2680.42 BogoMIPS
Memory: 513784k/524208k available (1100k kernel code, 10036k reserved, 282k data, 208k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Before vendor init, caps: 0383f9ff c1cbf9ff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0383f9ff c1cbf9ff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383f9ff c1cbf9ff 00000000 00000000
CPU:             Common caps: 0383f9ff c1cbf9ff 00000000 00000000
CPU: AMD Athlon(TM) XP1500+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xf0df0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router VIA [1106/3074] at 00:11.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
block: 128 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 89
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci00:11.1
    ide0: BM-DMA at 0xb000-0xb007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xb008-0xb00f, BIOS settings: hdc:DMA, hdd:pio
hda: IC35L040AVER07-0, ATA DISK drive
hdc: ASUS CD-S520/A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=5005/255/63, UDMA(100)
hdc: ATAPI 52X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 hda10 >
floppy0: no floppy controllers found
loop: loaded (max 8 devices)
PCI: Found IRQ 10 for device 00:0f.0
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:0f.0: 3Com PCI 3c905C Tornado at 0xb400. Vers LK1.1.16
PPP generic driver version 2.4.1
PPP Deflate Compression module registered
PPP BSD Compression module registered
SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 11 for device 00:0d.0
PCI: Sharing IRQ 11 with 01:00.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
        <Adaptec 29160 Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

  Vendor: IBM       Model: DDYS-T36950N      Rev: S96H
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi0:A:14): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
scsi0:A:14:0: Tagged Queuing enabled.  Depth 253
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
Attached scsi disk sda at scsi0, channel 0, id 14, lun 0
SCSI device sda: 71687340 512-byte hdwr sectors (36704 MB)
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 >
LVM version 1.0.1-rc4(ish)(03/10/2001)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
ip_conntrack (4095 buckets, 32760 max)
ip_tables: (C) 2000-2002 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 208k freed
Adding Swap: 498004k swap-space (priority -1)


-EOF-
