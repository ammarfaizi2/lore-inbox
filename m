Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274221AbRIXWhu>; Mon, 24 Sep 2001 18:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274222AbRIXWhk>; Mon, 24 Sep 2001 18:37:40 -0400
Received: from mailgate5.cinetic.de ([217.72.192.165]:31888 "EHLO
	mailgate5.cinetic.de") by vger.kernel.org with ESMTP
	id <S274221AbRIXWhU>; Mon, 24 Sep 2001 18:37:20 -0400
Date: Tue, 25 Sep 2001 00:40:15 +0200 (CEST)
From: Pascal Schmidt <pleasure.and.pain@web.de>
To: <linux-kernel@vger.kernel.org>
Subject: Analog joystick fails on 2.4.10
Message-ID: <Pine.LNX.4.33.0109250029200.1022-100000@neptune.sol.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have problems with the analog joystick support in 2.4.10. My gameport is
on an es1371 soundcard. I load the soundcard driver with

modprobe es1371 joystick=0x200

This works and results in:

es1371: found chip, vendor id 0x1274 device id 0x1371 revision 0x08
es1371: found es1371 rev 8 at io 0xdc00 irq 9
es1371: features: joystick 0x200
ac97_codec: AC97 Audio codec, id: 0x4352:0x5913 (Cirrus Logic CS4297A rev
A)

Then I do "modprobe analog". On 2.4.9-ac10, this results in:

input0: Analog 2-axis 4-button joystick at gameport0.0 [TSC timer, 450 MHz
clock, 928 ns res]

The joystick works after that. On 2.4.10, instead I get:

input0: Analog 2-axis 4-button joystick at gameport0.0 [TSC timer, -1187
kHz clock, -197135 ns res]

The values are of course bogus, and the joystick does not work.

"rmmod analog ; modprobe analog" gives a segmentation fault with this
syslog output:

analog.c: 7211 out of 7211 reads (100%) on gameport0 failed
divide error: 0000
CPU:    0
EIP:    0010:[<d09ca483>]
EFLAGS: 00010206
eax: ffff58a8   ebx: ffff58a8   ecx: ffffd62a   edx: ffffffff
esi: ccf93000   edi: ce1ba4fc   ebp: 00001ea0   esp: caf3deb4
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 979, stackpage=caf3d000)
Stack: ce1ba440 d09cacd4 d09cacd4 00001ea0 00000246 ce1ba440 d09cacd4
caf3c000
       d09ca775 ce1ba440 d09cacd4 ccf93000 ce1ba440 d09cacd4 00000000
00001ea0
       ccf93000 00001ea0 c01e7263 ce1ba440 d09cacd4 d09c9000 d09ca9d8
d09ca9e7
Call Trace: [<d09cacd4>] [<d09cacd4>] [<d09cacd4>] [<d09ca775>]
[<d09cacd4>]
   [<d09cacd4>] [<c01e7263>] [<d09cacd4>] [<d09ca9d8>] [<d09ca9e7>]
[<d09cacd4>]

   [<c0115338>] [<d09c9060>] [<c0106d93>]

Code: f7 be 58 08 00 00 89 c7 b8 d3 4d 62 10 f7 ef 89 d3 c1 ff 1f

This looks like modprobe's fault, ksymoops says:

ksymoops 2.4.3 on i586 2.4.9-ac10.  Options used
     -V (default)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.10/ (specified)
     -m /boot/System.map-2.4.10 (specified)

No modules in ksyms, skipping objects
ac97_codec: AC97 Audio codec, id: 0x4352:0x5913 (Cirrus Logic CS4297A rev
A)
CPU:    0
EIP:    0010:[<d09ca483>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: ffff58a8   ebx: ffff58a8   ecx: ffffd62a   edx: ffffffff
esi: ccf93000   edi: ce1ba4fc   ebp: 00001ea0   esp: caf3deb4
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 979, stackpage=caf3d000)
Stack: ce1ba440 d09cacd4 d09cacd4 00001ea0 00000246 ce1ba440 d09cacd4
caf3c000
       d09ca775 ce1ba440 d09cacd4 ccf93000 ce1ba440 d09cacd4 00000000
00001ea0
       ccf93000 00001ea0 c01e7263 ce1ba440 d09cacd4 d09c9000 d09ca9d8
d09ca9e7
Call Trace: [<d09cacd4>] [<d09cacd4>] [<d09cacd4>] [<d09ca775>]
[<d09cacd4>]
   [<d09cacd4>] [<c01e7263>] [<d09cacd4>] [<d09ca9d8>] [<d09ca9e7>]
[<d09cacd4>]
   [<c0115338>] [<d09c9060>] [<c0106d93>]
Code: f7 be 58 08 00 00 89 c7 b8 d3 4d 62 10 f7 ef 89 d3 c1 ff 1f

>>EIP; d09ca482 <END_OF_CODE+10635986/????>   <=====
Trace; d09cacd4 <END_OF_CODE+106361d8/????>
Trace; d09cacd4 <END_OF_CODE+106361d8/????>
Trace; d09cacd4 <END_OF_CODE+106361d8/????>
Trace; d09ca774 <END_OF_CODE+10635c78/????>
Trace; d09cacd4 <END_OF_CODE+106361d8/????>
Trace; d09cacd4 <END_OF_CODE+106361d8/????>
Trace; c01e7262 <gameport_register_device+2e/3c>
Trace; d09cacd4 <END_OF_CODE+106361d8/????>
Trace; d09ca9d8 <END_OF_CODE+10635edc/????>
Trace; d09ca9e6 <END_OF_CODE+10635eea/????>
Trace; d09cacd4 <END_OF_CODE+106361d8/????>
Trace; c0115338 <sys_init_module+5a0/644>
Trace; d09c9060 <END_OF_CODE+10634564/????>
Trace; c0106d92 <system_call+32/40>
Code;  d09ca482 <END_OF_CODE+10635986/????>
00000000 <_EIP>:
Code;  d09ca482 <END_OF_CODE+10635986/????>   <=====
   0:   f7 be 58 08 00 00         idiv   0x858(%esi),%eax   <=====
Code;  d09ca488 <END_OF_CODE+1063598c/????>
   6:   89 c7                     mov    %eax,%edi
Code;  d09ca48a <END_OF_CODE+1063598e/????>
   8:   b8 d3 4d 62 10            mov    $0x10624dd3,%eax
Code;  d09ca48e <END_OF_CODE+10635992/????>
   d:   f7 ef                     imul   %edi,%eax
Code;  d09ca490 <END_OF_CODE+10635994/????>
   f:   89 d3                     mov    %edx,%ebx
Code;  d09ca492 <END_OF_CODE+10635996/????>
  11:   c1 ff 1f                  sar    $0x1f,%edi

Another try at "modprobe analog" after that returns without segfault, but
the analog module stays in "initalizing" forever, at least that's what
lsmod tells me.

-- 
Ciao, Pascal

-<[ pharao90@tzi.de, netmail 2:241/215.72, home http://cobol.cjb.net/) ]>-

