Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319013AbSHMRMB>; Tue, 13 Aug 2002 13:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319015AbSHMRMB>; Tue, 13 Aug 2002 13:12:01 -0400
Received: from ip68-2-45-167.ph.ph.cox.net ([68.2.45.167]:45840 "HELO
	radagast.kode187.net") by vger.kernel.org with SMTP
	id <S319013AbSHMRL7>; Tue, 13 Aug 2002 13:11:59 -0400
Date: Tue, 13 Aug 2002 10:17:12 -0700
From: "Bruce J.A. Nourish" <kode187@kode187.net>
To: linux-kernel@vger.kernel.org
Subject: Strange console driver bug on 486
Message-ID: <20020813171712.GA3598@kode187.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

Something strange is happening when I try to boot Linux on my laptop.
The kernel makes it all the way through to mounting the root filesystem,
but then no more messages appear on the console, and no user-land
programs are able to communicate using the virtual terminal driver.
(And yes, I do have the appropriate /dev entries, before you stop reading).

When I first tried to boot, I used a root disk with busybox and a few
other utils on it. Next I tried a bare 386 kernel with math emulation
and the no387 option. Then I replaced the root disk with a disk
containing a statically linked ash and a just enough /dev/ entries to
boot. I tried different bootloaders (LILO, GRUB, syslinux, loadlin from
freedos, the kernel's own loader), but to no avail. All the above
combinations worked fine on all the other machines I have access to.

MINIX and FreeDOS are installed on the hard-disk, and both work fine.
I was under the impression that the kernel used the same VGA driver to
output it's startup printk() messages as for the vt driver; if so, this
becomes very mysterious. What else could go wrong? SysRq-Show State
tells me that the ash process is alive and well. 

I'm willing to halp debug any new code that might help this problem. If
you'd like my .config file, email me (my facist ISP made me shut down my
FTP and webservers).

Linux version 2.4.20-pre1-ac3 (kode187@gandalf) (gcc version 2.95.3 20010315 (release)) #6 Tue Aug 13 09:32:40 MST 2002
BIOS-provided physical RAM map:        
 BIOS-88: 0000000000000000 - 000000000009f000 (usable)
 BIOS-88: 0000000000100000 - 0000000000800000 (usable)
8MB LOWMEM available.                                 
On node 0 totalpages: 2048
zone(0): 2048 pages.      
zone(1): 0 pages.   
zone(2): 0 pages.
Kernel command line: init=/sh console=ttyS0,57600 BOOT_IMAGE=bzimage
Initializing CPU#0                                                  
Console: colour VGA+ 80x25
Calibrating delay loop... 37.47 BogoMIPS
Memory: 6540k/8192k available (791k kernel code, 1264k reserved, 135k data, 48k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Dentry cache hash table entries: 1024 (order: 1, 8192 bytes)                
Inode cache hash table entries: 512 (order: 0, 4096 bytes)  
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 2048 (order: 1, 8192 bytes)  
Page-cache hash table entries: 2048 (order: 1, 8192 bytes)  
CPU: Intel 486 DX/4 stepping 00                           
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4         
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket                         
Starting kswapd               
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Serial driver version 5.05c (2001-07-08) with no serial options enabled
ttyS00 at 0x03f8 (irq = 4) is a 16450                                  
block: 32 slots per queue, batch=8   
Floppy drive(s): fd0 is 1.44M     
FDC 0 is an 8272A            
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 512 bind 1024)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.    
VFS: Insert root floppy and press ENTER            
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 48k freed      

SysRq : Show State                     
                  
                         free                        sibling
  task             PC    stack   pid father child younger older
sh            R current   5096     1      0     6               (NOTLB)
Call Trace:    [<c0107500>] [<c0106de4>]                               
keventd       S 00010000     0     2      1             3       (L-TLB)
Call Trace:    [<c01185eb>] [<c0105568>]                               
ksoftirqd_CPU S C008C000     0     3      1             4     2 (L-TLB)
Call Trace:    [<c0112be6>] [<c0105568>]                               
kswapd        S C008BF98     0     4      1             5     3 (L-TLB)
Call Trace:    [<c01147be>] [<c0114730>] [<c0123ec0>] [<c0123cbb>] [<c010555f>]
  [<c0105568>]                                                                 
bdflush       S 00000286     0     5      1             6     4 (L-TLB)
Call Trace:    [<c010dc1a>] [<c012d99c>] [<c0105568>]                  
kupdated      S C0087FCC     0     6      1                   5 (L-TLB)
Call Trace:    [<c01147be>] [<c0114730>] [<c012da14>] [<c0105568>]     
-- 
Bruce J.A. Nourish <kode187@kode187.net>
Outgoing mail is certified Windows(R) free 
