Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264916AbSJPEdj>; Wed, 16 Oct 2002 00:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264917AbSJPEdj>; Wed, 16 Oct 2002 00:33:39 -0400
Received: from c3p0.cc.swin.edu.au ([136.186.1.10]:40710 "EHLO
	net.cc.swin.edu.au") by vger.kernel.org with ESMTP
	id <S264916AbSJPEdh>; Wed, 16 Oct 2002 00:33:37 -0400
Date: Wed, 16 Oct 2002 14:39:30 +1000 (EST)
From: Tim Connors <tconnors@astro.swin.edu.au>
To: <linux-kernel@vger.kernel.org>
Subject: Oops related to xircom notwork card, 2.5.41
Message-ID: <Pine.LNX.4.33.0210161429090.20193-100000@hexane.ssi.swin.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I came in this morning, after having run 2.5.41 stably for a few days, to
find my network card (Xircom CBEII-10/100 CardBus 10/100 Ethernet) was not
sending any packets on. /sbin/{ifoconfig,route} looked fine, the leds
(link and 100mbit) were on, on the dongle.

I played with the plug, all to no avail, so then pulled out the card from
the socket, and plugged it back in. On 2.4, this never gave me an oops,
but this time I got one.

Any more info needed?
(It was tainted because I was experimenting with paride, I think. I don't
think this was a non-free driver, just incorrect license text in the
module?)

Oct 16 14:13:19 scuzzie kernel: xircom_cb: Link is 0 mbit
Oct 16 14:13:19 scuzzie kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000038
Oct 16 14:13:19 scuzzie kernel:  printing eip:
Oct 16 14:13:19 scuzzie kernel: c02093e1
Oct 16 14:13:19 scuzzie kernel: *pde = 00000000
Oct 16 14:13:19 scuzzie kernel: Oops: 0000
Oct 16 14:13:19 scuzzie kernel: mii paride r128 cpuid nvram agpgart
parport_pc lp parport maestro3 ac97_codec coda autofs4 mousede
v xircom_cb nls_cp437 vfat fat
Oct 16 14:13:19 scuzzie kernel: CPU:    0
Oct 16 14:13:19 scuzzie kernel: EIP:    0060:[yenta_bh+17/68]    Tainted:
P
Oct 16 14:13:19 scuzzie kernel: EFLAGS: 00010002
Oct 16 14:13:19 scuzzie kernel: EIP is at yenta_bh+0x11/0x44
Oct 16 14:13:19 scuzzie kernel: eax: c12ee000   ebx: 00000000   ecx:
cffd8260   edx: cffd8268
Oct 16 14:13:19 scuzzie kernel: esi: c12ee000   edi: c04310a0   ebp:
c12ee000   esp: c12eff8c
Oct 16 14:13:19 scuzzie kernel: ds: 0068   es: 0068   ss: 0068
Oct 16 14:13:19 scuzzie kernel: Process events/0 (pid: 3,
threadinfo=c12ee000 task=c12fac80)
Oct 16 14:13:19 scuzzie kernel: Stack: 00000000 c12ee000 c01238c1 00000000
c01236d8 00000000 00000000 00000000
Oct 16 14:13:19 scuzzie kernel:        c12ee000 cffd8290 cffd8270 cffd8268
00000000 c02093d0 cffd8260 00000001
Oct 16 14:13:19 scuzzie kernel:        00000000 c0112df0 00010000 00000000
00000000 c12fac80 c0112df0 cffd8274
Oct 16 14:13:19 scuzzie kernel: Call Trace:
Oct 16 14:13:19 scuzzie kernel:  [worker_thread+489/716]
worker_thread+0x1e9/0x2cc
Oct 16 14:13:19 scuzzie kernel:  [worker_thread+0/716]
worker_thread+0x0/0x2cc
Oct 16 14:13:19 scuzzie kernel:  [yenta_bh+0/68] yenta_bh+0x0/0x44
Oct 16 14:13:19 scuzzie kernel:  [default_wake_function+0/52]
default_wake_function+0x0/0x34
Oct 16 14:13:19 scuzzie kernel:  [default_wake_function+0/52]
default_wake_function+0x0/0x34
Oct 16 14:13:19 scuzzie kernel:  [kernel_thread_helper+5/12]
kernel_thread_helper+0x5/0xc
Oct 16 14:13:19 scuzzie kernel:
Oct 16 14:13:19 scuzzie kernel: Code: 8b 73 38 c7 43 38 00 00 00 00 fb ff
48 10 8b 40 08 a8 08 74
Oct 16 14:13:19 scuzzie kernel:  <6>note: events/0[3] exited with
preempt_count 1

-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/

Yay! I have found the last bug bug bug bug bug bug bug
bug bug bug bug bug bug bug bug bug bug bug bug bug bug
bug bug bu%$@#$@#%$@#    Error: Missing Carrier Signal

