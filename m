Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbTJHVM7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 17:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261782AbTJHVM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 17:12:59 -0400
Received: from karpfen.mathe.tu-freiberg.de ([139.20.24.195]:4992 "EHLO
	karpfen.mathe.tu-freiberg.de") by vger.kernel.org with ESMTP
	id S261762AbTJHVM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 17:12:57 -0400
From: Michael Dreher <dreher@math.tu-freiberg.de>
To: linux-kernel@vger.kernel.org, perex@suse.cz
Subject: 2.6.0-test7 no sound and OOPS
Date: Wed, 8 Oct 2003 23:21:02 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310082321.02406.dreher@math.tu-freiberg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
>Montag, 29. September 2003 16:30 wrote Nikolay Nikolov:
>

(the following was with 2.6.0-test6)

>> I have i810 motherboard with onboard sound card. When I play some
>> sound file with play for the first time after the boot, the kernel
>> module snd_pcm_oss crashes. 
>
>
>I can confirm this, but with other hardware, namely:
>
>karpfen:/usr/src/linux # lspci -v
>00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo 
>KT266/A/333]
>        Subsystem: VIA Technologies, Inc. VT8366/A/7 [Apollo 
> KT266/A/333]
>        Flags: bus master, 66Mhz, medium devsel, latency 0
>        Memory at e0000000 (32-bit, prefetchable) [size=64M]
>        Capabilities: [a0] AGP version 2.0
>        Capabilities: [c0] Power Management version 2
>.......
>
>
>00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97 
>Audio Controller (rev 40)
>        Subsystem: AOPEN Inc.: Unknown device 01ae
>        Flags: medium devsel, IRQ 5
>        I/O ports at e800 [size=256]
>        Capabilities: [c0] Power Management version 2
>

The symptoms are: playwave does not work. xmms works, but much too slow
(about half the correct speed).

2.6.0-test5 was OK.

from dmesg:


via82xx: Assuming DXS channels with 48k fixed sample rate.
         Please try dxs_support=1 option and report if it works on your 
machine.
....
Unable to handle kernel paging request at virtual address e0936000
 printing eip:
c034b12c
*pde = 016bf067
*pte = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c034b12c>]    Not tainted
EFLAGS: 00010216
EIP is at snd_pcm_format_set_silence+0x12c/0x1d0
eax: 00000000   ebx: e0932000   ecx: 00000d2d   edx: 000074b4
esi: 00000002   edi: e0936000   ebp: c382dee8   esp: c382ded0
ds: 007b   es: 007b   ss: 0068
Process playwave (pid: 1829, threadinfo=c382c000 task=c377aa00)
Stack: 00000002 c1089940 00000001 00003a5a c6c89bf8 cdcb1f38 c382df08 
c03371df
       00000002 e0932000 00003a5a c30c9f78 c5c3928c d0a1fdf8 c382df24 
c03387b3
       c5c3928c 0000006b c30c9f78 c0338790 dffc780c c382df48 c015b90d 
dcc71eb4
Call Trace:
 [<c03371df>] snd_pcm_oss_sync+0x6f/0x170
 [<c03387b3>] snd_pcm_oss_release+0x23/0xe0
 [<c0338790>] snd_pcm_oss_release+0x0/0xe0
 [<c015b90d>] __fput+0x10d/0x150
 [<c0159e07>] filp_close+0x57/0x90
 [<c0124467>] put_files_struct+0x67/0xd0
 [<c0125109>] do_exit+0x119/0x410
 [<c011f410>] default_wake_function+0x0/0x30
 [<c01254a2>] do_group_exit+0x32/0xa0
 [<c010b18b>] syscall_call+0x7/0xb

Code: f3 ab f6 c2 02 74 02 66 ab f6 c2 01 74 01 aa e9 04 ff ff ff


