Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315370AbSEaXzd>; Fri, 31 May 2002 19:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316192AbSEaXzc>; Fri, 31 May 2002 19:55:32 -0400
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:59149 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S315370AbSEaXzb>; Fri, 31 May 2002 19:55:31 -0400
Message-ID: <3CF80D0B.4070600@megapathdsl.net>
Date: Fri, 31 May 2002 16:53:47 -0700
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020524
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, David Brownell <david-b@pacbell.net>
Subject: 2.5.19 -- 2 OOPSen during boot process.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ksymoops 2.4.4 on i686 2.5.19.  Options used
      -V (default)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.5.19/ (default)
      -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_ksyms_lsmod): module aic7xxx is in lsmod but not in 
ksyms, probably no symbols exported
Warning (compare_ksyms_lsmod): module parport_pc is in lsmod but not in 
ksyms, probably no symbols exported
Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base 
says c0229520, System.map says c0160570.  Ignoring ksyms_base entry
Unable to handle kernel paging request at virtual address ffffffd8
d98f1234
*pde = 00002063
Oops: 0000
CPU:    0
EIP:    0010:[<d98f1234>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: ffffffa0   ebx: 00000000   ecx: d98f6cfc   edx: c033e628
esi: d98f7440   edi: ffffffa0   ebp: ffffffe8   esp: ceda1f1c
ds: 0018   es: 0018   ss: 0018
Stack: c0190d0a ffffffa0 00000002 00000000 cf8a2ac0 d98f6d80 d98ee0a4 
d98f7440
        d98f6cfc c01fe784 cf8a2ac0 00000002 00000000 00000000 ceda1f64 
ceda1f64
        00000000 00000000 ceda1f64 ceda1f64 00000031 c02d8ff0 c02d9154 
000001ff
Call Trace: [<c0190d0a>] [<d98f6d80>] [<d98ee0a4>] [<d98f7440>] [<d98f6cfc>]
    [<c01fe784>] [<d98ee1fa>] [<d98f6d80>] [<c01174fe>] [<c0116823>] 
[<c0106e8f>]
Code: 8b 50 38 a1 20 55 8f d9 85 c0 74 0e 39 d0 74 0c 8b 80 10 01

 >>EIP; d98f1234 <[ohci-hcd].data.end+1cd95/26b61>   <=====
Trace; c0190d0a <pci_unregister_driver+2a/70>
Trace; d98f6d80 <[ohci-hcd].data.end+228e1/26b61>
Trace; d98ee0a4 <[ohci-hcd].data.end+19c05/26b61>
Trace; d98f7440 <[ohci-hcd].data.end+22fa1/26b61>
Trace; d98f6cfc <[ohci-hcd].data.end+2285d/26b61>
Trace; c01fe784 <scsi_unregister_host+224/520>
Trace; d98ee1fa <[ohci-hcd].data.end+19d5b/26b61>
Trace; d98f6d80 <[ohci-hcd].data.end+228e1/26b61>
Trace; c01174fe <free_module+1e/e0>
Trace; c0116823 <sys_delete_module+153/2d0>
Trace; c0106e8f <syscall_call+7/b>
Code;  d98f1234 <[ohci-hcd].data.end+1cd95/26b61>
00000000 <_EIP>:
Code;  d98f1234 <[ohci-hcd].data.end+1cd95/26b61>   <=====
    0:   8b 50 38                  mov    0x38(%eax),%edx   <=====
Code;  d98f1237 <[ohci-hcd].data.end+1cd98/26b61>
    3:   a1 20 55 8f d9            mov    0xd98f5520,%eax
Code;  d98f123c <[ohci-hcd].data.end+1cd9d/26b61>
    8:   85 c0                     test   %eax,%eax
Code;  d98f123e <[ohci-hcd].data.end+1cd9f/26b61>
    a:   74 0e                     je     1a <_EIP+0x1a> d98f124e 
<[ohci-hcd].data.end+1cdaf/26b61>
Code;  d98f1240 <[ohci-hcd].data.end+1cda1/26b61>
    c:   39 d0                     cmp    %edx,%eax
Code;  d98f1242 <[ohci-hcd].data.end+1cda3/26b61>
    e:   74 0c                     je     1c <_EIP+0x1c> d98f1250 
<[ohci-hcd].data.end+1cdb1/26b61>
Code;  d98f1244 <[ohci-hcd].data.end+1cda5/26b61>
   10:   8b 80 10 01 00 00         mov    0x110(%eax),%eax

Unable to handle kernel paging request at virtual address ffffffd4
c0190d0b
*pde = 00002063
Oops: 0002
CPU:    0
EIP:    0010:[<c0190d0b>]    Not tainted
EFLAGS: 00010246
eax: 00000000   ebx: 00000000   ecx: c02d9004   edx: d9921300
esi: d99235e0   edi: ffffffa0   ebp: ffffffe8   esp: ceee1f74
ds: 0018   es: 0018   ss: 0018
Stack: cff31d80 cef1d000 00000000 00000000 d992133a d99235e0 d991e000 
cef1d000
        c01174fe d991e000 cef1d000 fffffff0 c0116823 d991e000 00000000 
ceee0000
        00000000 00000000 bfffeb48 c0106e8f bffffe83 bffffe83 bfffeb48 
00000000
Call Trace: [<d992133a>] [<d99235e0>] [<c01174fe>] [<c0116823>] [<c0106e8f>]
Code: c7 43 d4 00 00 00 00 c7 85 a8 00 00 00 00 00 00 00 8b 03 8b

 >>EIP; c0190d0b <pci_unregister_driver+2b/70>   <=====
Trace; d992133a <.bss.end+467b/????>
Trace; d99235e0 <.bss.end+6921/????>
Trace; c01174fe <free_module+1e/e0>
Trace; c0116823 <sys_delete_module+153/2d0>
Trace; c0106e8f <syscall_call+7/b>
Code;  c0190d0b <pci_unregister_driver+2b/70>
00000000 <_EIP>:
Code;  c0190d0b <pci_unregister_driver+2b/70>   <=====
    0:   c7 43 d4 00 00 00 00      movl   $0x0,0xffffffd4(%ebx)   <=====
Code;  c0190d12 <pci_unregister_driver+32/70>
    7:   c7 85 a8 00 00 00 00      movl   $0x0,0xa8(%ebp)
Code;  c0190d19 <pci_unregister_driver+39/70>
    e:   00 00 00
Code;  c0190d1c <pci_unregister_driver+3c/70>
   11:   8b 03                     mov    (%ebx),%eax
Code;  c0190d1e <pci_unregister_driver+3e/70>
   13:   8b 00                     mov    (%eax),%eax


Output of ver_linux:

Linux turbulence.megapathdsl.net 2.5.19 #1 Fri May 31 00:11:24 PDT 2002 
i686 unknown

Gnu C                  3.0.4
Gnu make               3.79.1
binutils               2.11.90.0.8
util-linux             2.11f
mount                  2.11g
modutils               2.4.14
e2fsprogs              1.26
reiserfsprogs          3.x.0j
pcmcia-cs              3.1.22
PPP                    2.4.1
isdn4k-utils           3.1pre1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         snd-pcm-oss snd-mixer-oss snd-emu10k1 snd-pcm 
snd-timer snd-hwdep snd-util-mem snd-rawmidi snd-seq-device 
snd-ac97-codec parport_pc parport floppy mousedev hid input aic7xxx 
ohci-hcd ehci-hcd ide-scsi ide-cd vfat fat usbcore rtc

