Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264216AbRFLHV2>; Tue, 12 Jun 2001 03:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264228AbRFLHVS>; Tue, 12 Jun 2001 03:21:18 -0400
Received: from fe040.worldonline.dk ([212.54.64.205]:17928 "HELO
	fe040.worldonline.dk") by vger.kernel.org with SMTP
	id <S264216AbRFLHVL>; Tue, 12 Jun 2001 03:21:11 -0400
Date: Tue, 12 Jun 2001 09:17:12 +0200 (CEST)
From: Niels Kristian Bech Jensen <nkbj@image.dk>
X-X-Sender: <nkbj@hafnium.nkbj.dk>
To: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: Oops in linux-2.4.5-ac12 and -ac13.
Message-ID: <Pine.LNX.4.33.0106120912540.805-100000@hafnium.nkbj.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I sometimes get this oops when kmod (rmmod) is unloading serial.o (used
in conjunction with ppp_generic.o, ppp_async.o and slhc.o). It's not
every time, but it seems to happen, if these are the first modules used
after I've used my printer (modules: lp.o, parport.o and parport_pc.o).

ksymoops 2.4.0 on i586 2.4.5-ac13.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.5-ac13/ (default)
     -m /boot/System.map-2.4.5-ac13 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel paging request at virtual address c583a500
c017478e
*pde = 011eb067
Oops: 0002
CPU:    0
EIP:    0010:[<c017478e>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: c01d2930   ebx: 00000100   ecx: c01cc858   edx: c583a500
esi: c5853d80   edi: c5854780   ebp: c585468c   esp: c2551f74
ds: 0018   es: 0018   ss: 0018
Process rmmod (pid: 857, stackpage=c2551000)
Stack: 00000100 ffffffff c584f172 c5853d80 c584a000 c5845000 00000001 c5856000
       c0113dae c584a000 c5845000 00000001 c01132ae c584a000 00000001 c2550000
       00000002 00000061 bfffedb8 c0106c87 00000000 0805f168 00000100 00000002
Call Trace: [<c584f172>] [<c5853d80>] [<c584a000>] [<c5845000>] [<c5856000>]
   [<c0113dae>] [<c584a000>] [<c5845000>] [<c01132ae>] [<c584a000>] [<c0106c87>]
Code: 89 02 8b 1d 28 29 1d c0 81 fb 28 29 1d c0 74 23 89 f6 39 73

>>EIP; c017478e <pci_unregister_driver+e/50>   <=====
Trace; c584f172 <[serial]rs_fini+152/15f>
Trace; c5853d80 <[serial]serial_pci_driver+0/1f>
Trace; c584a000 <[ppp_generic]__kstrtab_all_channels+1ac6/1b26>
Trace; c5845000 <[slhc].rodata.end+1ee1/1f41>
Trace; c5856000 <[ppp_async]__kstrtab_ppp_crc16_table+0/0>
Trace; c0113dae <free_module+1e/c0>
Trace; c584a000 <[ppp_generic]__kstrtab_all_channels+1ac6/1b26>
Trace; c5845000 <[slhc].rodata.end+1ee1/1f41>
Trace; c01132ae <sys_delete_module+18e/1d0>
Trace; c584a000 <[ppp_generic]__kstrtab_all_channels+1ac6/1b26>
Trace; c0106c87 <system_call+37/40>
Code;  c017478e <pci_unregister_driver+e/50>
00000000 <_EIP>:
Code;  c017478e <pci_unregister_driver+e/50>   <=====
   0:   89 02                     mov    %eax,(%edx)   <=====
Code;  c0174790 <pci_unregister_driver+10/50>
   2:   8b 1d 28 29 1d c0         mov    0xc01d2928,%ebx
Code;  c0174796 <pci_unregister_driver+16/50>
   8:   81 fb 28 29 1d c0         cmp    $0xc01d2928,%ebx
Code;  c017479c <pci_unregister_driver+1c/50>
   e:   74 23                     je     33 <_EIP+0x33> c01747c1 <pci_unregister_driver+41/50>
Code;  c017479e <pci_unregister_driver+1e/50>
  10:   89 f6                     mov    %esi,%esi
Code;  c01747a0 <pci_unregister_driver+20/50>
  12:   39 73 00                  cmp    %esi,0x0(%ebx)


1 warning issued.  Results may not be reliable.

-- 
Niels Kristian Bech Jensen -- nkbj@image.dk -- http://www.image.dk/~nkbj/

----------->>  Stop software piracy --- use free software!  <<-----------

