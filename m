Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263491AbTJBVL4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 17:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263494AbTJBVL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 17:11:56 -0400
Received: from karpfen.mathe.tu-freiberg.de ([139.20.24.195]:53901 "EHLO
	karpfen.mathe.tu-freiberg.de") by vger.kernel.org with ESMTP
	id S263491AbTJBVLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 17:11:52 -0400
From: Michael Dreher <dreher@math.tu-freiberg.de>
To: "Nikolay Nikolov" <ndnikolov@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test6 alsa sound bug
Date: Thu, 2 Oct 2003 23:18:37 +0200
User-Agent: KMail/1.5.3
References: <BAY7-F67hOY4l6Etx5300009dc0@hotmail.com>
In-Reply-To: <BAY7-F67hOY4l6Etx5300009dc0@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310022318.37159.dreher@math.tu-freiberg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Montag, 29. September 2003 16:30 wrote Nikolay Nikolov:
> I have i810 motherboard with onboard sound card. When I play some
> sound file with play for the first time after the boot, the kernel
> module snd_pcm_oss crashes. 

I can confirm this, but with other hardware, namely:

karpfen:/usr/src/linux # lspci -v
00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo 
KT266/A/333]
        Subsystem: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
        Capabilities: [c0] Power Management version 2
.......


00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97 
Audio Controller (rev 40)
        Subsystem: AOPEN Inc.: Unknown device 01ae
        Flags: medium devsel, IRQ 5
        I/O ports at e800 [size=256]
        Capabilities: [c0] Power Management version 2

The symptoms are: playwave does not work. xmms works, but much too slow.

The relevant part of dmesg is this:

via82xx: Assuming DXS channels with 48k fixed sample rate.
         Please try dxs_support=1 option and report if it works on your 
machine.
PCI: Setting latency timer of device 0000:00:11.5 to 64
ksysguardd: numerical sysctl 7 2 1 is obsolete.
Unable to handle kernel paging request at virtual address e089a000
 printing eip:
c034b69c
*pde = 016bf067
*pte = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c034b69c>]    Not tainted
EFLAGS: 00010216
EIP is at snd_pcm_format_set_silence+0x12c/0x1d0
eax: 00000000   ebx: e0896000   ecx: 00000d2d   edx: 000074b4
esi: 00000002   edi: e089a000   ebp: c92dfee8   esp: c92dfed0
ds: 007b   es: 007b   ss: 0068
Process playwave (pid: 1785, threadinfo=c92de000 task=c93869e0)
Stack: 00000002 0000000c dffee730 00003a5a d0bd8bf8 ccbcdf38 c92dff08 
c033774f
       00000002 e0896000 00003a5a c2c7df78 c4cfb33c cfcb4df8 c92dff24 
c0338d23
       c4cfb33c c05c5cf0 c2c7df78 c0338d00 dffc780c c92dff48 c015ad7d 
de4bceb4
Call Trace:
 [<c033774f>] snd_pcm_oss_sync+0x6f/0x170
 [<c0338d23>] snd_pcm_oss_release+0x23/0xe0
 [<c0338d00>] snd_pcm_oss_release+0x0/0xe0
 [<c015ad7d>] __fput+0x10d/0x150
 [<c0159277>] filp_close+0x57/0x90
 [<c01239c7>] put_files_struct+0x67/0xd0
 [<c0124689>] do_exit+0x119/0x410
 [<c011e9e0>] default_wake_function+0x0/0x30
 [<c0124a22>] do_group_exit+0x32/0xa0
 [<c010b17b>] syscall_call+0x7/0xb

Code: f3 ab f6 c2 02 74 02 66 ab f6 c2 01 74 01 aa e9 04 ff ff ff
 <1>Unable to handle kernel paging request at virtual address e093f000
 printing eip:
c034b69c
*pde = 016bf067
*pte = 00000000
Oops: 0002 [#2]
CPU:    0
EIP:    0060:[<c034b69c>]    Not tainted
EFLAGS: 00010216
EIP is at snd_pcm_format_set_silence+0x12c/0x1d0
eax: 00000000   ebx: e093b000   ecx: 00000d2d   edx: 000074b4
esi: 00000002   edi: e093f000   ebp: c92dfee8   esp: c92dfed0
ds: 007b   es: 007b   ss: 0068
Process playwave (pid: 1823, threadinfo=c92de000 task=c93869e0)
Stack: 00000002 dffed668 c92dfeec 00003a5a c5d4cbf8 ccbc1f38 c92dff08 
c033774f
       00000002 e093b000 00003a5a c4cf0f78 d930acb0 cfcb4df8 c92dff24 
c0338d23
       d930acb0 c05c5cf0 c4cf0f78 c0338d00 dffc780c c92dff48 c015ad7d 
de4bceb4
Call Trace:
 [<c033774f>] snd_pcm_oss_sync+0x6f/0x170
 [<c0338d23>] snd_pcm_oss_release+0x23/0xe0
 [<c0338d00>] snd_pcm_oss_release+0x0/0xe0
 [<c015ad7d>] __fput+0x10d/0x150
 [<c0159277>] filp_close+0x57/0x90
 [<c01239c7>] put_files_struct+0x67/0xd0
 [<c0124689>] do_exit+0x119/0x410
 [<c011e9e0>] default_wake_function+0x0/0x30
 [<c0124a22>] do_group_exit+0x32/0xa0
 [<c010b17b>] syscall_call+0x7/0xb

Code: f3 ab f6 c2 02 74 02 66 ab f6 c2 01 74 01 aa e9 04 ff ff ff


If you need more info, just ask.

Michael




> Here is the Oops:
>
> Unable to handle kernel paging request at virtual address d4971000
> printing eip:
> d4991e1d
> *pde = 01329067
> *pte = 00000000
> Oops: 0002 [#1]
> CPU:    0
> EIP:    0060:[<d4991e1d>]    Not tainted
> EFLAGS: 00210206
> EIP is at snd_pcm_format_set_silence+0x7d/0x1a0 [snd_pcm]
> eax: 00000000   ebx: 0000171c   ecx: 0000078e   edx: 00002e38
> esi: 00000002   edi: d4971000   ebp: c6146380   esp: ce4c3f18
> ds: 007b   es: 007b   ss: 0068
> Process sox (pid: 1850, threadinfo=ce4c2000 task=cedd19a0)
> Stack: 00000001 ce4c2000 0000171c ce7bf000 ceb08ee0 d497a9bc 00000002
> d4970000
>        0000171c ce42e8a0 c6146380 cec8d800 ce42e8a0 d497bbcc c6146380
> ce42e8a0
>        cfed4260 cf10c9b8 cf31ed60 c014a10a cf10c9b8 ce42e8a0 c013f74a
> cfed7cf0
> Call Trace:
> [<d497a9bc>] snd_pcm_oss_sync+0x9c/0x140 [snd_pcm_oss]
> [<d497bbcc>] snd_pcm_oss_release+0x1c/0x90 [snd_pcm_oss]
> [<c014a10a>] __fput+0x3a/0xd0
> [<c013f74a>] unmap_vma_list+0x1a/0x30
> [<c0148d2c>] filp_close+0x5c/0x70
> [<c0148d85>] sys_close+0x45/0x60
> [<c010a7eb>] syscall_call+0x7/0xb
>
> Code: f3 ab f6 c2 02 74 02 66 ab f6 c2 01 74 01 aa e9 05 01 00 00
>
