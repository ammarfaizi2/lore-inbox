Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264542AbTLQUcS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 15:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264545AbTLQUcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 15:32:18 -0500
Received: from cytosin.uni-konstanz.de ([134.34.240.61]:33153 "EHLO
	cytosin.uni-konstanz.de") by vger.kernel.org with ESMTP
	id S264542AbTLQUcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 15:32:04 -0500
From: max@vortex.physik.uni-konstanz.de
Organization: Universitaet Konstanz/Germany
To: linux-kernel@vger.kernel.org
Subject: 2.4.23 usb(-storage?) Oops
Date: Wed, 17 Dec 2003 21:31:46 +0100
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312172131.46872.max@vortex.physik.uni-konstanz.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

I don't know who to send this to, so I sent this to the list.

I get a reproducible Oops when I write a lot of stuff to an usb-storage 
supported flashmemory-stick-mp3-player-thingy (Yakumo Hypersound 124). The 
stick is mounted as vfat filesystem with 16bit FAT.

First the ksymoops decoded Oops message (2.4.23p3 is a vanilla 2.4.23 kernel, 
which I tagged in extraversion as PIII configuration) more stuff following 
below:

########

#> ./ksymoops -v /boot/vmlinux-2.4.23p3 -m /boot/System.map-2.4.23p3 < 
usboops.txt

ksymoops 2.4.9 on i686 2.4.23p3.  Options used
     -v /boot/vmlinux-2.4.23p3 (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.23p3/ (default)
     -m /boot/System.map-2.4.23p3 (specified)

Dec 17 20:57:01 oberon kernel: Oops: 0000
Dec 17 20:57:01 oberon kernel: CPU:    0
Dec 17 20:57:01 oberon kernel: EIP:    0010:[usb_connect+47/352]    Not 
tainted
Dec 17 20:57:01 oberon kernel: EIP:    0010:[<c024f2ff>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Dec 17 20:57:01 oberon kernel: EFLAGS: 00210202
Dec 17 20:57:01 oberon kernel: eax: ee0a6e00   ebx: ee0a6e00   ecx: 00000035   
edx: 01800002
Dec 17 20:57:01 oberon kernel: esi: 00000000   edi: 00000000   ebp: 0180000e   
esp: efdf9f50
Dec 17 20:57:01 oberon kernel: ds: 0018   es: 0018   ss: 0018
Dec 17 20:57:01 oberon kernel: Process khubd (pid: 8, stackpage=efdf9000)
Dec 17 20:57:01 oberon kernel: Stack: 00000014 01800002 ee0a6e00 eebd9c00 
00000000 000000c8 c025250d ee0a6e00
Dec 17 20:57:01 oberon kernel:        00000000 ee0a6e00 000000c8 c02f4fa5 
00000001 00000001 c18b21a0 00000001
Dec 17 20:57:01 oberon kernel:        00000000 c18b21a0 eebd9c00 c02527b4 
c18b21a0 00000000 00000103 00000001
Dec 17 20:57:01 oberon kernel: Call Trace:    
[usb_hub_port_connect_change+317/752] [usb_hub_events+244/912]
Dec 17 20:57:01 oberon kernel: Call Trace:    [<c025250d>] [<c02527b4>] 
[<c0252a8c>] [<c0105000>] [<c01074de>]
Dec 17 20:57:01 oberon kernel:   [<c0252a50>]
Dec 17 20:57:01 oberon kernel: Code: 8b 4a 08 89 c8 89 0c 24 c1 f8 05 83 e1 1f 
8d 7c 85 00 74 28


>>EIP; c024f2ff <usb_connect+2f/160>   <=====

>>eax; ee0a6e00 <_end+2dd049c0/30627c20>
>>ebx; ee0a6e00 <_end+2dd049c0/30627c20>
>>esp; efdf9f50 <_end+2fa57b10/30627c20>

Trace; c025250d <usb_hub_port_connect_change+13d/2f0>
Trace; c02527b4 <usb_hub_events+f4/390>
Trace; c0252a8c <usb_hub_thread+3c/d0>
Trace; c0105000 <_stext+0/0>
Trace; c01074de <arch_kernel_thread+2e/40>
Trace; c0252a50 <usb_hub_thread+0/d0>

Code;  c024f2ff <usb_connect+2f/160>
00000000 <_EIP>:
Code;  c024f2ff <usb_connect+2f/160>   <=====
   0:   8b 4a 08                  mov    0x8(%edx),%ecx   <=====
Code;  c024f302 <usb_connect+32/160>
   3:   89 c8                     mov    %ecx,%eax
Code;  c024f304 <usb_connect+34/160>
   5:   89 0c 24                  mov    %ecx,(%esp,1)
Code;  c024f307 <usb_connect+37/160>
   8:   c1 f8 05                  sar    $0x5,%eax
Code;  c024f30a <usb_connect+3a/160>
   b:   83 e1 1f                  and    $0x1f,%ecx
Code;  c024f30d <usb_connect+3d/160>
   e:   8d 7c 85 00               lea    0x0(%ebp,%eax,4),%edi
Code;  c024f311 <usb_connect+41/160>
  12:   74 28                     je     3c <_EIP+0x3c>

########

Before the oops happened the usb-storage modul said a lot of stuff (I have 
debugging compiled in to debug this)

Dec 17 20:56:15 oberon kernel: usb-storage: usb_stor_transfer_partial(): xfer 
3072 bytes
Dec 17 20:56:15 oberon kernel: usb-storage: usb_stor_bulk_msg() returned 0 
xferred 3072/3072
Dec 17 20:56:15 oberon kernel: usb-storage: usb_stor_transfer_partial(): 
transfer complete
Dec 17 20:56:15 oberon kernel: usb-storage: Bulk data transfer result 0x0
Dec 17 20:56:15 oberon kernel: usb-storage: Attempting to get CSW...
Dec 17 20:56:15 oberon kernel: usb-storage: Bulk status result = 0
Dec 17 20:56:15 oberon kernel: usb-storage: Bulk status Sig 0x53425355 T 0x25d 
R 0 Stat 0x0
Dec 17 20:56:15 oberon kernel: usb-storage: scsi cmd done, result=0x0
Dec 17 20:56:15 oberon kernel: usb-storage: *** thread sleeping.
Dec 17 20:56:15 oberon kernel: usb-storage: queuecommand() called
Dec 17 20:56:15 oberon kernel: usb-storage: *** thread awakened.
Dec 17 20:56:15 oberon kernel: usb-storage: Command WRITE_10 (10 bytes)
Dec 17 20:56:15 oberon kernel: usb-storage: 2a 00 00 01 e5 12 00 00 ff 00 00 
00
Dec 17 20:56:15 oberon kernel: usb-storage: Bulk command S 0x43425355 T 0x25e 
Trg 0 LUN 0 L 130560 F 0 CL 10
Dec 17 20:56:15 oberon kernel: usb-storage: Bulk command transfer result=0
Dec 17 20:56:15 oberon kernel: usb-storage: usb_stor_transfer_partial(): xfer 
1024 bytes
Dec 17 20:56:15 oberon kernel: usb-storage: usb_stor_bulk_msg() returned 0 
xferred 1024/1024
Dec 17 20:56:15 oberon kernel: usb-storage: usb_stor_transfer_partial(): 
transfer complete
Dec 17 20:56:15 oberon kernel: usb-storage: usb_stor_transfer_partial(): xfer 
4096 bytes
Dec 17 20:56:45 oberon kernel: usb-storage: command_abort() called
Dec 17 20:56:45 oberon kernel: usb-storage: usb_stor_bulk_msg() returned -104 
xferred 960/4096
Dec 17 20:56:45 oberon kernel: usb-storage: usb_stor_transfer_partial(): 
transfer aborted
Dec 17 20:56:45 oberon kernel: usb-storage: Bulk data transfer result 0x3
Dec 17 20:56:45 oberon kernel: usb-storage: -- transport indicates command was 
aborted
Dec 17 20:56:45 oberon kernel: usb-storage: Bulk reset requested
Dec 17 20:56:50 oberon kernel: usb_control/bulk_msg: timeout
Dec 17 20:56:50 oberon kernel: usb-storage: Bulk soft reset failed -110
Dec 17 20:56:50 oberon kernel: usb-storage: scsi command aborted
Dec 17 20:56:50 oberon kernel: usb-storage: *** thread sleeping.
Dec 17 20:56:50 oberon kernel: usb-storage: queuecommand() called
Dec 17 20:56:50 oberon kernel: usb-storage: *** thread awakened.
Dec 17 20:56:50 oberon kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Dec 17 20:56:50 oberon kernel: usb-storage: 00 00 00 00 00 00 00 00 ff 00 00 
00
Dec 17 20:56:50 oberon kernel: usb-storage: Bulk command S 0x43425355 T 0x25f 
Trg 0 LUN 0 L 0 F 0 CL 6
Dec 17 20:56:50 oberon kernel: usb-storage: Bulk command transfer result=0
Dec 17 20:56:50 oberon kernel: usb-storage: Attempting to get CSW...
Dec 17 20:57:00 oberon kernel: usb-storage: command_abort() called
Dec 17 20:57:00 oberon kernel: usb-storage: -- transport indicates command was 
aborted
Dec 17 20:57:00 oberon kernel: usb-storage: Bulk reset requested
Dec 17 20:57:00 oberon kernel: usb-uhci.c: interrupt, status 2, frame# 1636
Dec 17 20:57:00 oberon kernel: usb-storage: Bulk soft reset failed -110
Dec 17 20:57:00 oberon kernel: usb-storage: scsi command aborted
Dec 17 20:57:00 oberon kernel: usb-storage: *** thread sleeping.
Dec 17 20:57:00 oberon kernel: usb-storage: device_reset() called
Dec 17 20:57:00 oberon kernel: usb-storage: Bulk reset requested
Dec 17 20:57:00 oberon kernel: usb-storage: Bulk soft reset failed -110
Dec 17 20:57:00 oberon kernel: usb-storage: bus_reset() called
Dec 17 20:57:00 oberon kernel: hub.c: port 1, portstatus 110, change 2, 12 
Mb/s
Dec 17 20:57:00 oberon kernel: hub.c: port 1 enable change, status 110
Dec 17 20:57:00 oberon kernel: hub.c: port 2, portstatus 103, change 0, 12 
Mb/s
Dec 17 20:57:00 oberon kernel: hub.c: port 1, portstatus 103, change 1, 12 
Mb/s
Dec 17 20:57:00 oberon kernel: hub.c: port 1 connection change
Dec 17 20:57:00 oberon kernel: hub.c: port 1, portstatus 103, change 1, 12 
Mb/s
Dec 17 20:57:00 oberon kernel: usb.c: USB disconnect on device 00:04.2-1 
address 3
Dec 17 20:57:00 oberon kernel: usb-storage: storage_disconnect() called
Dec 17 20:57:00 oberon kernel: usb-storage: -- releasing main URB
Dec 17 20:57:00 oberon kernel: usb-storage: -- usb_unlink_urb() returned -19
Dec 17 20:57:00 oberon kernel: usb.c: kusbd: /sbin/hotplug remove 3
Dec 17 20:57:00 oberon kernel: hub.c: port 1, portstatus 103, change 0, 12 
Mb/s
Dec 17 20:57:00 oberon kernel: hub.c: USB device not accepting new address 
(error=-110)
Dec 17 20:57:00 oberon kernel: hub.c: port 1, portstatus 101, change 0, 12 
Mb/s
Dec 17 20:57:00 oberon last message repeated 3 times
Dec 17 20:57:00 oberon kernel: hub.c: port 1, portstatus 103, change 0, 12 
Mb/s
Dec 17 20:57:00 oberon kernel: hub.c: new USB device 00:04.2-1, assigned 
address 4
Dec 17 20:57:00 oberon kernel: usb.c: USB device not accepting new address=4 
(error=-110)
Dec 17 20:57:01 oberon kernel: hub.c: port 1, portstatus 103, change 0, 12 
Mb/s
Dec 17 20:57:01 oberon kernel: Unable to handle kernel paging request at 
virtual address 0180000a
Dec 17 20:57:01 oberon kernel:  printing eip:
Dec 17 20:57:01 oberon kernel: c024f2ff
Dec 17 20:57:01 oberon kernel: *pde = 00000000
Dec 17 20:57:01 oberon kernel: Oops: 0000
Dec 17 20:57:01 oberon kernel: CPU:    0
Dec 17 20:57:01 oberon kernel: EIP:    0010:[usb_connect+47/352]    Not 
tainted
Dec 17 20:57:01 oberon kernel: EIP:    0010:[<c024f2ff>]    Not tainted
Dec 17 20:57:01 oberon kernel: EFLAGS: 00210202
Dec 17 20:57:01 oberon kernel: eax: ee0a6e00   ebx: ee0a6e00   ecx: 00000035   
edx: 01800002
Dec 17 20:57:01 oberon kernel: esi: 00000000   edi: 00000000   ebp: 0180000e   
esp: efdf9f50
Dec 17 20:57:01 oberon kernel: ds: 0018   es: 0018   ss: 0018
Dec 17 20:57:01 oberon kernel: Process khubd (pid: 8, stackpage=efdf9000)
Dec 17 20:57:01 oberon kernel: Stack: 00000014 01800002 ee0a6e00 eebd9c00 
00000000 000000c8 c025250d ee0a6e00
Dec 17 20:57:01 oberon kernel:        00000000 ee0a6e00 000000c8 c02f4fa5 
00000001 00000001 c18b21a0 00000001
Dec 17 20:57:01 oberon kernel:        00000000 c18b21a0 eebd9c00 c02527b4 
c18b21a0 00000000 00000103 00000001
Dec 17 20:57:01 oberon kernel: Call Trace:    
[usb_hub_port_connect_change+317/752] [usb_hub_events+244/912] [usb_hub
_thread+60/208] [_stext+0/64] [arch_kernel_thread+46/64]
Dec 17 20:57:01 oberon kernel: Call Trace:    [<c025250d>] [<c02527b4>] 
[<c0252a8c>] [<c0105000>] [<c01074de>]
Dec 17 20:57:01 oberon kernel:   [usb_hub_thread+0/208]
Dec 17 20:57:01 oberon kernel:   [<c0252a50>]
Dec 17 20:57:01 oberon kernel:
Dec 17 20:57:01 oberon kernel: Code: 8b 4a 08 89 c8 89 0c 24 c1 f8 05 83 e1 1f 
8d 7c 85 00 74 28
Dec 17 20:57:05 oberon kernel:  <2>usb-storage: host_reset() requested but not 
implemented
Dec 17 20:57:15 oberon kernel: scsi: device set offline - command error 
recover failed: host 2 channel 0 id 0 lun 0
Dec 17 20:57:15 oberon kernel: SCSI disk error : host 2 channel 0 id 0 lun 0 
return code = 6050000
Dec 17 20:57:15 oberon kernel:  I/O error: dev 08:11, sector 124143
Dec 17 20:57:15 oberon kernel:  I/O error: dev 08:11, sector 124144
Dec 17 20:57:15 oberon kernel:  I/O error: dev 08:11, sector 124398
Dec 17 20:57:15 oberon kernel:  I/O error: dev 08:11, sector 124653
Dec 17 20:57:15 oberon kernel:  I/O error: dev 08:11, sector 124908
Dec 17 20:57:15 oberon kernel:  I/O error: dev 08:11, sector 360
Dec 17 20:57:15 oberon kernel:  I/O error: dev 08:11, sector 124913
Dec 17 20:57:15 oberon kernel:  I/O error: dev 08:11, sector 125168
Dec 17 20:57:15 oberon kernel:  I/O error: dev 08:11, sector 125423
Dec 17 20:57:15 oberon kernel:  I/O error: dev 08:11, sector 125678
Dec 17 20:57:15 oberon kernel:  I/O error: dev 08:11, sector 125933
Dec 17 20:57:15 oberon kernel:  I/O error: dev 08:11, sector 123
Dec 17 20:57:15 oberon kernel:  I/O error: dev 08:11, sector 125935
Dec 17 20:57:15 oberon kernel:  I/O error: dev 08:11, sector 126190
Dec 17 20:57:15 oberon kernel:  I/O error: dev 08:11, sector 126445
Dec 17 20:57:15 oberon kernel:  I/O error: dev 08:11, sector 126700
Dec 17 20:57:15 oberon kernel:  I/O error: dev 08:11, sector 126955
Dec 17 20:57:15 oberon kernel:  I/O error: dev 08:11, sector 362
Dec 17 20:57:15 oberon kernel:  I/O error: dev 08:11, sector 126961
Dec 17 20:57:15 oberon kernel:  I/O error: dev 08:11, sector 127216
Dec 17 20:57:15 oberon kernel:  I/O error: dev 08:11, sector 127471
Dec 17 20:57:15 oberon kernel:  I/O error: dev 08:11, sector 127726
Dec 17 20:57:15 oberon kernel:  I/O error: dev 08:11, sector 127981
Dec 17 20:57:15 oberon kernel:  I/O error: dev 08:11, sector 125
Dec 17 20:57:15 oberon kernel:  I/O error: dev 08:11, sector 127987


and so on. After this there are more oopses usually. In different programs and 
most of the time the system crashes and burns and I have to do an Alt-Sysrq- 
sync,umount,reboot.

If there is anything else I can do to help track this down, please let me 
know. Note that I am not subscribed to the lkml mailing list.

Happy Christmas everybody,
Max

