Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282179AbRKWQ3y>; Fri, 23 Nov 2001 11:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282183AbRKWQ3p>; Fri, 23 Nov 2001 11:29:45 -0500
Received: from dmb001.rug.ac.be ([157.193.78.1]:205 "HELO dmb.rug.ac.be")
	by vger.kernel.org with SMTP id <S282182AbRKWQ3e>;
	Fri, 23 Nov 2001 11:29:34 -0500
Message-ID: <3BFE8799.4070307@dmb.rug.ac.be>
Date: Fri, 23 Nov 2001 18:30:01 +0100
From: Didier Moens <Didier.Moens@dmb001.rug.ac.be>
Organization: RUG/VIB - Dept. Molecular Biology
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: OOPS in agpgart (2.4.13, 2.4.15pre7)
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,


This is my first oops report on lkml, so please be gentle with me.  :)


Hardware : IBM A30p (P3-1.2 GHz) with Intel i830 and ATI M6 Radeon 
Mobility LY


Symptoms : oops when modprobing agpgart, both in the RedHat 2.4.13-0.6 
kernel and in a vanilla 2.4.15pre7.


Traces :

RH 2.4.13-0.6 :
-------------

# modprobe agpgart

Unable to handle kernel NULL pointer dereference at virtual address 00000020
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<e292d816>]    Tainted: P
EFLAGS: 00010282
EIP is at agp_enable_R50eb8453 [agpgart] 0x39b6
eax: 00000000   ebx: 00000000   ecx: ffffffff   edx: c02d25e8
esi: c1c81c00   edi: e292fb88   ebp: 00000000   esp: deda9eec
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 427, stackpage=deda9000)
Stack: 000001b7 0092fa88 00000000 e292fa88 00000000 e292da80 00000000 
e2928000
        00000000 00000000 00000060 e292dc84 e292ef40 00000000 00000063 
e2928000
        c0118665 00000000 de755000 000071df de754000 00000060 ffffffea 
00000007
Call Trace: [<e292fa88>] __insmod_agpgart_S.data_L1888 [agpgart] 0x748
[<e292da80>] agp_enable_R50eb8453 [agpgart] 0x3c20
[<e292dc84>] agp_enable_R50eb8453 [agpgart] 0x3e24
[<e292ef40>] __insmod_agpgart_S.rodata_L416 [agpgart] 0x1120
[<c0118665>] sys_init_module [kernel] 0x535
[<e2928060>] 
__insmod_agpgart_O/lib/modules/2.4.13-0.6/kernel/drivers/char/agp/agpgart.o_M3BF52777_V132109 
[agpgart] 0x60
[<c0106f2b>] system_call [kernel] 0x33


Code: f6 43 20 07 74 15 53 68 77 35 00 00 68 86 80 00 00 e8 14 11
  Segmentation fault




Vanilla 2.4.15-pre7   (through ksymoops, my first try (!) ) :
-------------------

Nov 22 15:46:54 localhost kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000020
Nov 22 15:46:54 localhost kernel: e08deb06
Nov 22 15:46:54 localhost kernel: *pde = 00000000
Nov 22 15:46:54 localhost kernel: Oops: 0000
Nov 22 15:46:54 localhost kernel: CPU:    0
Nov 22 15:46:54 localhost kernel: EIP:    0010:[<e08deb06>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
Nov 22 15:46:54 localhost kernel: EFLAGS: 00010282
Nov 22 15:46:54 localhost kernel: eax: 00000000   ebx: 00000000   ecx: 
ffffffff   edx: c024d188
Nov 22 15:46:54 localhost kernel: esi: c1838000   edi: e08e0cc8   ebp: 
00000000   esp: dfa07eec
Nov 22 15:46:54 localhost kernel: ds: 0018   es: 0018   ss: 0018
Nov 22 15:46:54 localhost kernel: Process modprobe (pid: 426, 
stackpage=dfa07000)
Nov 22 15:46:54 localhost kernel: Stack: 000001b7 008e0bc8 00000000 
e08e0bc8 00000000 e08ded70 00000000 e08d9000
Nov 22 15:46:54 localhost kernel:        00000000 00000000 00000060 
e08def74 e08dffe0 00000000 00000063 e08d9000
Nov 22 15:46:54 localhost kernel:        c01163a5 00000000 dee87000 
00007283 dee88000 00000060 ffffffea 00000007
Nov 22 15:46:54 localhost kernel: Call Trace: [<e08e0bc8>] [<e08ded70>] 
[<e08def74>] [<e08dffe0>] [sys_init_module+1333/1520]
Nov 22 15:46:54 localhost kernel: Call Trace: [<e08e0bc8>] [<e08ded70>] 
[<e08def74>] [<e08dffe0>] [<c01163a5>]
Nov 22 15:46:54 localhost kernel:    [<e08d9060>] [system_call+51/56]
Nov 22 15:46:54 localhost kernel:    [<e08d9060>] [<c0106f0b>]
Nov 22 15:46:54 localhost kernel: Code: f6 43 20 07 74 15 53 68 77 35 00 
00 68 86 80 00 00 e8 b4 18

 >>EIP; e08deb06 <[agpgart]agp_find_supported_device+196/340>   <=====
Trace; e08e0bc8 <[agpgart]agp_current_version+0/17>
Trace; e08ded70 <[agpgart]agp_backend_initialize+40/1c0>
Trace; e08def74 <[agpgart]agp_init+14/80>
Trace; e08dffe0 <[agpgart].LC85+1a0/5a0>
Trace; e08e0bc8 <[agpgart]agp_current_version+0/17>
Trace; e08ded70 <[agpgart]agp_backend_initialize+40/1c0>
Trace; e08def74 <[agpgart]agp_init+14/80>
Trace; e08dffe0 <[agpgart].LC85+1a0/5a0>
Trace; c01163a5 <sys_init_module+535/5f0>
Trace; e08d9060 <[agpgart]agp_find_mem_by_key+0/30>
Trace; e08d9060 <[agpgart]agp_find_mem_by_key+0/30>
Trace; c0106f0b <system_call+33/38>
Code;  e08deb06 <[agpgart]agp_find_supported_device+196/340>
00000000 <_EIP>:
Code;  e08deb06 <[agpgart]agp_find_supported_device+196/340>   <=====
    0:   f6 43 20 07               testb  $0x7,0x20(%ebx)   <=====
Code;  e08deb0a <[agpgart]agp_find_supported_device+19a/340>
    4:   74 15                     je     1b <_EIP+0x1b> e08deb21 
<[agpgart]agp_find_supported_device+1b1/340>
Code;  e08deb0c <[agpgart]agp_find_supported_device+19c/340>
    6:   53                        push   %ebx
Code;  e08deb0d <[agpgart]agp_find_supported_device+19d/340>
    7:   68 77 35 00 00            push   $0x3577
Code;  e08deb12 <[agpgart]agp_find_supported_device+1a2/340>
    c:   68 86 80 00 00            push   $0x8086
Code;  e08deb17 <[agpgart]agp_find_supported_device+1a7/340>
   11:   e8 b4 18 00 00            call   18ca <_EIP+0x18ca> e08e03d0 
<[agpgart].LC85+590/5a0>


3 warnings issued.  Results may not be reliable.




Didn't try yet with 2.4.15final.


The output of lspci (both 2.4.13-0.6 and 2.4.15pre7) doesn't mention the 
i830 either, though it is defined in /drivers/char/agp/agpgart_be.c, and 
support for AGP_INTEL is compiled in !?

# lspci

00:00.0 Host bridge: Intel Corporation: Unknown device 3575 (rev 02)
00:01.0 PCI bridge: Intel Corporation: Unknown device 3576 (rev 02)
00:1d.0 USB Controller: Intel Corporation: Unknown device 2482 (rev 01)
00:1d.1 USB Controller: Intel Corporation: Unknown device 2484 (rev 01)
00:1d.2 USB Controller: Intel Corporation: Unknown device 2487 (rev 01)
00:1e.0 PCI bridge: Intel Corporation 82801BA PCI (rev 41)
00:1f.0 ISA bridge: Intel Corporation: Unknown device 248c (rev 01)
00:1f.1 IDE interface: Intel Corporation: Unknown device 248a (rev 01)
00:1f.3 SMBus: Intel Corporation: Unknown device 2483 (rev 01)
00:1f.5 Multimedia audio controller: Intel Corporation: Unknown device 
2485 (rev 01)
00:1f.6 Modem: Intel Corporation: Unknown device 2486 (rev 01)
01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown device 4c59
02:00.0 CardBus bridge: Ricoh Co Ltd RL5c478 (rev a0)
02:00.1 CardBus bridge: Ricoh Co Ltd RL5c478 (rev a0)
02:00.2 FireWire (IEEE 1394): Ricoh Co Ltd: Unknown device 0522
02:02.0 Network controller: Harris Semiconductor: Unknown device 3873 
(rev 01)
02:08.0 Ethernet controller: Intel Corporation: Unknown device 1031 (rev 41)




Kind regards,



