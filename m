Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131755AbRBQOGP>; Sat, 17 Feb 2001 09:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131754AbRBQOGG>; Sat, 17 Feb 2001 09:06:06 -0500
Received: from mailgate.FH-Aachen.DE ([149.201.10.254]:11498 "EHLO
	mailgate.fh-aachen.de") by vger.kernel.org with ESMTP
	id <S131755AbRBQOFz>; Sat, 17 Feb 2001 09:05:55 -0500
Posted-Date: Sat, 17 Feb 2001 15:05:53 +0100 (MET)
Date: Sat, 17 Feb 2001 15:05:25 +0100
From: f5ibh <f5ibh@db0bm.ampr.org>
Message-Id: <200102171405.PAA00470@db0bm.ampr.org>
To: linux-kernel@vger.kernel.org
Subject: [Oops] : 2.4.2-pre4 (and others) lp / zip, parallel port problems
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I've a parallel zip drive and an epson printer on the parallel port, the
printer is connected to the zip drive in daisy chain. All is modularised.

There are problems with this configuration with all the kernels :
1.2.18, 2.2.19-pre13, 2.4.2-pre4 and 2.4.1-ac15

The behaviour is different depending of the kernel.
If I attach the printer directly to the parallel port, it works fine.
Otherwise, I get the following. The worse is 2.4.2-pre4, with a oops.

with 2.4.2-pre4
===============
When I want to print, I've the following messages :

Feb 17 11:34:22 debian-f5ibh kernel: 0x378: FIFO is 16 bytes
Feb 17 11:34:22 debian-f5ibh kernel: 0x378: writeIntrThreshold is 7
Feb 17 11:34:22 debian-f5ibh kernel: 0x378: readIntrThreshold is 7
Feb 17 11:34:22 debian-f5ibh kernel: parport0: PC-style at 0x378 (0x778), irq
7, dma 3 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
Feb 17 11:34:22 debian-f5ibh kernel: lp0: using parport0 (interrupt-driven).
Feb 17 11:34:23 debian-f5ibh kernel: lp0 off-line

At this point, he following modules are loaded
parport_pc             22448   2  (autoclean)
lp                      4688   1  (autoclean)
parport                27520   2  (autoclean) [parport_pc lp]

Now, if I try to mount the zip drive I get the following :
ppa: Version 2.07 (for Linux 2.4.x)
ppa0: failed to claim parport because a pardevice is owning the port for too
longtime!
[root@debian-f5ibh] ~ # Unable to handle kernel paging request at virtual
address c907d060
 printing eip:
 c907d060
 *pde = 07f9b063
 *pte = 00000000
 Oops: 0000
 CPU:    0
 EIP:    0010:[<c907d060>]
 EFLAGS: 00010286
 eax: c907d060   ebx: c6e30f20   ecx: c7932180   edx: 0000077a
 esi: c7932180   edi: c6e30aa0   ebp: c9066144   esp: c68a3f10
 ds: 0018   es: 0018   ss: 0018
 Process recode (pid: 275, stackpage=c68a3000)
 Stack: c905db41 c907f440 c6e30aa0 00000000 c9066120 c9065170 c6e30aa0 00000010
        00000000 fffffffb c9065226 00000000 c68a2000 00000000 00000000 00000000
        c9065247 00000000 00000091 00000000 00000091 c9065335 00000000 c6e30aa0
Call Trace: [<c905db41>] [<c907f440>] [<c9066120>] [<c9065170>] [<c9065226>] [<c9065247>] [<c9065335>]
	[<c012f78a>] [<c0108d43>]

Code:  Bad EIP value.

		      
Here is the Oops processed by ksymoops :

ksymoops 2.3.7 on i586 2.4.2-pre4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.2-pre4/ (default)
     -m /boot/System.map-2.4.2-pre4 (specified)

Unable to handle kernel paging request at virtual
 c907d060
 *pde = 07f9b063
 Oops: 0000
 CPU:    0
 EIP:    0010:[<c907d060>]
Using defaults from ksymoops -t elf32-i386 -a i386
 EFLAGS: 00010286
 eax: c907d060   ebx: c6e30f20   ecx: c7932180   edx: 0000077a
 esi: c7932180   edi: c6e30aa0   ebp: c9066144   esp: c68a3f10
 ds: 0018   es: 0018   ss: 0018
 Process recode (pid: 275, stackpage=c68a3000)
 Stack: c905db41 c907f440 c6e30aa0 00000000 c9066120 c9065170 c6e30aa0 00000010
        00000000 fffffffb c9065226 00000000 c68a2000 00000000 00000000 00000000
               c9065247 00000000 00000091 00000000 00000091 c9065335 00000000
               c6e30aa0
Call Trace: [<c905db41>] [<c907f440>] [<c9066120>] [<c9065170>] [<c9065226>] [<c9065247>] [<c9065335>]
            [<c012f78a>] [<c0108d43>]
Code:  Bad EIP value.

>>EIP; c907d060 <END_OF_CODE+f9c1/????>   <=====
Trace; c905db41 <[parport]parport_release+b1/104>
Trace; c907f440 <END_OF_CODE+11da1/????>
Trace; c9066120 <[lp]__module_kernel_version+0/0>
Trace; c9065170 <[lp]lp_error+74/84>
Trace; c9065226 <[lp]lp_check_status+a6/b0>
Trace; c9065247 <[lp]lp_wait_ready+17/3c>
Trace; c9065335 <[lp]lp_write+c9/1d4>
Trace; c012f78a <sys_write+8e/c4>
Trace; c0108d43 <system_call+33/40>

---

My configuration :

The computer is AMD K6-2 / 128Mb SDRAM

-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux debian-f5ibh 2.4.2-pre4 #1 sam fév 17 10:09:53 CET 2001 i586 unknown
Kernel modules         2.4.2
Gnu C                  2.95.2
Binutils               2.9.5.0.37
Linux C Library        2.1.3
Dynamic linker         ldd: version 1.9.11
Procps                 2.0.6
Mount                  2.10q
Net-tools              2.05
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded         parport_pc lp parport mousedev usb-ohci hid input autofs4 rtc serial isa-pnp unix


If I attach directly the printer or the zip to the computer, I can run each
device separately without any problem.

with 2.2.18
===========
If I power on the printer before the zip drive, and I've not yet the zip (ppa
and so) modules loaded, I can use the printer. After accessing the zip drive.
Then, it is impossible to print. There is no problem with the zip drive.
The message is :
Feb 17 13:46:37 debian-f5ibh kernel: lp0 off-line

If the zip drive is power on before the printer, the printer does not works.

with 2.2.19-pre13
=================
Feb 17 12:09:30 debian-f5ibh kernel: parport0: PC-style at 0x378 (0x778), irq 7
[SPP,ECP,ECPEPP,ECPPS2]
Feb 17 12:09:31 debian-f5ibh kernel: parport_probe: failed
Feb 17 12:09:31 debian-f5ibh kernel: parport0: no IEEE-1284 device present.
Feb 17 12:09:31 debian-f5ibh kernel: lp0: using parport0 (interrupt-driven).
Feb 17 12:09:31 debian-f5ibh kernel: lp0 off-line

I didnt managed to print with the printer in daisy chain with the zip drive.
There is no problem with the zip drive.

with 2.4.1-ac15
===============
- If both the printer and the zip are power on at boot time :
------------------------------------------------------------
Feb 17 12:16:35 debian-f5ibh kernel: 0x378: FIFO is 16 bytes
Feb 17 12:16:35 debian-f5ibh kernel: 0x378: writeIntrThreshold is 7
Feb 17 12:16:35 debian-f5ibh kernel: 0x378: readIntrThreshold is 7
Feb 17 12:16:35 debian-f5ibh kernel: 0x378: PWord is 8 bits
Feb 17 12:16:35 debian-f5ibh kernel: 0x378: Interrupts are ISA-Pulses
Feb 17 12:16:35 debian-f5ibh kernel: 0x378: ECP port cfgA=0x10 cfgB=0x4b
Feb 17 12:16:35 debian-f5ibh kernel: 0x378: ECP settings irq=7 dma=3
Feb 17 12:16:35 debian-f5ibh kernel: parport0: PC-style at 0x378 (0x778), irq
7, dma 3 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
Feb 17 12:16:35 debian-f5ibh kernel: parport0: cpp_mux: aa55f00f52ad51(00)
Feb 17 12:16:35 debian-f5ibh kernel: parport0: cpp_daisy: aa5500ff(00)
Feb 17 12:16:35 debian-f5ibh kernel: parport0: assign_addrs: aa5500ff(00)
Feb 17 12:16:35 debian-f5ibh kernel: parport0: cpp_mux: aa55f00f52ad51(00)
Feb 17 12:16:35 debian-f5ibh kernel: parport0: cpp_daisy: aa5500ff(00)
Feb 17 12:16:35 debian-f5ibh kernel: parport0: assign_addrs: aa5500ff(00)
Feb 17 12:16:35 debian-f5ibh kernel: lp0: using parport0 (interrupt-driven).
Feb 17 12:16:36 debian-f5ibh kernel: lp0 off-line

- If the zip is power off, I've not "lp0 off-line" but, after a while :
-----------------------------------------------------------------------
Feb 17 14:21:07 debian-f5ibh kernel: DMA write timed out
Feb 17 14:21:17 debian-f5ibh kernel: parport0: FIFO is stuck
Feb 17 14:21:17 debian-f5ibh kernel: parport0: BUSY timeout (1) in
compat_write_block_pio
Feb 17 14:21:27 debian-f5ibh kernel: DMA write timed out

[many times]
or :
Feb 17 14:23:07 debian-f5ibh kernel: DMA write timed out
Feb 17 14:23:14 debian-f5ibh kernel: parport0: BUSY timeout (-4) in
compat_write_block_pio

When I power on the zip drive, the printer starts printing. Then both the
printer and the zip drive works fine.

---------------
Regards
		Jean-Luc
