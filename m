Return-Path: <linux-kernel-owner+w=401wt.eu-S964842AbXAGSIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbXAGSIF (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 13:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbXAGSH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 13:07:56 -0500
Received: from mx0.vr-web.de ([195.200.35.198]:58028 "EHLO mx0.vr-web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964800AbXAGSHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 13:07:36 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Jan 2007 13:07:36 EST
From: Andreas Hartmann <andihartmann@01019freenet.de>
X-Newsgroups: linux.kernel
Subject: [2.6.18.2] ide_core oops
Date: Sun, 07 Jan 2007 19:01:38 +0100
Organization: privat
Message-ID: <enrci2$216$1@p54A18DCE.dip0.t-ipconnect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Complaints-To: abuse@arcor.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.8.1.1) Gecko/20070105 SeaMonkey/1.1
X-Enigmail-Version: 0.94.1.2.0
To: linux-kernel@vger.kernel.org
X-BitDefender-Scanner: Clean, Agent: BitDefender Courier MTA Agent
 1.6.2 on vrwebmail
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

the following oops appears, after these actions took place:

1. Booting the notebook.
2. Loading ide_core with putting in a USB stick and mounting the
filesystem onto it.
3. Remove securely the usb stick.
4. suspend the machine.
5. resume the machine.
6. Do a modprobe ide_core again. Afterwards you can see this oops:

notebook1:~ # ksymoops <oops
ksymoops 2.4.11 on i686 2.6.18.2-34-default.  Options used
     -V (default)
     -k /proc/kallsyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.18.2-34-default/ (default)
     -m /boot/System.map-2.6.18.2-34-default (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (read_ksyms): no kernel symbols in ksyms, is /proc/kallsyms a
valid ksyms file?
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Jan  7 12:02:10 notebook1 kernel: BUG: unable to handle kernel paging
request at virtual address e04734b0
Jan  7 12:02:10 notebook1 kernel: c01c01b9
Jan  7 12:02:10 notebook1 kernel: *pde = 1f2ac067
Jan  7 12:02:10 notebook1 kernel: Oops: 0002 [#1]
Jan  7 12:02:10 notebook1 kernel: CPU:    0
Jan  7 12:02:10 notebook1 kernel: EIP:    0060:[<c01c01b9>]    Tainted:
G     U VLI
Using defaults from ksymoops -t elf32-i386 -a i386
Jan  7 12:02:10 notebook1 kernel: EFLAGS: 00010292
(2.6.18.2-34-default #1)
Jan  7 12:02:10 notebook1 kernel: eax: c0351501   ebx: e071b494   ecx:
e04734b0   edx: e071b4b0
Jan  7 12:02:10 notebook1 kernel: esi: ffffffea   edi: c03514c0   ebp:
d1a24de0   esp: db6c5e08
Jan  7 12:02:10 notebook1 kernel: ds: 007b   es: 007b   ss: 0068
Jan  7 12:02:10 notebook1 kernel: Stack: 00000000 c02bd5d1 e071b494
e071b498 fffffffe c0351540 e071b494 ffffffea
Jan  7 12:02:10 notebook1 kernel:        c03514c0 d1a24de0 c01c037e
e071b494 e071b47c c0224f19 e071b494 c02bd5cf
Jan  7 12:02:10 notebook1 kernel:        e070eefd 00000000 00000001
00000000 d1a24800 d1a24e38 d1a24de0 e043785c
Jan  7 12:02:10 notebook1 kernel: Call Trace:
Jan  7 12:02:10 notebook1 kernel:  [<c01c037e>] kobject_register+0x19/0x30
Jan  7 12:02:10 notebook1 kernel:  [<c0224f19>] bus_add_driver+0x51/0x107
Jan  7 12:02:10 notebook1 kernel:  [<e043785c>] init_module+0x716/0x72f
[ide_core]
Jan  7 12:02:10 notebook1 kernel:  [<c0137119>] __link_module+0x0/0x1f
Jan  7 12:02:10 notebook1 kernel:  [<c011b951>] __cond_resched+0x16/0x34
Jan  7 12:02:10 notebook1 kernel:  [<c02a44e0>] cond_resched+0x2a/0x31
Jan  7 12:02:10 notebook1 kernel:  [<c02a4515>]
wait_for_completion+0x18/0xa4
Jan  7 12:02:10 notebook1 kernel:  [<c0140466>] do_stop+0x0/0x117
Jan  7 12:02:10 notebook1 kernel:  [<c0137119>] __link_module+0x0/0x1f
Jan  7 12:02:10 notebook1 kernel:  [<c013987f>]
sys_init_module+0x17fe/0x1981
Jan  7 12:02:10 notebook1 kernel:  [<c014ba04>] generic_file_read+0x0/0xb8
Jan  7 12:02:10 notebook1 kernel:  [<c0103d5d>] sysenter_past_esp+0x56/0x79
Jan  7 12:02:10 notebook1 kernel: Code: 24 14 00 75 0f 8b 43 28 83 c0 14
e8 31 fe ff ff 89 44 24 14 8b 43 28 8d 53 1c 83 c0 08 8b 48 04 89 43 1c
89 50 04 b0 01 89 4a 04 <89> 11 8b 53 28 86 42 10 8b 44 24 14 89 43 24
c7 44 24 10 00 00


>>EIP; c01c01b9 <kobject_add+ab/18a>   <=====

>>eax; c0351501 <pnp_bus_type+41/180>
>>ebx; e071b494 <pg0+202ef494/3fbd2400>
>>ecx; e04734b0 <pg0+200474b0/3fbd2400>
>>edx; e071b4b0 <pg0+202ef4b0/3fbd2400>
>>esi; ffffffea <__kernel_rt_sigreturn+1baa/????>
>>edi; c03514c0 <pnp_bus_type+0/180>
>>ebp; d1a24de0 <pg0+115f8de0/3fbd2400>
>>esp; db6c5e08 <pg0+1b299e08/3fbd2400>

Trace; c01c037e <kobject_register+19/30>
Trace; c0224f19 <bus_add_driver+51/107>
Trace; e043785c <pg0+2000b85c/3fbd2400>
Trace; c0137119 <__link_module+0/1f>
Trace; c011b951 <__cond_resched+16/34>
Trace; c02a44e0 <cond_resched+2a/31>
Trace; c02a4515 <wait_for_completion+18/a4>
Trace; c0140466 <do_stop+0/117>
Trace; c0137119 <__link_module+0/1f>
Trace; c013987f <sys_init_module+17fe/1981>
Trace; c014ba04 <generic_file_read+0/b8>
Trace; c0103d5d <sysenter_past_esp+56/79>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c01c018e <kobject_add+80/18a>
00000000 <_EIP>:
Code;  c01c018e <kobject_add+80/18a>
   0:   24 14                     and    $0x14,%al
Code;  c01c0190 <kobject_add+82/18a>
   2:   00 75 0f                  add    %dh,0xf(%ebp)
Code;  c01c0193 <kobject_add+85/18a>
   5:   8b 43 28                  mov    0x28(%ebx),%eax
Code;  c01c0196 <kobject_add+88/18a>
   8:   83 c0 14                  add    $0x14,%eax
Code;  c01c0199 <kobject_add+8b/18a>
   b:   e8 31 fe ff ff            call   fffffe41 <_EIP+0xfffffe41>
Code;  c01c019e <kobject_add+90/18a>
  10:   89 44 24 14               mov    %eax,0x14(%esp)
Code;  c01c01a2 <kobject_add+94/18a>
  14:   8b 43 28                  mov    0x28(%ebx),%eax
Code;  c01c01a5 <kobject_add+97/18a>
  17:   8d 53 1c                  lea    0x1c(%ebx),%edx
Code;  c01c01a8 <kobject_add+9a/18a>
  1a:   83 c0 08                  add    $0x8,%eax
Code;  c01c01ab <kobject_add+9d/18a>
  1d:   8b 48 04                  mov    0x4(%eax),%ecx
Code;  c01c01ae <kobject_add+a0/18a>
  20:   89 43 1c                  mov    %eax,0x1c(%ebx)
Code;  c01c01b1 <kobject_add+a3/18a>
  23:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c01c01b4 <kobject_add+a6/18a>
  26:   b0 01                     mov    $0x1,%al
Code;  c01c01b6 <kobject_add+a8/18a>
  28:   89 4a 04                  mov    %ecx,0x4(%edx)

This decode from eip onwards should be reliable

Code;  c01c01b9 <kobject_add+ab/18a>
00000000 <_EIP>:
Code;  c01c01b9 <kobject_add+ab/18a>   <=====
   0:   89 11                     mov    %edx,(%ecx)   <=====
Code;  c01c01bb <kobject_add+ad/18a>
   2:   8b 53 28                  mov    0x28(%ebx),%edx
Code;  c01c01be <kobject_add+b0/18a>
   5:   86 42 10                  xchg   %al,0x10(%edx)
Code;  c01c01c1 <kobject_add+b3/18a>
   8:   8b 44 24 14               mov    0x14(%esp),%eax
Code;  c01c01c5 <kobject_add+b7/18a>
   c:   89 43 24                  mov    %eax,0x24(%ebx)
Code;  c01c01c8 <kobject_add+ba/18a>
   f:   c7                        .byte 0xc7
Code;  c01c01c9 <kobject_add+bb/18a>
  10:   44                        inc    %esp
Code;  c01c01ca <kobject_add+bc/18a>
  11:   24 10                     and    $0x10,%al

Jan  7 12:02:10 notebook1 kernel: EIP: [<c01c01b9>]
kobject_add+0xab/0x18a SS:ESP 0068:db6c5e08
Warning (Oops_read): Code line not seen, dumping what data is available


>>EIP; c01c01b9 <kobject_add+ab/18a>   <=====


3 warnings issued.  Results may not be reliable.


lsmod claims, ide_core would have been loaded and would be in use (by
0). ide_core cannot be unloaded again and it doesn't work at all. It
isn't possible to load usb_storage in this situation, too.


lspci -v
00:00.0 Host bridge: Intel Corporation Mobile 915GM/PM/GMS/910GML
Express Processor to DRAM Controller (rev 04)
        Subsystem: Mitac Unknown device 8048
        Flags: bus master, fast devsel, latency 0
        Capabilities: [e0] Vendor Specific Information

00:02.0 VGA compatible controller: Intel Corporation Mobile
915GM/GMS/910GML Express Graphics Controller (rev 04) (prog-if 00 [VGA])
        Subsystem: Mitac Unknown device 8048
        Flags: bus master, fast devsel, latency 0, IRQ 11
        Memory at d0000000 (32-bit, non-prefetchable) [size=512K]
        I/O ports at e000 [size=8]
        Memory at a0000000 (32-bit, prefetchable) [size=256M]
        Memory at d0080000 (32-bit, non-prefetchable) [size=256K]
        Capabilities: [d0] Power Management version 2

00:02.1 Display controller: Intel Corporation Mobile 915GM/GMS/910GML
Express Graphics Controller (rev 04)
        Subsystem: Mitac Unknown device 8048
        Flags: bus master, fast devsel, latency 0
        Memory at d0100000 (32-bit, non-prefetchable) [size=512K]
        Capabilities: [d0] Power Management version 2

00:1b.0 Audio device: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) High Definition Audio Controller (rev 04)
        Subsystem: Mitac Unknown device 8048
        Flags: bus master, fast devsel, latency 0, IRQ 217
        Memory at d0180000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+
Queue=0/0 Enable-
        Capabilities: [70] Express Unknown type IRQ 0

00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #1 (rev 04) (prog-if 00 [UHCI])
        Subsystem: Mitac Unknown device 8048
        Flags: bus master, medium devsel, latency 0, IRQ 193
        I/O ports at 1200 [size=32]

00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #2 (rev 04) (prog-if 00 [UHCI])
        Subsystem: Mitac Unknown device 8048
        Flags: bus master, medium devsel, latency 0, IRQ 177
        I/O ports at 1220 [size=32]

00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #3 (rev 04) (prog-if 00 [UHCI])
        Subsystem: Mitac Unknown device 8048
        Flags: bus master, medium devsel, latency 0, IRQ 201
        I/O ports at 1240 [size=32]

00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB2 EHCI Controller (rev 04) (prog-if 20 [EHCI])
        Subsystem: Mitac Unknown device 8048
        Flags: bus master, medium devsel, latency 0, IRQ 193
        Memory at 20000000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] Debug port

00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev d4)
(prog-if 01 [Subtractive decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=05, sec-latency=32
        I/O behind bridge: 0000c000-0000dfff
        Memory behind bridge: cc000000-cfffffff
        Prefetchable memory behind bridge: 000000009c000000-000000009fffffff
        Capabilities: [50] Subsystem: Mitac Unknown device 8048

00:1f.0 ISA bridge: Intel Corporation 82801FBM (ICH6M) LPC Interface
Bridge (rev 04)
        Subsystem: Mitac Unknown device 8048
        Flags: bus master, medium devsel, latency 0

00:1f.2 IDE interface: Intel Corporation 82801FBM (ICH6M) SATA
Controller (rev 04) (prog-if 80 [Master])
        Subsystem: Mitac Unknown device 8048
        Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 177
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at 1100 [size=16]
        Capabilities: [70] Power Management version 2

00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family)
SMBus Controller (rev 04)
        Subsystem: Mitac Unknown device 8048
        Flags: medium devsel, IRQ 177
        I/O ports at 1400 [size=32]

01:02.0 CardBus bridge: Texas Instruments PCIxx21/x515 Cardbus Controller
        Subsystem: Mitac Unknown device 8048
        Flags: bus master, medium devsel, latency 168, IRQ 169
        Memory at cc009000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=01, secondary=02, subordinate=05, sec-latency=176
        Memory window 0: 9c000000-9dfff000 (prefetchable)
        Memory window 1: ce000000-cffff000
        I/O window 0: 0000c400-0000c4ff
        I/O window 1: 0000c800-0000c8ff
        16-bit legacy interface ports at 0001

01:02.2 FireWire (IEEE 1394): Texas Instruments OHCI Compliant IEEE 1394
Host Controller (prog-if 10 [OHCI])
        Subsystem: Mitac Unknown device 8048
        Flags: bus master, medium devsel, latency 128, IRQ 177
        Memory at fedff800 (32-bit, non-prefetchable) [size=2K]
        Memory at cc00c000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2

01:04.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Mitac Unknown device 8048
        Flags: bus master, medium devsel, latency 128, IRQ 209
        I/O ports at c000 [size=256]
        Memory at cc008000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2

01:05.0 Network controller: RaLink RT2561/RT61 rev B 802.11g
        Subsystem: Micro-Star International Co., Ltd. Unknown device b833
        Flags: bus master, slow devsel, latency 128, IRQ 11
        Memory at cc000000 (32-bit, non-prefetchable) [size=32K]
        Capabilities: [40] Power Management version 2


lsmod (when there is no error)
button                 10896  0
usb_storage            82112  0
ide_core              129992  1 usb_storage
ohci_hcd               23428  0
uhci_hcd               26892  0
ohci1394               37040  0
ieee1394              102584  1 ohci1394
nls_iso8859_1           8320  0
nls_cp437               9984  0
vfat                   16640  0
fat                    55324  1 vfat
af_packet              29320  2
ipv6                  263584  16
battery                14340  0
ac                      9476  0
twofish                47488  3
cryptoloop              7680  3
apparmor               55572  0
aamatch_pcre           18304  1 apparmor
loop                   20488  7 cryptoloop
dm_mod                 60184  13
pcmcia                 40892  0
firmware_class         14080  1 pcmcia
usbhid                 52192  0
snd_hda_intel          23060  1
snd_hda_codec         164352  1 snd_hda_intel
snd_pcm                86916  2 snd_hda_intel,snd_hda_codec
8139too                30592  0
yenta_socket           30348  1
snd_timer              27908  1 snd_pcm
rsrc_nonstatic         17024  1 yenta_socket
snd                    61188  6
snd_hda_intel,snd_hda_codec,snd_pcm,snd_timer
mii                     9600  1 8139too
pcmcia_core            43412  3 pcmcia,yenta_socket,rsrc_nonstatic
soundcore              13792  1 snd
ehci_hcd               34696  0
snd_page_alloc         14472  2 snd_hda_intel,snd_pcm
usbcore               114896  5
usb_storage,ohci_hcd,uhci_hcd,usbhid,ehci_hcd
i2c_i801               11660  0
intel_agp              27804  1
agpgart                35528  3 intel_agp
i2c_core               25216  1 i2c_i801
reiserfs              237312  7
sr_mod                 20132  0
cdrom                  38432  1 sr_mod
edd                    13892  0
fan                     8964  1
sg                     38044  0
ata_piix               19332  3
ahci                   25860  0
libata                119188  2 ata_piix,ahci
thermal                18568  1
processor              34664  1 thermal
sd_mod                 24576  4
scsi_mod              136712  6 usb_storage,sr_mod,sg,ahci,libata,sd_mod


Kind regards,
Andreas Hartmann
