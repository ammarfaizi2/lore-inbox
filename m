Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135922AbRAJWJx>; Wed, 10 Jan 2001 17:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136107AbRAJWJn>; Wed, 10 Jan 2001 17:09:43 -0500
Received: from pD9053213.dip.t-dialin.net ([217.5.50.19]:22793 "EHLO
	feynman.home.wytech.de") by vger.kernel.org with ESMTP
	id <S135922AbRAJWJ1>; Wed, 10 Jan 2001 17:09:27 -0500
Date: Wed, 10 Jan 2001 23:09:16 +0100 (CET)
From: Matthias Rosenkranz <rose@wytech.de>
To: <linux-kernel@vger.kernel.org>, <andre@linux-ide.org>
Subject: Oops in 2.4.0 with hdX=cdrom
Message-ID: <Pine.LNX.4.30.0101102202500.317-100000@klitzing.home.wytech.de>
Organization: wytech IT Solutions (http://wytech.de/)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I got the following Oops with a stock 2.4.0 kernel when specifying
'hdd=cdrom' as lilos commandline. hdd is a Pioneer DR-A24X and
ATA probing confuses it without 'hdd=noprobe hdd=cdrom'. I've also tested
with 'hdc=cdrom' (which is a LG CRD-8482B) and it oopsed, too. Without the
option the system boots, but I encounter the usual 'hdd: lost interrupt'.

System:
	- Asus TX97XE (PIIX4 controller)
	- AMD K6 233
	- hdc is LG CRD-8482B
	- hdd is Pioneer DR-A24X

ver_linux output:
  Linux glashow 2.4.0 #2 Wed Jan 10 20:13:16 CET 2001 i586 unknown
  Kernel modules         2.4.1
  Gnu C                  2.95.3
  Gnu Make               3.79.1
  Binutils               2.10.1.0.2
  Linux C Library        > libc.2.2
  Dynamic linker         ldd (GNU libc) 2.2
  Procps                 2.0.6
  Mount                  2.10q
  Net-tools              2.05
  Console-tools          0.2.3
  Sh-utils               2.0.11
  Modules Loaded         ne 8390


If you need any further information please let me know.

Thanks for your help
	Matthias


$ ksymoops -m /boot/System.map /home/rose/cdrom_oops
ksymoops 2.3.4 on i586 2.4.0.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0/ (default)
     -m /boot/System.map (specified)

Unable to handle kernel NULL pointer dereference at virtual address
00000063
c017c863
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c017c863>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: x026bfe4   ebx: 00000000   ecx: 00000006   edx: 00000004
esi: 00000005   edi: c026bfe4   ebp: c026bfe4   esp: c1119f50
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=c119000)
Stack: c026bfe4 00000286 c0212ee0 c017c8a7 c026bfe4 c017ab4a 00000004
c026bfe4
       00000007 c026bfe4 c1144a00 00000000 c1144940 c0183f73 c026bfe4
c0212ee0
       00000001 c02605e0 000000ff c02601dc 0008e000 c02605e0 000000ff
00000001
Call Trace: [<c017c8a7>] [<c017ab4a>] [<c0183f73>] [<c0107007>]
[<c0107418>]
Code: f6 43 63 08 75 06 f6 43 6a 02 74 0e be 07 00 00 00 57 e8 12

>>EIP; c017c863 <config_drive_xfer_rate+af/e0>   <=====
Trace; c017c8a7 <piix_dmaproc+13/2c>
Trace; c017ab4a <ide_register_subdriver+9a/f4>
Trace; c0183f73 <ide_cdrom_init+bf/1cc>
Trace; c0107007 <init+7/110>
Trace; c0107418 <kernel_thread+28/38>
Code;  c017c863 <config_drive_xfer_rate+af/e0>
00000000 <_EIP>:
Code;  c017c863 <config_drive_xfer_rate+af/e0>   <=====
   0:   f6 43 63 08               testb  $0x8,0x63(%ebx)   <=====
Code;  c017c867 <config_drive_xfer_rate+b3/e0>
   4:   75 06                     jne    c <_EIP+0xc> c017c86f
<config_drive_xfer_rate+bb/e0>
Code;  c017c869 <config_drive_xfer_rate+b5/e0>
   6:   f6 43 6a 02               testb  $0x2,0x6a(%ebx)
Code;  c017c86d <config_drive_xfer_rate+b9/e0>
   a:   74 0e                     je     1a <_EIP+0x1a> c017c87d
<config_drive_xfer_rate+c9/e0>
Code;  c017c86f <config_drive_xfer_rate+bb/e0>
   c:   be 07 00 00 00            mov    $0x7,%esi
Code;  c017c874 <config_drive_xfer_rate+c0/e0>
  11:   57                        push   %edi
Code;  c017c875 <config_drive_xfer_rate+c1/e0>
  12:   e8 12 00 00 00            call   29 <_EIP+0x29> c017c88c
<config_drive_xfer_rate+d8/e0>

Kernel panic: Attempted to kill init!

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
