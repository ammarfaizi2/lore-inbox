Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275087AbRJNLj4>; Sun, 14 Oct 2001 07:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275094AbRJNLjq>; Sun, 14 Oct 2001 07:39:46 -0400
Received: from [63.220.7.190] ([63.220.7.190]:56786 "HELO gamerack.com")
	by vger.kernel.org with SMTP id <S275087AbRJNLjf>;
	Sun, 14 Oct 2001 07:39:35 -0400
Subject: OOPS 2.4.12 on AC97 Trident ALi 5451
From: "Michael F. Robbins" <mike@gamerack.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15.99+cvs.2001.10.05.08.08 (Preview Release)
Date: 14 Oct 2001 07:39:54 -0400
Message-Id: <1003059594.959.13.camel@tbird.robbins>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to use the ECS K7AMA motherboard with onboard sound.  I'm
using 2.4.7 with the sound working fine right now (with the trident
driver).  I haven't tried 2.4.8, but 2.4.9 through 2.4.12 have given me
trouble with the sound drivers.

The system is an Athlon 1200, ECS K7AMA with ALi 1645 northbridge and
Magic 1535D+ southbridge, Inno3D GeForce 2 GTS 32MB, onboard RTL8139
network, 512MB PC133, and 2 harddrives in a software RAID-1
configuration.  Also running a Promise Ultra 66 controller.  The ECS
website says "AC97 Audio Codec compliant with AC97 2.1 specification".

Software is based on Red Hat Linux 7.1: currently kernel 2.4.7, gcc
2.96, glibc 2.2.2, modutils-2.4.6.

The sound system is loaded as modules (although an identical config with
the sound code compiled in also gives an oops).  I can boot fine on
2.4.12.  Logging to a terminal in as root, I can issue a "modprobe
sound" and "modprobe ac97_codec" with no problems.

System log from immediately after issuing "modprobe trident":
------------------
Oct 11 21:36:00 tbird kernel: Trident 4DWave/SiS 7018/ALi 5451,Tvia
CyberPro 5050 PCI Audio, version 0.14.9c, 21:28:32 Oct 11 2001
Oct 11 21:36:00 tbird kernel: PCI: Assigned IRQ 10 for device 00:03.0
Oct 11 21:36:00 tbird kernel: trident: ALi Audio Accelerator found at IO
0xc400, IRQ 10
Oct 11 21:36:00 tbird kernel: ac97_codec: AC97 Audio codec, id:
0x414c:0x4326 (Unknown)
Oct 11 21:36:00 tbird kernel: ali: AC97 CODEC read timed out.
Oct 11 21:36:00 tbird kernel: ali: AC97 CODEC write timed out.
Oct 11 21:36:00 tbird kernel: ali: AC97 CODEC read timed out.
Oct 11 21:36:00 tbird last message repeated 2 times
Oct 11 21:36:00 tbird kernel: ac97_codec: AC97  codec, id: 0x0000:0x0000
(Unknown)
Oct 11 21:36:00 tbird kernel: ali: AC97 CODEC read timed out.
Oct 11 21:36:00 tbird kernel: ali: AC97 CODEC write timed out.
Oct 11 21:36:00 tbird kernel: ali: AC97 CODEC read timed out.
------------------
and immediately after this the oops begins.  I'm just guessing, but the
"Unknown" readings for the AC97 codec type seem strange, however
checking my logs for my working 2.4.7 shows the same identification. 
Also, as far as the AC97 CODEC reads/writes timing out, they also occur
on my 2.4.7 kernel within the first 2-3 seconds of loading the module,
but it works fine after that.  Here's the ksymoops output from the OOPS:
----------------
ksymoops 2.4.0 on i686 2.4.12.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.12/ (default)
     -m /boot/System.map-2.4.12 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base
says c01b94b0, System.map says c014a370.  Ignoring ksyms_base entry
Unable to handle kernel NULL pointer dereference at virtual address
00000000
e5991d7e
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<e5991d7e>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 00000000   ebx: dcd50280   ecx: dfc7e000   edx: 00000006
esi: 00000000   edi: dcd50330   ebp: 00000001   esp: dbfabea0
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 941, stackpage=dbfab000)
Stack: dcd50280 02000000 dcd50330 00000001 e5999f9b dcd50280 00000024
00000003 
       e599b100 defcd800 ffffffff 0000c400 e599a431 defcd800 02000282
e599b048 
       e599b1c0 c197ec00 00000000 c01af934 c197ec00 e599b048 c197ec00
e599b1c0 
Call Trace: [<e5999f9b>] [<e599b100>] [<e599a431>] [<e599b048>]
[<e599b1c0>] 
   [<c01af934>] [<e599b048>] [<e599b1c0>] [<c01af992>] [<e599b1c0>]
[<e599a614>] 
   [<e599b1c0>] [<e599aec0>] [sys_init_module+1317/1504] [<e599b840>]
[<e5995060>] [system_call+51/56] 
   [<e599b1c0>] [<e599aec0>] [<c01142c5>] [<e599b840>] [<e5995060>]
[<c0106edb>] 
Code: 8b 00 85 c0 74 04 53 ff d0 5a 31 ed 83 3d e0 31 99 e5 ff ba 

>>EIP; e5991d7e <[ac97_codec]ac97_init_mixer+7e/e0>   <=====
Trace; e5999f9b <[trident]trident_ac97_init+22b/2f0>
Trace; e599b100 <[trident]trident_audio_fops+0/48>
Trace; e599a431 <[trident]trident_probe+3d1/4b0>
Trace; e599b048 <[trident]trident_pci_tbl+54/a8>
Trace; e599b1c0 <[trident]trident_pci_driver+0/3f>
Trace; c01af934 <pci_announce_device+34/50>
Trace; e599b048 <[trident]trident_pci_tbl+54/a8>
Trace; e599b1c0 <[trident]trident_pci_driver+0/3f>
Trace; c01af992 <pci_register_driver+42/60>
Trace; e599b1c0 <[trident]trident_pci_driver+0/3f>
Trace; e599a614 <[trident]trident_init_module+24/50>
Trace; e599b1c0 <[trident]trident_pci_driver+0/3f>
Trace; e599aec0 <[trident]__module_pci_device_size+614/693>
Trace; e599b1c0 <[trident]trident_pci_driver+0/3f>
Trace; e599aec0 <[trident]__module_pci_device_size+614/693>
Trace; c01142c5 <sys_init_module+525/5e0>
Trace; e599b840 <.bss.end+1/????>
Trace; e5995060 <[trident]trident_enable_loop_interrupts+0/80>
Trace; c0106edb <system_call+33/38>
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


2 warnings issued.  Results may not be reliable.
----------------

If there is any more information you need, please e-mail me.  And if
you'd like me to try certain patches or help with something, just let me
know.  Thanks in advance.

Mike Robbins
compumike@compumike.com


