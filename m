Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314589AbSD0FBe>; Sat, 27 Apr 2002 01:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314592AbSD0FBd>; Sat, 27 Apr 2002 01:01:33 -0400
Received: from gamehenge.icculus.org ([12.111.195.138]:62216 "HELO icculus.org")
	by vger.kernel.org with SMTP id <S314589AbSD0FBb>;
	Sat, 27 Apr 2002 01:01:31 -0400
Date: Sat, 27 Apr 2002 01:05:34 -0400 (EDT)
From: Colin Bayer <vogon@icculus.org>
To: <linux-bugs@nvidia.com>, <linux-kernel@vger.kernel.org>
Subject: kswapd/X oops on > 2.4.15/2.5.0 (yes, with the nVidia drivers.)
Message-ID: <Pine.LNX.4.33L2.0204270026140.24721-100000@gamehenge.icculus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, here goes.

Using the proprietary nVidia drivers (yes, *evil*, whatever) on kernels
above 2.4.15, kswapd randomly oopses after a few days up, followed a
couple minutes later by X (which either dumps me to console or royally
fux0rz my screen, depending on its mood.)

I've tried driver versions 2314, 2802, and 2880 and kernels 2.5.0-viro1,
2.4.17, and 2.4.18 in the following combinations:

1) All drivers, kernel 2.5.0: no oops.
2) Drivers 2314 and 2802, kernel 2.4.17: oops.
3) 2880, kernel 2.4.18: oops.

In addition, this thread of linux-kernel [1] seems to suggest an earlier
report of this problem (kernels 2.4.12+, driver 1521) that faded out after
an unanswered request for information.

[1]:
http://hypermail.spyroid.com/linux-kernel/archived/2001/week43/0149.html

Here's the ksymoops output from 2880/2.4.18 (unfortunately, I seem to have
lost the old ksymoops output):

ksymoops 2.4.0 on i686 2.4.18.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18/ (default)
     -m System.map (specified)

Apr 21 13:52:28 fortytwo kernel: cpu: 0, clocks: 1329081, slice: 664540
Apr 21 13:52:32 fortytwo kernel: ac97_codec: AC97 Audio codec, id:
0x4352:0x5914 (Cirrus Logic CS4297A rev B)
Apr 26 19:10:08 fortytwo kernel: invalid operand: 0000
Apr 26 19:10:08 fortytwo kernel: CPU:    0
Apr 26 19:10:08 fortytwo kernel: EIP:    0010:[<c012afec>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
Apr 26 19:10:08 fortytwo kernel: EFLAGS: 00013286
Apr 26 19:10:08 fortytwo kernel: eax: c110a31c   ebx: c129ae40   ecx:
c129ae40  edx: ce6c9150
Apr 26 19:10:08 fortytwo kernel: esi: 00000000   edi: 00000008   ebp:
0000157d  esp: c1469f0c
Apr 26 19:10:08 fortytwo kernel: ds: 0018   es: 0018   ss: 0018
Apr 26 19:10:08 fortytwo kernel: Process kswapd (pid: 4,
stackpage=c1469000)
Apr 26 19:10:08 fortytwo kernel: Stack: c1040000 c0223160 00003203
000001d0 00000000 000001d0 c129ae40 00000008
Apr 26 19:10:08 fortytwo kernel:        0000157d c012a8be c1460400
c1468000 000001fb 000001d0 c0223148 c0291560
Apr 26 19:10:08 fortytwo kernel:        c144b260 c14027c0 00000000
00000020 000001d0 00000006 00000020 c012aac2
Apr 26 19:10:08 fortytwo kernel: Call Trace: [<c012a8be>] [<c012aac2>]
[<c012ab2c>] [<c012abe1>] [<c012ac56>]
Apr 26 19:10:08 fortytwo kernel:    [<c012adb1>] [<c012ad10>] [<c0105000>]
[<c0105516>] [<c012ad10>]
Apr 26 19:10:08 fortytwo kernel: Code: 0f 0b 8b 0d ec 6e 27 c0 89 d8 29 c8
c1 f8 06 3b 05 e0 6e 27

>>EIP; c012afec <__free_pages_ok+2c/200>   <=====
Trace; c012a8be <shrink_cache+21e/2f0>
Trace; c012aac2 <shrink_caches+52/80>
Trace; c012ab2c <try_to_free_pages+3c/60>
Trace; c012abe1 <kswapd_balance_pgdat+51/a0>
Trace; c012ac56 <kswapd_balance+26/50>
Trace; c012adb1 <kswapd+a1/d0>
Trace; c012ad10 <kswapd+0/d0>
Trace; c0105000 <_stext+0/0>
Trace; c0105516 <kernel_thread+26/30>
Trace; c012ad10 <kswapd+0/d0>
Code;  c012afec <__free_pages_ok+2c/200>
00000000 <_EIP>:
Code;  c012afec <__free_pages_ok+2c/200>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012afee <__free_pages_ok+2e/200>
   2:   8b 0d ec 6e 27 c0         mov    0xc0276eec,%ecx
Code;  c012aff4 <__free_pages_ok+34/200>
   8:   89 d8                     mov    %ebx,%eax
Code;  c012aff6 <__free_pages_ok+36/200>
   a:   29 c8                     sub    %ecx,%eax
Code;  c012aff8 <__free_pages_ok+38/200>
   c:   c1 f8 06                  sar    $0x6,%eax
Code;  c012affb <__free_pages_ok+3b/200>
   f:   3b 05 e0 6e 27 00         cmp    0x276ee0,%eax

Apr 26 19:11:59 fortytwo kernel:  invalid operand: 0000
Apr 26 19:11:59 fortytwo kernel: CPU:    0
Apr 26 19:11:59 fortytwo kernel: EIP:    0010:[<c012afec>]    Tainted: P
Apr 26 19:11:59 fortytwo kernel: EFLAGS: 00013286
Apr 26 19:11:59 fortytwo kernel: eax: c12e861c   ebx: c129a7c0   ecx:
c129a7c0  edx: ce6c9150
Apr 26 19:11:59 fortytwo kernel: esi: 00000000   edi: 00000020   ebp:
000015e0  esp: ccfdddac
Apr 26 19:11:59 fortytwo kernel: ds: 0018   es: 0018   ss: 0018
Apr 26 19:11:59 fortytwo kernel: Process X (pid: 15245,
stackpage=ccfdd000)
Apr 26 19:11:59 fortytwo kernel: Stack: ccfdddc0 d0868a20 d0923920
000001d2 00000000 000001d2 c129a7c0 00000020
Apr 26 19:11:59 fortytwo kernel:        000015e0 c012a8be ccfddde8
ccfdc000 00000200 000001d2 c0223148 ccfdde08
Apr 26 19:11:59 fortytwo kernel:        d08596c5 c1402360 00000000
00000020 000001d2 00000006 00000020 c012aac2
Apr 26 19:11:59 fortytwo kernel: Call Trace: [<d0868a20>] [<d0923920>]
[<c012a8be>] [<d08596c5>] [<c012aac2>]
Apr 26 19:11:59 fortytwo kernel:    [<c012ab2c>] [<c012b403>] [<c012b66b>]
[<c0122685>] [<c0122734>] [<c0122878>]
Apr 26 19:11:59 fortytwo kernel:    [<c01068ed>] [<c011298a>] [<c0106075>]
[<c0106159>] [<c0112800>] [<c0106dec>]
Apr 26 19:11:59 fortytwo kernel: Code: 0f 0b 8b 0d ec 6e 27 c0 89 d8 29 c8
c1 f8 06 3b 05 e0 6e 27

>>EIP; c012afec <__free_pages_ok+2c/200>   <=====
Trace; d0868a20 <[NVdriver]__nvsym00470+2c/34>
Trace; d0923920 <[NVdriver]nv_linux_devices+0/4e0>
Trace; c012a8be <shrink_cache+21e/2f0>
Trace; d08596c5 <[NVdriver]nv_kern_isr+1d/a0>
Trace; c012aac2 <shrink_caches+52/80>
Trace; c012ab2c <try_to_free_pages+3c/60>
Trace; c012b403 <balance_classzone+53/1a0>
Trace; c012b66b <__alloc_pages+11b/180>
Trace; c0122685 <do_anonymous_page+35/b0>
Trace; c0122734 <do_no_page+34/120>
Trace; c0122878 <handle_mm_fault+58/c0>
Trace; c01068ed <handle_signal+7d/100>
Trace; c011298a <do_page_fault+18a/4cb>
Trace; c0106075 <restore_sigcontext+115/140>
Trace; c0106159 <sys_sigreturn+b9/f0>
Trace; c0112800 <do_page_fault+0/4cb>
Trace; c0106dec <error_code+34/3c>
Code;  c012afec <__free_pages_ok+2c/200>
00000000 <_EIP>:
Code;  c012afec <__free_pages_ok+2c/200>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012afee <__free_pages_ok+2e/200>
   2:   8b 0d ec 6e 27 c0         mov    0xc0276eec,%ecx
Code;  c012aff4 <__free_pages_ok+34/200>
   8:   89 d8                     mov    %ebx,%eax
Code;  c012aff6 <__free_pages_ok+36/200>
   a:   29 c8                     sub    %ecx,%eax
Code;  c012aff8 <__free_pages_ok+38/200>
   c:   c1 f8 06                  sar    $0x6,%eax
Code;  c012affb <__free_pages_ok+3b/200>
   f:   3b 05 e0 6e 27 00         cmp    0x276ee0,%eax

Apr 26 19:13:15 fortytwo kernel: cpu: 0, clocks: 1329083, slice: 664541
Apr 26 19:13:21 fortytwo kernel: ac97_codec: AC97 Audio codec, id:
0x4352:0x5914 (Cirrus Logic CS4297A rev B)

Hardware inventory:
Pentium III/933 (Coppermine) in an Intel i810E board
256MB PC100 SDRAM (no errors in a 24-hour memtest86 run as of ~1 week ago)
16GB Maxtor (hdd) / 20GB Seagate (hda); swap on /dev/hdd1, /dev/hda7,
/var/swapfile, and /var/swapfile2 (/var == /dev/hda6)
VisionTek Xtasy 5564 (GeForce 2 MX400 PCI) at stock speeds
SoundBlaster PCI128
Some sort of semi-generic 56k modem
Samsung 48X CD-ROM drive (hdc)

.config is up at http://icculus.org/~vogon/oops/dot-config
/proc/ksyms is up at http://icculus.org/~vogon/oops/ksyms
System.map is up at http://icculus.org/~vogon/oops/System.map

Other files will be posted if requested.

Anyway, I'm just wondering if I'm doing something wrong, if this is a bug
in the nVidia drivers, or if it's a bug in the kernel.  Any ideas?

-- Colin <vogon@icculus.org>
(CC me any replies, plzkthxbi.)

