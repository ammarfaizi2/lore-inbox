Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261286AbSJHQA2>; Tue, 8 Oct 2002 12:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261288AbSJHQA2>; Tue, 8 Oct 2002 12:00:28 -0400
Received: from walkah.net ([216.138.224.62]:15621 "EHLO zeno.walkah.net")
	by vger.kernel.org with ESMTP id <S261286AbSJHQAZ>;
	Tue, 8 Oct 2002 12:00:25 -0400
Date: Tue, 8 Oct 2002 12:07:02 -0400
From: James Walker <walkah@walkah.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.18/19 oops
Message-ID: <20021008160701.GD265@walkah.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings all,

for the past couple weeks I've been getting consistent oopses while
running X (nothing specific seems to 'cause it... typically using
galeon for 10-15 minutes continuously is enough to trigger it).

the machine is a dual 1ghz pIII on an abit vp6 motherboard (with an unused
hpt370 chip) with 768 MB of ram.  I have already tried swapping around the
sticks of RAM... in fact 256 MB is new and even with that alone i
still get the behaviour. The nvidia card is using the nv driver... and
the partitions are all ext3.

below are some ksymoops runs, lspci and ver_linux outputs... I'd be
more than happy to pass along any other information if it would be
useful.

-James


The following are some ksymoops outputs:

(Note: that these outputs are using vanilla 2.4.19 on debian unstable, but I
received similar behaviour trying redhat 8 - with their stock 2.4.18)

ksymoops 2.4.6 on i686 2.4.19.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19/ (default)
     -m /boot/System.map-2.4.19 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Oct  6 17:18:48 plato kernel: cpu: 0, clocks: 1331059, slice: 443686
Oct  6 17:18:48 plato kernel: cpu: 1, clocks: 1331059, slice: 443686
Oct  6 17:18:48 plato kernel: ds: no socket drivers loaded!
Oct  6 17:18:48 plato kernel: ac97_codec: AC97 Audio codec, id: 0x4352:0x5913 (Cirrus Logic CS4297A rev A)
Oct  6 17:23:32 plato kernel: Unable to handle kernel paging request at virtual address 8b440554
Oct  6 17:23:32 plato kernel: c01303d5
Oct  6 17:23:32 plato kernel: *pde = 00000000
Oct  6 17:23:32 plato kernel: Oops: 0000
Oct  6 17:23:32 plato kernel: CPU:    0
Oct  6 17:23:32 plato kernel: EIP:    0010:[kmalloc+253/356]    Not tainted
Oct  6 17:23:32 plato kernel: EFLAGS: 00210087
Oct  6 17:23:32 plato kernel: eax: efffffff   ebx: c12c7268   ecx: cb440540   edx: 00000000
Oct  6 17:23:32 plato kernel: esi: ca560000   edi: c12c72dc   ebp: c12c7268   esp: cdaf7df0
Oct  6 17:23:32 plato kernel: ds: 0018   es: 0018   ss: 0018
Oct  6 17:23:32 plato kernel: Process x-window-manage (pid: 439, stackpage=cdaf7000)
Oct  6 17:23:32 plato kernel: Stack: cc8fe780 000001f0 00000000 00000000 cdaf6000 00200246 c0230e10 00003c5c 
Oct  6 17:23:32 plato kernel:        000001f0 cdaf6000 00003c18 00000000 c02302b9 00003c20 000001f0 cf4590e0 
Oct  6 17:23:32 plato kernel:        00003c18 cdaf7eb8 cf458df4 c02325af c0230420 cf4590e0 00003c18 00000000 
Oct  6 17:23:32 plato kernel: Call Trace:    [alloc_skb+240/444] [sock_alloc_send_pskb+117/448] [memcpy_fromiovec+55/100] [sock_alloc_send_skb+28/36] [unix_stream_sendmsg+290/808]
Oct  6 17:23:32 plato kernel: Code: 8b 44 81 18 89 41 14 83 f8 ff 75 16 8b 41 04 8b 11 89 42 04 
Using defaults from ksymoops -t elf32-i386 -a i386


>>ebx; c12c7268 <_end+f31564/1050335c>
>>ecx; cb440540 <_end+b0aa83c/1050335c>
>>esi; ca560000 <_end+a1ca2fc/1050335c>
>>edi; c12c72dc <_end+f315d8/1050335c>
>>ebp; c12c7268 <_end+f31564/1050335c>
>>esp; cdaf7df0 <_end+d7620ec/1050335c>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 44 81 18               mov    0x18(%ecx,%eax,4),%eax
Code;  00000004 Before first symbol
   4:   89 41 14                  mov    %eax,0x14(%ecx)
Code;  00000007 Before first symbol
   7:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  0000000a Before first symbol
   a:   75 16                     jne    22 <_EIP+0x22> 00000022 Before first symbol
Code;  0000000c Before first symbol
   c:   8b 41 04                  mov    0x4(%ecx),%eax
Code;  0000000f Before first symbol
   f:   8b 11                     mov    (%ecx),%edx
Code;  00000011 Before first symbol
  11:   89 42 04                  mov    %eax,0x4(%edx)

Oct  6 17:32:23 plato kernel: cpu: 0, clocks: 1330990, slice: 443663
Oct  6 17:32:23 plato kernel: cpu: 1, clocks: 1330990, slice: 443663
Oct  6 17:32:23 plato kernel: ds: no socket drivers loaded!
Oct  6 17:32:23 plato kernel: ac97_codec: AC97 Audio codec, id: 0x4352:0x5913 (Cirrus Logic CS4297A rev A)

1 warning issued.  Results may not be reliable.

ksymoops 2.4.6 on i686 2.4.19.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19/ (default)
     -m /boot/System.map-2.4.19 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Oct  7 14:44:36 plato kernel: activating NMI Watchdog ... done.
Oct  7 14:44:36 plato kernel: testing NMI watchdog ... CPU#0: NMI appears to be stuck!
Oct  7 14:44:36 plato kernel: cpu: 0, clocks: 1331203, slice: 443734
Oct  7 14:44:36 plato kernel: cpu: 1, clocks: 1331203, slice: 443734
Oct  7 14:44:36 plato kernel: ds: no socket drivers loaded!
Oct  7 14:44:36 plato kernel: ac97_codec: AC97 Audio codec, id: 0x4352:0x5913 (Cirrus Logic CS4297A rev A)
Oct  7 20:04:15 plato kernel: activating NMI Watchdog ... done.
Oct  7 20:04:15 plato kernel: testing NMI watchdog ... OK.
Oct  7 20:04:15 plato kernel: cpu: 0, clocks: 1331260, slice: 443753
Oct  7 20:04:15 plato kernel: cpu: 1, clocks: 1331260, slice: 443753
Oct  7 20:04:15 plato kernel: ds: no socket drivers loaded!
Oct  7 20:04:15 plato kernel: ac97_codec: AC97 Audio codec, id: 0x4352:0x5913 (Cirrus Logic CS4297A rev A)
Oct  7 20:08:57 plato kernel: NMI Watchdog detected LOCKUP on CPU1, eip c0130eee, registers:
Oct  7 20:08:57 plato kernel: CPU:    1
Oct  7 20:08:57 plato kernel: EIP:    0010:[.text.lock.slab+175/369]    Not tainted
Oct  7 20:08:57 plato kernel: EFLAGS: 00003086
Oct  7 20:08:57 plato kernel: eax: eec8fea4   ebx: 00000000   ecx: eec8fea4   edx: 00000001
Oct  7 20:08:57 plato kernel: esi: c12613a8   edi: 00003282   ebp: ee090114   esp: eec8fe68
Oct  7 20:08:57 plato kernel: ds: 0018   es: 0018   ss: 0018
Oct  7 20:08:57 plato kernel: Process XFree86 (pid: 261, stackpage=eec8f000)
Oct  7 20:08:57 plato kernel: Stack: 00000000 cdd895e0 00003282 ee090114 eec8feb8 c184f270 00000001 ec7dc000 
Oct  7 20:08:57 plato kernel:        c013053d c12613a8 eec8fea4 00000001 edc48620 edc48620 edc4867c cdd895e0 
Oct  7 20:08:57 plato kernel:        c0233117 cdd895e0 edc48620 ec3ad920 c023312c edc48620 edc48620 ec3ad920 
Oct  7 20:08:57 plato kernel: Call Trace:    [kfree+133/144] [skb_release_data+107/116] [kfree_skbmem+12/104] [__kfree_skb+229/236] [unix_stream_recvmsg+885/1040]
Oct  7 20:08:57 plato kernel: Code: f3 90 7e f8 e9 0c f2 ff ff 80 7e 24 00 f3 90 7e f8 e9 3c f3 
Using defaults from ksymoops -t elf32-i386 -a i386


>>eax; eec8fea4 <_end+2e8f5120/304fe2dc>
>>ecx; eec8fea4 <_end+2e8f5120/304fe2dc>
>>esi; c12613a8 <_end+ec6624/304fe2dc>
>>ebp; ee090114 <_end+2dcf5390/304fe2dc>
>>esp; eec8fe68 <_end+2e8f50e4/304fe2dc>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   f3 90                     repz nop 
Code;  00000002 Before first symbol
   2:   7e f8                     jle    fffffffc <_EIP+0xfffffffc> fffffffc <END_OF_CODE+f755bf5/????>
Code;  00000004 Before first symbol
   4:   e9 0c f2 ff ff            jmp    fffff215 <_EIP+0xfffff215> fffff215 <END_OF_CODE+f754e0e/????>
Code;  00000009 Before first symbol
   9:   80 7e 24 00               cmpb   $0x0,0x24(%esi)
Code;  0000000d Before first symbol
   d:   f3 90                     repz nop 
Code;  0000000f Before first symbol
   f:   7e f8                     jle    9 <_EIP+0x9> 00000009 Before first symbol
Code;  00000011 Before first symbol
  11:   e9 3c f3 00 00            jmp    f352 <_EIP+0xf352> 0000f352 Before first symbol

Oct  7 20:10:32 plato kernel: activating NMI Watchdog ... done.
Oct  7 20:10:32 plato kernel: testing NMI watchdog ... OK.
Oct  7 20:10:32 plato kernel: cpu: 0, clocks: 1331227, slice: 443742
Oct  7 20:10:32 plato kernel: cpu: 1, clocks: 1331227, slice: 443742
Oct  7 20:10:32 plato kernel: ds: no socket drivers loaded!
Oct  7 20:10:32 plato kernel: ac97_codec: AC97 Audio codec, id: 0x4352:0x5913 (Cirrus Logic CS4297A rev A)

1 warning issued.  Results may not be reliable.

$ sh ver_linux

 
Linux plato 2.4.19 #1 SMP Sun Oct 6 21:33:09 EDT 2002 i686 unknown
unknown GNU/Linux
 
Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11u
mount                  2.11u
modutils               2.4.19
e2fsprogs              1.30-WIP
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               4.5.1
Modules Loaded         emu10k1 keybdev input

$ lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo
PRO133x] (rev c4)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo
MVP3/Pro133x AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super
South] (rev 40)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
(rev 40)
00:09.0 SCSI storage controller: Adaptec AHA-2940U2/U2W
00:0b.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1
(rev 08)
00:0b.1 Input device controller: Creative Labs SB Live! MIDI/Game Port
(rev 08)
00:0d.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970
[PCnet LANCE] (rev 16)
00:0e.0 Unknown mass storage controller: Triones Technologies,
Inc. HPT366 / HPT370 (rev 03)
01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2
MX] (rev a1)
