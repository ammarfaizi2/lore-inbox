Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273870AbRJYNZn>; Thu, 25 Oct 2001 09:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273333AbRJYNZX>; Thu, 25 Oct 2001 09:25:23 -0400
Received: from [63.220.7.190] ([63.220.7.190]:18134 "HELO gamerack.com")
	by vger.kernel.org with SMTP id <S273888AbRJYNYL>;
	Thu, 25 Oct 2001 09:24:11 -0400
Subject: Re: SiS/Trident 4DWave sound driver oops
From: "Michael F. Robbins" <compumike@compumike.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15.99+cvs.2001.10.05.08.08 (Preview Release)
Date: 25 Oct 2001 09:24:21 -0400
Message-Id: <1004016263.1384.15.camel@tbird.robbins>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just grabbed 2.4.12-ac6 and the OOPS continues.  This is with
soundcore, ac97_codec, and trident all built as modules.

Again, like my previous report (which was on Linus' 2.4.12), I can
'modprobe soundcore' and 'modprobe ac97_codec' with no problems.  Once I
do the 'modprobe trident', I get the oops.  After the oops, the system
is still responsive, and just like Stuart Young reported, the trident
module is stuck in "initalizing".

See below for the details including the oops report itself.

Mike Robbins
compumike@compumike.com
(Please also cc your reply to me.)




`cat /proc/modules` after the oops:
-----------
trident                26800 (initializing)
ac97_codec              9120   0 [trident]
soundcore               3568   2 [trident]
NVdriver              713104  17
8139too                12896   1 (autoclean)
-----------



Relevant part of /proc/pci:
----------
  Bus  0, device   3, function  0:
    Multimedia audio controller: PCI device 10b9:5451 (Acer Laboratories
Inc. [ALi]) (rev 2).
      IRQ 10.
      Master Capable.  Latency=64.  Min Gnt=2.Max Lat=24.
      I/O at 0xc400 [0xc4ff].
      Non-prefetchable 32 bit memory at 0xdfffe000 [0xdfffefff].
----------



Part of /proc/iomem:
dfffe000-dfffefff : PCI device 10b9:5451 (Acer Laboratories Inc. [ALi])



Part of /proc/ioports:
c400-c4ff : PCI device 10b9:5451 (Acer Laboratories Inc. [ALi])



SYSLOG LEADING UP TO OOPS:
(`modprobe trident` executed here, and this is the result:)
----------
Oct 25 08:35:55 tbird kernel: Trident 4DWave/SiS 7018/ALi 5451,Tvia
CyberPro 5050 PCI Audio, version 0.14.9d, 08:28:09 Oct 25 2001
Oct 25 08:35:55 tbird kernel: PCI: Assigned IRQ 10 for device 00:03.0
Oct 25 08:35:55 tbird kernel: trident: ALi Audio Accelerator found at IO
0xc400, IRQ 10
Oct 25 08:35:55 tbird kernel: ac97_codec: AC97 Audio codec, id:
0x414c:0x4326 (Unknown)
Oct 25 08:35:55 tbird kernel: ali: AC97 CODEC read timed out.
Oct 25 08:35:55 tbird kernel: ali: AC97 CODEC write timed out.
Oct 25 08:35:55 tbird kernel: ali: AC97 CODEC read timed out.
Oct 25 08:35:55 tbird last message repeated 2 times
Oct 25 08:35:55 tbird kernel: ac97_codec: AC97  codec, id: 0x0000:0x0000
(Unknown)
Oct 25 08:35:55 tbird kernel: ali: AC97 CODEC read timed out.
Oct 25 08:35:55 tbird kernel: ali: AC97 CODEC write timed out.
Oct 25 08:35:55 tbird kernel: ali: AC97 CODEC read timed out.
Oct 25 08:35:55 tbird kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000000
---------- (the rest of the oops follows this)



KSYMOOPS REPORT:
-----------
Unable to handle kernel NULL pointer dereference at virtual address
00000000
e5991d7e
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<e5991d7e>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 00000000   ebx: dc4c7cc0   ecx: df408000   edx: 00000006
esi: 00000000   edi: dc4c7d70   ebp: 00000001   esp: dcd01e98
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 885, stackpage=dcd01000)
Stack: dc4c7cc0 02000000 dc4c7d70 00000001 e5999fcb dc4c7cc0 00000024
00000003
       dee5c000 dfff5000 e599b120 dfff6400 e599a410 dee5c000 ffffffed
0000c400
       02000000 e599b068 e599b1e0 dfff6400 00000000 c01b22a4 dfff6400
e599b068
Call Trace: [<e5999fcb>] [<e599b120>] [<e599a410>] [<e599b068>]
[<e599b1e0>]
   [<c01b22a4>] [<e599b068>] [<e599b1e0>] [<c01b2302>] [<e599b1e0>]
[<e599a634>]
   [<e599b1e0>] [<e599aee0>] [sys_init_module+1317/1504] [<e599b860>]
[<e5995060>] [system_call+51/56]
   [<e599b1e0>] [<e599aee0>] [<c01142c5>] [<e599b860>] [<e5995060>]
[<c0106ecb>]
Code: 8b 00 85 c0 74 04 53 ff d0 5a 31 ed 83 3d e0 31 99 e5 ff ba

>>EIP; e5991d7e <[ac97_codec]ac97_init_mixer+7e/e0>   <=====
Trace; e5999fcb <[trident]trident_ac97_init+22b/2f0>
Trace; e599b120 <[trident]trident_audio_fops+0/60>
Trace; e599a410 <[trident]trident_probe+380/4a0>
Trace; e599b068 <[trident]trident_pci_tbl+54/a8>
Trace; e599b1e0 <[trident]trident_pci_driver+0/3f>
Trace; c01b22a4 <pci_announce_device+34/50>
Trace; e599b068 <[trident]trident_pci_tbl+54/a8>
Trace; e599b1e0 <[trident]trident_pci_driver+0/3f>
Trace; c01b2302 <pci_register_driver+42/60>
Trace; e599b1e0 <[trident]trident_pci_driver+0/3f>
Trace; e599a634 <[trident]trident_init_module+24/50>
Trace; e599b1e0 <[trident]trident_pci_driver+0/3f>
Trace; e599aee0 <[trident]__module_pci_device_size+614/693>
Trace; e599b1e0 <[trident]trident_pci_driver+0/3f>
Trace; e599aee0 <[trident]__module_pci_device_size+614/693>
Trace; c01142c5 <sys_init_module+525/5e0>
Trace; e599b860 <.bss.end+1/????>
Trace; e5995060 <[trident]trident_enable_loop_interrupts+0/80>
Trace; c0106ecb <system_call+33/38>
Code;  e5991d7e <[ac97_codec]ac97_init_mixer+7e/e0>
00000000 <_EIP>:
Code;  e5991d7e <[ac97_codec]ac97_init_mixer+7e/e0>   <=====
   0:   8b 00                     mov    (%eax),%eax   <=====
Code;  e5991d80 <[ac97_codec]ac97_init_mixer+80/e0>
   2:   85 c0                     test   %eax,%eax
Code;  e5991d82 <[ac97_codec]ac97_init_mixer+82/e0>
   4:   74 04                     je     a <_EIP+0xa> e5991d88
<[ac97_codec]ac97_init_mixer+88/e0>
Code;  e5991d84 <[ac97_codec]ac97_init_mixer+84/e0>
   6:   53                        push   %ebx
Code;  e5991d85 <[ac97_codec]ac97_init_mixer+85/e0>
   7:   ff d0                     call   *%eax
Code;  e5991d87 <[ac97_codec]ac97_init_mixer+87/e0>
   9:   5a                        pop    %edx
Code;  e5991d88 <[ac97_codec]ac97_init_mixer+88/e0>
   a:   31 ed                     xor    %ebp,%ebp
Code;  e5991d8a <[ac97_codec]ac97_init_mixer+8a/e0>
   c:   83 3d e0 31 99 e5 ff      cmpl   $0xffffffff,0xe59931e0
Code;  e5991d91 <[ac97_codec]ac97_init_mixer+91/e0>
  13:   ba 00 00 00 00            mov    $0x0,%edx
----------




