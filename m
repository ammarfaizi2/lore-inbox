Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130255AbQKXXA5>; Fri, 24 Nov 2000 18:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130436AbQKXXAu>; Fri, 24 Nov 2000 18:00:50 -0500
Received: from db0bm.automation.fh-aachen.de ([193.175.144.197]:45067 "EHLO
        db0bm.ampr.org") by vger.kernel.org with ESMTP id <S130255AbQKXXAn>;
        Fri, 24 Nov 2000 18:00:43 -0500
Date: Fri, 24 Nov 2000 23:30:40 +0100
From: f5ibh <f5ibh@db0bm.ampr.org>
Message-Id: <200011242230.XAA12457@db0bm.ampr.org>
To: linux-kernel@vger.kernel.org
Subject: 2.2.18pre23 Oops
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was running a packet radio (hamradio) program whose name is tnt.
(We can see it is the oops and he disapeared during the oops).
The OOps occured as I was loading the modules for a ppa ZIP parallel port ZIP
drive.

This is the raw Oos without processing it with ksymoops :
*********************************************************

ppa: Version 2.05 (for Linux 2.2.x)
ppa: Found device at ID 6, Attempting to use EPP 32 bit
ppa: Communication established with ID 6 using EPP 32 bit
Warning: kfree_skb passed an skb still on a list (from c4868fc1).

------------

Oops: 0002
CPU:    0
EIP:    0010:[skb_recv_datagram+359/416]
EFLAGS: 00010047
eax: c2d868e0   ebx: 00000000   ecx: 00000246   edx: 00000000
esi: 000005dc   edi: c3203e84   ebp: c36d7a04   esp: c3203dcc
ds: 0018   es: 0018   ss: 0018
Process tnt (pid: 316, process nr: 28, stackpage=c3203000)
Stack: c3203e84 c3203f48 c3ffe040 c3203df0 00000000 00000000 00000000 c019de40
        20000000 c4876b5b c36d79c0 00000000 00000000 c3203e20 c302ed48 000005dc
        c3203e84 c3203f48 00000000 c019de40 c36d79c0 35323431 63333731 c3247e40
Call Trace: [twist_table.690+3744/4256] [<c4876b5b>] [twist_table.690+3744/4256] [sock_recvmsg+65/184] [tcp_listen_poll+56/80] [sys_recvfrom+168/260] [free_pages+39/44]
[free_wait+101/116] [do_select+487/512] [do_select+440/512] [sys_select+993/1176] [sys_socketcall+410/540] [common_interrupt+24/32] [error_code+45/52] [system_call+52/56]
Code: 89 6a 04 89 55 00 c7 00 00 00 00 00 c7 40 04 00 00 00 00 c7

----------------

scsi0 : Iomega VPI0 (ppa) interface
scsi : 1 host.
Vendor: IOMEGA    Model: ZIP 100
Rev: L.01
Type:   Direct-Access
ANSI SCSI revision: 02
Detected scsi removable disk sda at scsi0, channel 0, id 6, lun 0
SCSI device sda: hdwr sector= 512 bytes. Sectors= 196608 [96 MB] [0.1 GB]
    
And here is the oops processed bu ksymoops :
********************************************


ksymoops 2.3.5 on i586 2.2.18pre23.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.2.18pre23/ (default)
     -m /boot/System.map-2.2.18pre23 (specified)

Oops: 0002
CPU:    0
EIP:    0010:[skb_recv_datagram+359/416]
EFLAGS: 00010047
eax: c2d868e0   ebx: 00000000   ecx: 00000246   edx: 00000000
esi: 000005dc   edi: c3203e84   ebp: c36d7a04   esp: c3203dcc
ds: 0018   es: 0018   ss: 0018
Process tnt (pid: 316, process nr: 28, stackpage=c3203000)
Stack: c3203e84 c3203f48 c3ffe040 c3203df0 00000000 00000000 00000000 c019de40
       20000000 c4876b5b c36d79c0 00000000 00000000 c3203e20 c302ed48 000005dc
       c3203e84 c3203f48 00000000 c019de40 c36d79c0 35323431 63333731 c3247e40
Call Trace: [twist_table.690+3744/4256] [<c4876b5b>] [twist_table.690+3744/4256] [sock_recvmsg+65/184] [tcp_listen_poll+56/80] [sys_recvfrom+168/260] [free_pages+39/44]
Code: 89 6a 04 89 55 00 c7 00 00 00 00 00 c7 40 04 00 00 00 00 c7
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   89 6a 04                  mov    %ebp,0x4(%edx)
Code;  00000003 Before first symbol
   3:   89 55 00                  mov    %edx,0x0(%ebp)
Code;  00000006 Before first symbol
   6:   c7 00 00 00 00 00         movl   $0x0,(%eax)
Code;  0000000c Before first symbol
   c:   c7 40 04 00 00 00 00      movl   $0x0,0x4(%eax)
Code;  00000013 Before first symbol
  13:   c7 00 00 00 00 00         movl   $0x0,(%eax)

System is :
***********

-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux debian-f5ibh 2.2.18pre23 #1 jeu nov 23 23:38:07 CET 2000 i586 unknown
Kernel modules         2.3.21
Gnu C                  2.95.2
Binutils               2.9.5.0.41
Linux C Library        2.1.3
Dynamic linker         ldd: version 1.9.11
Procps                 2.0.6
Mount                  2.10o
Net-tools              2.05
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded         scc sd_mod ppa scsi_mod adlib_card v_midi opl3 sb uart401
sound soundcore ide-cd cdrom isofs nls_cp437 vfat fat ppp_deflate bsd_comp ppp 
slhc af_packet ax25 parport_pc lp parport mousedev usb-uhci hid usbcore input 
autofs lockd sunrpc serial unix

---------

Regards

Jean-Luc
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
