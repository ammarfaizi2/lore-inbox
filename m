Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261770AbUKIXen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261770AbUKIXen (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 18:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbUKIXeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 18:34:16 -0500
Received: from netlx014.civ.utwente.nl ([130.89.1.88]:6886 "EHLO
	netlx014.civ.utwente.nl") by vger.kernel.org with ESMTP
	id S261770AbUKIXai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 18:30:38 -0500
Date: Wed, 10 Nov 2004 00:30:07 +0100
From: Gerrit Holl <gerrit@nl.linux.org>
To: linux-kernel@vger.kernel.org
Subject: [OOPS] 2.6.7 probably caused by b44.c when network traffic is heavy
Message-ID: <20041109233003.GA4314@nl.linux.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-UTwente-MailScanner-Information: Scanned by MailScanner. Contact helpdesk@ITBE.utwente.nl for more information.
X-UTwente-MailScanner: Found to be clean
X-UTwente-MailScanner-SpamScore: s
X-MailScanner-From: g.holl@tomaatnet.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[I found a workaround for this problem by using the vendors driver
instead of the one distributed with the kernel, but I figured people
might still be interested]

Hello,

What follows is a bug report of an oops, most likely in b44.c, I am
suffering from. I hope I have provided enough information, for I know very
little about the kernel. I tried to follow the documentation on sending
bug reports as good as possible. Please forgive and notify me if I have
missed something essential. I hope I'm not giving too much superfluent
information: better too much than not enough, as the FAQ taught me.

I sent this to the list and not the maintainer because I am not sure my
diagnosis is correct. It's an ill-educated guess.

Problem description
===================

My Linux 2.6.7 is throwing oopses, which are apparantly caused by b44.c.

I am encountering kernel oopses at irregular intervals. I strongly suspect
them to be caused by my network module, because they seem to happen only
when heavy network traffic is taking place. A message is quickly
repeated at my screen, and a kernel oops is logged to /var/log/messages.
As far as I know, my bug does not affect security. I do not have the
knowledge to identify the exact piece of code involved.

When does it happen
===================

It is not precisely reproducable. But it only happens when there is a lot of
data from the internet to my computer (several megabytes/second). If I
start downloading a multi-gigabyte file with several megabytes per
second, I encounter a crash in the majority of the tries.

Oops message
============

What follows is the output of '# ksymoops <oops'.

ksymoops 2.4.9 on i686 2.6.7.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.7/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Nov  8 21:56:16 topjaklont kernel: Unable to handle kernel paging request at virtual address 14000050
Nov  8 21:56:16 topjaklont kernel: c0158930
Nov  8 21:56:16 topjaklont kernel: *pde = 00000000
Nov  8 21:56:16 topjaklont kernel: Oops: 0000 [#1]
Nov  8 21:56:16 topjaklont kernel: CPU:    0
Nov  8 21:56:16 topjaklont kernel: EIP:    0060:[<c0158930>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Nov  8 21:56:16 topjaklont kernel: EFLAGS: 00010206   (2.6.7) 
Nov  8 21:56:16 topjaklont kernel: eax: 14000050   ebx: 14000050   ecx: 00000010   edx: ddec0000
Nov  8 21:56:16 topjaklont kernel: esi: ce1f1f80   edi: ccfa6f63   ebp: d1569050   esp: ce1f1ea8
Nov  8 21:56:16 topjaklont kernel: ds: 007b   es: 007b   ss: 0068
Nov  8 21:56:16 topjaklont kernel: Stack: 00000000 fffffff4 cca6b568 ccfa6f63 00000000 ddecb8a8 d961b02e 0000000b 
Nov  8 21:56:16 topjaklont kernel:        d961b02e ce1f1f80 ddf65600 ce1f1f10 c014fe0e d030145c ce1f1f18 c01209f9 
Nov  8 21:56:16 topjaklont kernel:        d961b02e ce1f1f10 cca6b900 ce1f1f18 c015029c ce1f1f80 ce1f1f18 ce1f1f10 
Nov  8 21:56:16 topjaklont kernel: Call Trace:
Nov  8 21:56:16 topjaklont kernel:  [<c014fe0e>] do_lookup+0x30/0xa1
Nov  8 21:56:16 topjaklont kernel:  [<c01209f9>] in_group_p+0x42/0x76
Nov  8 21:56:17 topjaklont kernel:  [<c015029c>] link_path_walk+0x41d/0x7fb
Nov  8 21:56:17 topjaklont kernel:  [<c015087c>] path_lookup+0x69/0x105
Nov  8 21:56:17 topjaklont kernel:  [<c0150ace>] __user_walk+0x49/0x5e
Nov  8 21:56:17 topjaklont kernel:  [<c014330d>] sys_access+0x87/0x13c
Nov  8 21:56:17 topjaklont kernel:  [<c011866e>] __do_softirq+0x7e/0x80
Nov  8 21:56:17 topjaklont kernel:  [<c010711a>] do_IRQ+0xc4/0xdf
Nov  8 21:56:17 topjaklont kernel:  [<c0105661>] sysenter_past_esp+0x52/0x71
Nov  8 21:56:17 topjaklont kernel: Code: 8b 03 0f 18 00 90 8d 6b 98 8b 7c 24 0c 39 7d 14 74 12 8b 1b 


>>EIP; c0158930 <__d_lookup+68/f0>   <=====

>>edx; ddec0000 <pg0+1dbc1000/3fcff000>
>>esi; ce1f1f80 <pg0+def2f80/3fcff000>
>>edi; ccfa6f63 <pg0+cca7f63/3fcff000>
>>ebp; d1569050 <pg0+1126a050/3fcff000>
>>esp; ce1f1ea8 <pg0+def2ea8/3fcff000>

Trace; c014fe0e <do_lookup+30/a1>
Trace; c01209f9 <in_group_p+42/76>
Trace; c015029c <link_path_walk+41d/7fb>
Trace; c015087c <path_lookup+69/105>
Trace; c0150ace <__user_walk+49/5e>
Trace; c014330d <sys_access+87/13c>
Trace; c011866e <__do_softirq+7e/80>
Trace; c010711a <do_IRQ+c4/df>
Trace; c0105661 <sysenter_past_esp+52/71>

Code;  c0158930 <__d_lookup+68/f0>
00000000 <_EIP>:
Code;  c0158930 <__d_lookup+68/f0>   <=====
   0:   8b 03                     mov    (%ebx),%eax   <=====
Code;  c0158932 <__d_lookup+6a/f0>
   2:   0f 18 00                  prefetchnta (%eax)
Code;  c0158935 <__d_lookup+6d/f0>
   5:   90                        nop    
Code;  c0158936 <__d_lookup+6e/f0>
   6:   8d 6b 98                  lea    0xffffff98(%ebx),%ebp
Code;  c0158939 <__d_lookup+71/f0>
   9:   8b 7c 24 0c               mov    0xc(%esp,1),%edi
Code;  c015893d <__d_lookup+75/f0>
   d:   39 7d 14                  cmp    %edi,0x14(%ebp)
Code;  c0158940 <__d_lookup+78/f0>
  10:   74 12                     je     24 <_EIP+0x24>
Code;  c0158942 <__d_lookup+7a/f0>
  12:   8b 1b                     mov    (%ebx),%ebx


1 warning and 1 error issued.  Results may not be reliable.


Version information
===================

Linux topjaklont.student.utwente.nl 2.6.7 #2 Tue Jun 22 19:04:56 CEST
2004 i686 i686 i386 GNU/Linux

Gnu C                  3.3.2
Gnu make               3.79.1
binutils               2.14.90.0.6
util-linux             2.11y
mount                  2.11y
module-init-tools      2.4.26
e2fsprogs              1.34
jfsutils               1.1.3
reiserfsprogs          3.6.8
quota-tools            3.06.
PPP                    2.4.1
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 2.0.17
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0
Modules Loaded         nfs lockd sunrpc snd_pcm_oss snd_mixer_oss tuner
bttv tda9887 msp3400 video_buf i2c_algo_bit v4l2_common btcx_risc
i2c_core videodev i810_audio ac97_codec snd_intel8x0 snd_ac97_codec
snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi
snd_seq_device snd soundcore b44 mii ipt_REJECT iptable_filter ip_tables
microcode ext3 jbd dm_mod

The module causing the problem is probably b44, for the Broadcom 4400
network chipset. It's listed as EXPERIMENTAL in menuconfig.

# lsmod
Module                  Size  Used by
nfs                    90416  1
lockd                  56648  2 nfs
sunrpc                127204  4 nfs,lockd
snd_pcm_oss            47784  0
snd_mixer_oss          17152  1 snd_pcm_oss
tuner                  17420  0
bttv                  143020  0
tda9887                 6532  0
msp3400                22292  0
video_buf              16260  1 bttv
i2c_algo_bit            9096  1 bttv
v4l2_common             5120  1 bttv
btcx_risc               4104  1 bttv
i2c_core               18580  5 tuner,bttv,tda9887,msp3400,i2c_algo_bit
videodev                7168  1 bttv
i810_audio             29076  0
ac97_codec             16780  1 i810_audio
snd_intel8x0           29320  0
snd_ac97_codec         64388  1 snd_intel8x0
snd_pcm                80036  2 snd_pcm_oss,snd_intel8x0
snd_timer              19716  1 snd_pcm
snd_page_alloc          8968  2 snd_intel8x0,snd_pcm
snd_mpu401_uart         5888  1 snd_intel8x0
snd_rawmidi            19264  1 snd_mpu401_uart
snd_seq_device          6536  1 snd_rawmidi
snd                    43364  9
snd_pcm_oss,snd_mixer_oss,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device
soundcore               7008  3 bttv,i810_audio,snd
b44                    18052  0
mii                     4224  1 b44
ipt_REJECT              5888  1
iptable_filter          2432  1
ip_tables              14848  2 ipt_REJECT,iptable_filter
microcode               5536  0
ext3                   87172  15
jbd                    48536  1 ext3
dm_mod                 36256  0

# cat /proc/modules

nfs 90416 1 - Live 0xde9f2000
lockd 56648 2 nfs, Live 0xde96e000
sunrpc 127204 4 nfs,lockd, Live 0xde9d1000
snd_pcm_oss 47784 1 - Live 0xde9a2000
snd_mixer_oss 17152 1 snd_pcm_oss, Live 0xde968000
tuner 17420 0 - Live 0xde962000
bttv 143020 0 - Live 0xde97e000
tda9887 6532 0 - Live 0xde940000
msp3400 22292 0 - Live 0xde954000
video_buf 16260 1 bttv, Live 0xde94f000
i2c_algo_bit 9096 1 bttv, Live 0xde8e5000
v4l2_common 5120 1 bttv, Live 0xde903000
btcx_risc 4104 1 bttv, Live 0xde8f2000
i2c_core 18580 5 tuner,bttv,tda9887,msp3400,i2c_algo_bit, Live 0xde910000
videodev 7168 1 bttv, Live 0xde8ef000
i810_audio 29076 0 - Live 0xde946000
ac97_codec 16780 1 i810_audio, Live 0xde8fd000
snd_intel8x0 29320 1 - Live 0xde907000
snd_ac97_codec 64388 1 snd_intel8x0, Live 0xde92b000
snd_pcm 80036 2 snd_pcm_oss,snd_intel8x0, Live 0xde916000
snd_timer 19716 1 snd_pcm, Live 0xde8f7000
snd_page_alloc 8968 2 snd_intel8x0,snd_pcm, Live 0xde833000
snd_mpu401_uart 5888 1 snd_intel8x0, Live 0xde8e2000
snd_rawmidi 19264 1 snd_mpu401_uart, Live 0xde8e9000
snd_seq_device 6536 1 snd_rawmidi, Live 0xde837000
snd 43364 9 snd_pcm_oss,snd_mixer_oss,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device, Live 0xde840000
soundcore 7008 4 bttv,i810_audio,snd, Live 0xde800000
b44 18052 0 - Live 0xde83a000
mii 4224 1 b44, Live 0xde81b000
ipt_REJECT 5888 1 - Live 0xde81e000
iptable_filter 2432 1 - Live 0xde806000
ip_tables 14848 2 ipt_REJECT,iptable_filter, Live 0xde816000
microcode 5536 0 - Live 0xde803000
ext3 87172 15 - Live 0xde84d000
jbd 48536 1 ext3, Live 0xde826000
dm_mod 36256 0 - Live 0xde80c000

# cat /proc/ioports

0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
8800-887f : 0000:00:10.1
9000-907f : 0000:00:02.7
  9000-903f : SiS SI7012 - Controller
9400-94ff : 0000:00:02.7
  9400-94ff : SiS SI7012 - AC'97
a400-a40f : 0000:00:02.5
d000-dfff : PCI Bus #01
  d800-d87f : 0000:01:00.0
e600-e61f : 0000:00:02.1

# cat /proc/iomem

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cbfff : Video ROM
000f0000-000fffff : System ROM
00100000-1dffbfff : System RAM
  00100000-0022c87c : Kernel code
  0022c87d-002bb5ff : Kernel data
1dffc000-1dffefff : ACPI Tables
1dfff000-1dffffff : ACPI Non-volatile Storage
dc800000-dc801fff : 0000:00:0f.0
  dc800000-dc801fff : b44
dd000000-dd000fff : 0000:00:03.3
dd800000-dd800fff : 0000:00:03.2
de000000-de000fff : 0000:00:03.1
de800000-de800fff : 0000:00:03.0
df000000-df000fff : 0000:00:02.3
df800000-dfffffff : PCI Bus #01
  df800000-df81ffff : 0000:01:00.0
e0000000-e3ffffff : 0000:00:00.0
e6800000-e6800fff : 0000:00:0e.1
e7000000-e7000fff : 0000:00:0e.0
  e7000000-e7000fff : bttv0
e8000000-f3ffffff : PCI Bus #01
  e8000000-efffffff : 0000:01:00.0
fe800000-fe800fff : 0000:00:10.0
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

Hardware description
====================

Motherboard
-----------

I have an Asus A7V8X-X motherboard.

Processor details
-----------------

My processor is an Intel Pentium 4 2.80 GHz. Details are below.

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.80GHz
stepping        : 9
cpu MHz         : 2793.529
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5521.40

Memory information
------------------

I have 512 MiB of RAM.

MemTotal:       485232 kB
MemFree:          9320 kB
Buffers:         17348 kB
Cached:         199872 kB
SwapCached:          0 kB
Active:         277472 kB
Inactive:        83948 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       485232 kB
LowFree:          9320 kB
SwapTotal:     1020116 kB
SwapFree:      1020116 kB
Dirty:             108 kB
Writeback:           0 kB
Mapped:         198968 kB
Slab:           107888 kB
Committed_AS:   274224 kB
PageTables:       2876 kB
VmallocTotal:   540664 kB
VmallocUsed:      1916 kB
VmallocChunk:   538576 kB

Hard disk
---------

I have one IDE hard disk, 80.0 GB Samsungo 7200 RPM.

Network
-------

My network chipset is a Broadcom 4400. The module for this is b44. It is
listed as EXPERIMENTAL, which is one of the reasons for my hypothesis
the cause of the problem lies there.

I hope I have given enough information. If not, I'd be glad to give
more.

kind regards,
Gerrit Holl.
