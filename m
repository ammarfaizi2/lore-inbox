Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266809AbTA2TaB>; Wed, 29 Jan 2003 14:30:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266810AbTA2TaB>; Wed, 29 Jan 2003 14:30:01 -0500
Received: from dc-mx05.cluster1.charter.net ([209.225.8.15]:9388 "EHLO
	mx05.cluster1.charter.net") by vger.kernel.org with ESMTP
	id <S266809AbTA2T3z>; Wed, 29 Jan 2003 14:29:55 -0500
Message-ID: <3E382F08.7090400@charter.net>
Date: Wed, 29 Jan 2003 13:44:08 -0600
From: Howard Shane <ozymandias@charter.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: ozymandias@charter.net
Subject: kernel craps out accessing Sony CDRW with ide-scsi
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am having problems using kernel 2.4.20 with built-in scsi-emulation 
and a newly installed Sony CDRW drive. I've seen posts on ide-scsi on 
the list in the past, but nothing this specific, so I am forwarding this 
info to the list for anyone interested. The kernel recognizes the drive 
fine and 'cdrecord -scanbus' yields the following info:

scsibus0:
        0,0,0     0) 'SONY    ' 'CD-RW  CRX185E1 ' 'XYS2' Removable CD-ROM
        0,1,0     1) 'TOSHIBA ' 'DVD-ROM SD-R1002' '1034' Removable CD-ROM
        0,2,0     2) *

...etc. This kernel has worked fine with the toshiba CDRW drive, but 
since installing and using the Sony on four separate occasions I have 
had lockups requiring a hard reset, once when ripping an audio CD, once 
when using gnome2's cdplayer and the other two using 'eject /dev/sr0' at 
the command line. At other times it works just fine. This or something 
similar is found in the kernel log of the events:

=================================================================

Jan 27 12:32:13 iii kernel: scsi : aborting command due to timeout : pid 
202550, scsi0, channel 0, id 0, lun 0 0x25 00 00 00 00 00 00 00 00 00
Jan 27 12:32:13 iii kernel: hdc: irq timeout: status=0xd0 { Busy }
Jan 27 12:32:13 iii kernel: hdc: DMA disabled
Jan 27 12:32:13 iii kernel: hdc: ATAPI reset complete
Jan 27 12:32:13 iii kernel: hdc: irq timeout: status=0xc0 { Busy }
Jan 27 12:32:13 iii kernel: hdc: ATAPI reset complete
Jan 27 12:32:15 iii kernel: hdc: irq timeout: status=0xc0 { Busy }
Jan 27 12:32:15 iii kernel: scsi0 channel 0 : resetting for second half 
of retries.
Jan 27 12:32:15 iii kernel: SCSI bus is being reset for host 0 channel 0.
Jan 27 12:32:15 iii kernel: hdc: status timeout: status=0xc0 { Busy }
Jan 27 12:32:15 iii kernel: hdc: drive not ready for command
Jan 27 12:32:15 iii kernel: hdc: ATAPI reset complete
Jan 27 12:32:45 iii kernel: scsi : aborting command due to timeout : pid 
202551, scsi0, channel 0, id 0, lun 0 0x25 00 00 00 00 00 00 00 00 00
Jan 27 12:32:45 iii kernel: SCSI host 0 abort (pid 202551) timed out - 
resetting
Jan 27 12:32:45 iii kernel: SCSI bus is being reset for host 0 channel 0.
Jan 27 12:32:45 iii kernel: hdc: irq timeout: status=0xc0 { Busy }
Jan 27 12:32:45 iii kernel: hdc: ATAPI reset complete
Jan 27 12:32:47 iii kernel: hdc: irq timeout: status=0xc0 { Busy }
Jan 27 12:32:47 iii kernel: hdc: status timeout: status=0xc0 { Busy }
Jan 27 12:32:47 iii kernel: hdc: drive not ready for command

==============this repeats until the following pid==========
Jan 27 12:53:01 iii kernel: scsi : aborting command due to timeout : pid 
202654, scsi0, channel 0, id 0, lun 0 0x1e 00 00 00 01 00
Jan 27 12:53:01 iii kernel: SCSI host 0 abort (pid 202654) timed out - 
resetting
Jan 27 12:53:01 iii kernel: SCSI bus is being reset for host 0 channel 0.
Jan 27 12:53:02 iii kernel: hdc: irq timeout: status=0xc0 { Busy }
Jan 27 12:53:02 iii kernel: hdc: ATAPI reset complete
Jan 27 12:53:03 iii kernel: hdc: irq timeout: status=0xc0 { Busy }
Jan 27 12:53:03 iii kernel: hdc: status timeout: status=0xc0 { Busy }
Jan 27 12:53:03 iii kernel: hdc: drive not ready for command
Jan 27 12:53:04 iii kernel: hdc: ATAPI reset complete
Jan 27 12:53:10 iii kernel: Unable to handle kernel paging request at 
virtual address 0c758b10
Jan 27 12:53:10 iii kernel:  printing eip:
Jan 27 12:53:10 iii kernel: c014beb4
Jan 27 12:53:10 iii kernel: *pde = 00000000
Jan 27 12:53:10 iii kernel: Oops: 0000
Jan 27 12:53:10 iii kernel: CPU:    0
Jan 27 12:53:10 iii kernel: EIP:    0010:[proc_check_root+132/272] 
Tainted: P
Jan 27 12:53:10 iii kernel: EFLAGS: 00210207
Jan 27 12:53:10 iii kernel: eax: 0c758b08   ebx: c158d3c0   ecx: 
d9940000   edx: 0c758b08
Jan 27 12:53:10 iii kernel: esi: c1588b40   edi: d9940000   ebp: 
c158d3c0   esp: c6465efc
Jan 27 12:53:10 iii kernel: ds: 0018   es: 0018   ss: 0018
Jan 27 12:53:10 iii kernel: Process ps (pid: 17219, stackpage=c6465000)
Jan 27 12:53:10 iii kernel: Stack: cbb102c0 ffffffec c6465fa4 cbb102c0 
00000000 c15eac00 0c758b08 c014bf5d
Jan 27 12:53:10 iii kernel:        cbb102c0 c7599f40 c013989f cbb102c0 
00000001 c013a388 cbb102c0 00000001
Jan 27 12:53:10 iii kernel:        c6465fa4 caf3b000 00000000 00000008 
bffff710 00000008 caf3b00f c7599f40
Jan 27 12:53:10 iii kernel: Call Trace:    [proc_permission+29/48] 
[permission+31/48] [link_path_walk+2104/2144] [path_walk+26/32] 
[path_lookup+27/48]
Jan 27 12:53:10 iii kernel:   [__user_walk+38/64] [sys_readlink+48/160] 
[sys_close+67/96] [system_call+51/56]
Jan 27 12:53:10 iii kernel:
Jan 27 12:53:10 iii kernel: Code: 8b 50 08 39 d0 74 65 8b 40 0c 89 54 24 
18 39 da 75 ea 56 50
Jan 27 12:53:13 iii kernel:  scsi : aborting command due to timeout : 
pid 202655, scsi0, channel 0, id 0, lun 0 0x1e 00 00 00 01 00
Jan 27 12:53:13 iii kernel: SCSI host 0 abort (pid 202655) timed out - 
resetting
Jan 27 12:53:13 iii kernel: SCSI bus is being reset for host 0 channel 0.
Jan 27 12:53:14 iii kernel: hdc: irq timeout: status=0xc0 { Busy }
Jan 27 12:53:14 iii kernel: hdc: ATAPI reset complete
Jan 27 12:53:14 iii kernel: hdc: ATAPI reset complete
Jan 27 12:53:15 iii kernel: hdc: irq timeout: status=0xc0 { Busy }
Jan 27 12:53:15 iii kernel: hdc: status timeout: status=0xc0 { Busy }
Jan 27 12:53:15 iii kernel: hdc: drive not ready for command
Jan 27 12:53:16 iii kernel: hdc: ATAPI reset complete
Jan 27 12:53:19 iii kernel: Unable to handle kernel paging request at 
virtual address 0c758b10
Jan 27 12:53:19 iii kernel:  printing eip:
Jan 27 12:53:19 iii kernel: c014beb4
Jan 27 12:53:19 iii kernel: *pde = 00000000
Jan 27 12:53:19 iii kernel: Oops: 0000
Jan 27 12:53:19 iii kernel: CPU:    0
Jan 27 12:53:19 iii kernel: EIP:    0010:[proc_check_root+132/272] 
Tainted: P
Jan 27 12:53:19 iii kernel: EFLAGS: 00210207
Jan 27 12:53:19 iii kernel: eax: 0c758b08   ebx: c158d3c0   ecx: 
d9940000   edx: 0c758b08
Jan 27 12:53:19 iii kernel: esi: c1588b40   edi: d9940000   ebp: 
c158d3c0   esp: cd86defc
Jan 27 12:53:19 iii kernel: ds: 0018   es: 0018   ss: 0018
Jan 27 12:53:19 iii kernel: Process ps (pid: 17220, stackpage=cd86d000)
Jan 27 12:53:19 iii kernel: Stack: cbb102c0 ffffffec cd86dfa4 cbb102c0 
00000000 c15eac00 0c758b08 c014bf5d
Jan 27 12:53:19 iii kernel:        cbb102c0 c7599f40 c013989f cbb102c0 
00000001 c013a388 cbb102c0 00000001
Jan 27 12:53:19 iii kernel:        cd86dfa4 cf186000 00000000 00000008 
bffff710 00000008 cf18600f c7599f40
Jan 27 12:53:19 iii kernel: Call Trace:    [proc_permission+29/48] 
[permission+31/48] [link_path_walk+2104/2144] [path_walk+26/32] 
[path_lookup+27/48]
Jan 27 12:53:19 iii kernel:   [__user_walk+38/64] [sys_readlink+48/160] 
[sys_close+67/96] [system_call+51/56]
Jan 27 12:53:19 iii kernel:
Jan 27 12:53:19 iii kernel: Code: 8b 50 08 39 d0 74 65 8b 40 0c 89 54 24 
18 39 da 75 ea 56 50
Jan 27 12:53:25 iii kernel:  scsi : aborting command due to timeout : 
pid 202656, scsi0, channel 0, id 0, lun 0 0x1e 00 00 00 01 00
Jan 27 12:53:25 iii kernel: SCSI host 0 abort (pid 202656) timed out - 
resetting
Jan 27 12:53:25 iii kernel: SCSI bus is being reset for host 0 channel 0.
Jan 27 12:53:26 iii kernel: hdc: irq timeout: status=0xc0 { Busy }
Jan 27 12:53:26 iii kernel: hdc: ATAPI reset complete
Jan 27 12:53:27 iii kernel: hdc: irq timeout: status=0xc0 { Busy }
Jan 27 12:53:27 iii kernel: hdc: status timeout: status=0xc0 { Busy }
Jan 27 12:53:27 iii kernel: hdc: drive not ready for command
Jan 27 12:53:28 iii kernel: hdc: ATAPI reset complete
Jan 27 12:53:37 iii kernel: scsi : aborting command due to timeout : pid 
202657, scsi0, channel 0, id 0, lun 0 0x1e 00 00 00 01 00
Jan 27 12:53:37 iii kernel: SCSI host 0 abort (pid 202657) timed out - 
resetting
Jan 27 12:53:37 iii kernel: SCSI bus is being reset for host 0 channel 0.
Jan 27 12:53:38 iii kernel: hdc: irq timeout: status=0xc0 { Busy }
Jan 27 12:53:38 iii kernel: hdc: ATAPI reset complete
Jan 27 12:53:38 iii kernel: hdc: irq timeout: status=0xc0 { Busy }
Jan 27 12:53:39 iii kernel: hdc: status timeout: status=0xc0 { Busy }
Jan 27 12:53:39 iii kernel: hdc: drive not ready for command
Jan 27 12:53:40 iii kernel: hdc: ATAPI reset complete
Jan 27 12:53:46 iii kernel: Unable to handle kernel paging request at 
virtual address 00020001
Jan 27 12:53:46 iii kernel:  printing eip:
Jan 27 12:53:46 iii kernel: c014bcba
Jan 27 12:53:46 iii kernel: *pde = 00000000
Jan 27 12:53:46 iii kernel: Oops: 0002
Jan 27 12:53:46 iii kernel: CPU:    0
Jan 27 12:53:46 iii kernel: EIP:    0010:[proc_root_link+26/96] Tainted: P
Jan 27 12:53:46 iii kernel: EFLAGS: 00210202
Jan 27 12:53:46 iii kernel: eax: d430e000   ebx: fffffffe   ecx: 
00020001   edx: d2901f10
Jan 27 12:53:46 iii kernel: esi: ffffffec   edi: d2901fa4   ebp: 
cbb102c0   esp: d2901ee8
Jan 27 12:53:46 iii kernel: ds: 0018   es: 0018   ss: 0018
Jan 27 12:53:46 iii kernel: Process ps (pid: 17221, stackpage=d2901000)
Jan 27 12:53:46 iii kernel: Stack: cbb102c0 c014be53 cbb102c0 d2901f10 
d2901f14 cbb102c0 ffffffec d2901fa4
Jan 27 12:53:46 iii kernel:        cbb102c0 00000000 d2901fa4 c014bf50 
c014bf5d cbb102c0 c7599f40 c013989f
Jan 27 12:53:46 iii kernel:        cbb102c0 00000001 c013a388 cbb102c0 
00000001 d2901fa4 d50f0000 00000000
Jan 27 12:53:46 iii kernel: Call Trace:    [proc_check_root+35/272] 
[proc_permission+16/48] [proc_permission+29/48] [permission+31/48] 
[link_path_walk+2104/2144]
Jan 27 12:53:46 iii kernel:   [path_walk+26/32] [path_lookup+27/48] 
[__user_walk+38/64] [sys_readlink+48/160] [sys_close+67/96] 
[system_call+51/56]
Jan 27 12:53:46 iii kernel:
Jan 27 12:53:46 iii kernel: Code: ff 01 8b 51 14 85 d2 74 03 ff 42 28 8b 
44 24 10 89 10 8b 51
Jan 27 12:53:49 iii kernel:  scsi : aborting command due to timeout : 
pid 202658, scsi0, channel 0, id 0, lun 0 0x1e 00 00 00 01 00
Jan 27 12:53:50 iii kernel: hdc: irq timeout: status=0xc0 { Busy }
Jan 27 12:53:50 iii kernel: hdc: ATAPI reset complete
Jan 27 12:53:50 iii kernel: hdc: irq timeout: status=0xc0 { Busy }
Jan 27 12:53:50 iii kernel: hdc: status timeout: status=0xc0 { Busy }
Jan 27 12:53:50 iii kernel: hdc: drive not ready for command
Jan 27 12:53:50 iii kernel: hdc: ATAPI reset complete
Jan 27 12:53:56 iii kernel: Unable to handle kernel paging request at 
virtual address 00020001
Jan 27 12:53:56 iii kernel:  printing eip:
Jan 27 12:53:56 iii kernel: c014bcba
Jan 27 12:53:56 iii kernel: *pde = 00000000
Jan 27 12:53:56 iii kernel: Oops: 0002
Jan 27 12:53:56 iii kernel: CPU:    0
Jan 27 12:53:56 iii kernel: EIP:    0010:[proc_root_link+26/96] Tainted: P
Jan 27 12:53:56 iii kernel: EFLAGS: 00210202
Jan 27 12:53:56 iii kernel: eax: d430e000   ebx: fffffffe   ecx: 
00020001   edx: d2901f10
Jan 27 12:53:56 iii kernel: esi: ffffffec   edi: d2901fa4   ebp: 
cbb102c0   esp: d2901ee8
Jan 27 12:53:56 iii kernel: ds: 0018   es: 0018   ss: 0018
Jan 27 12:53:56 iii kernel: Process ps (pid: 17223, stackpage=d2901000)
Jan 27 12:53:56 iii kernel: Stack: cbb102c0 c014be53 cbb102c0 d2901f10 
d2901f14 cbb102c0 ffffffec d2901fa4
Jan 27 12:53:56 iii kernel:        cbb102c0 00000000 d2901fa4 c014bf50 
c014bf5d cbb102c0 c7599f40 c013989f
Jan 27 12:53:56 iii kernel:        cbb102c0 00000001 c013a388 cbb102c0 
00000001 d2901fa4 d7969000 00000000
Jan 27 12:53:56 iii kernel: Call Trace:    [proc_check_root+35/272] 
[proc_permission+16/48] [proc_permission+29/48] [permission+31/48] 
[link_path_walk+2104/2144]
Jan 27 12:53:56 iii kernel:   [path_walk+26/32] [path_lookup+27/48] 
[__user_walk+38/64] [sys_readlink+48/160] [sys_close+67/96] 
[system_call+51/56]
Jan 27 12:53:56 iii kernel:
Jan 27 12:53:56 iii kernel: Code: ff 01 8b 51 14 85 d2 74 03 ff 42 28 8b 
44 24 10 89 10 8b 51
Jan 27 12:54:00 iii kernel:  scsi : aborting command due to timeout : 
pid 202659, scsi0, channel 0, id 0, lun 0 0x1e 00 00 00 01 00
Jan 27 12:54:00 iii kernel: SCSI host 0 abort (pid 202659) timed out - 
resetting
Jan 27 12:54:00 iii kernel: SCSI bus is being reset for host 0 channel 0.
Jan 27 12:54:00 iii kernel: hdc: irq timeout: status=0xc0 { Busy }
Jan 27 12:54:00 iii kernel: hdc: ATAPI reset complete
Jan 27 12:54:02 iii kernel: hdc: irq timeout: status=0xc0 { Busy }
Jan 27 12:54:02 iii kernel: hdc: status timeout: status=0xc0 { Busy }
Jan 27 12:54:02 iii kernel: hdc: drive not ready for command
Jan 27 12:54:02 iii kernel: hdc: ATAPI reset complete
Jan 27 12:54:12 iii kernel: scsi : aborting command due to timeout : pid 
202660, scsi0, channel 0, id 0, lun 0 0x1e 00 00 00 01 00
Jan 27 12:54:12 iii kernel: SCSI host 0 abort (pid 202660) timed out - 
resetting

======================================================================

At which point everything freezes, the keyboard LEDs flash and no 
combination of three fingered salutes revives the system.

THis is my first post to the list so I apologize if any of this is 
superfluous.


