Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262977AbRE1FrS>; Mon, 28 May 2001 01:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262978AbRE1FrI>; Mon, 28 May 2001 01:47:08 -0400
Received: from nic.lth.se ([130.235.20.3]:6102 "EHLO nic.lth.se")
	by vger.kernel.org with ESMTP id <S262977AbRE1Fq5>;
	Mon, 28 May 2001 01:46:57 -0400
Date: Mon, 28 May 2001 07:46:54 +0200
From: Jakob Borg <jakob@borg.pp.se>
To: linux-kernel@vger.kernel.org
Subject: 2.4.5: USB audio crash again; now with info
Message-ID: <20010528074654.A625@borg.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
X-Operating-System: Linux narayan 2.4.3 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey;

2.4.5 again seems to have the same bug that was introduced in 2.4.4, that
the systems locks up completely when accessing and USB audio device. The
system is a dual P2 400, details to be found in the attached dmesg and
.config. The device in question is "device 3" after the kernel has
enumerated devices (the other device being a webcam and there being no
device 1).

However, this time the following message was printed to the console a few
seconds after the lockup (copied by hand, accurately I hope). I _really_
hope someone has an idea this time, because it makes any kernel >2.4.3
unuseable.

wait_on_irq, CPU 1:
irq:  1 [ 1 0 ]
bh:   0 [ 0 1 ]
Stack dumps:
CPU 0: <unknown>
CPU 1:dfff3ec4 c028d233 00000001 00000020 00000000 c010825d c028d248 dfff3f14
        dd5d7000 00000001 c0186a97 dfff3f14 dfff3f14 00000000 c035e860 dd5d7368
	c0118a8c dd5d7000 c030cc8c 00000020 dd5d7130 dd5d7130 c01937db c030cb68
Call Trace: [<c010825d>] [<c0186a97>] [<c0118a8c>] [<c01937db>] [<c01187eb>] [<c011870c>] [<c01085f5>]
        [<c0105180>] [<c0105180>] [<c0106d2c>] [<c0105180>] [<c0105180>] [<c0100018>] [<c01051ac>] [<c0105212>]
	[<c0207ee7>] [<c01906ce>]

Trace; c010825d <__global_cli+bd/124>
Trace; c0186a97 <flush_to_ldisc+9b/124>
Trace; c0118a8c <__run_task_queue+60/74>
Trace; c01937db <console_softint+17/d4>
Trace; c01187eb <tasklet_action+4f/7c>
Trace; c011870c <do_softirq+5c/8c>
Trace; c01085f5 <do_IRQ+e5/f4>
Trace; c0105180 <default_idle+0/34>
Trace; c0105180 <default_idle+0/34>
Trace; c0106d2c <ret_from_intr+0/20>
Trace; c0105180 <default_idle+0/34>
Trace; c0105180 <default_idle+0/34>
Trace; c0100018 <startup_32+18/cb>
Trace; c01051ac <default_idle+2c/34>
Trace; c0105212 <cpu_idle+3e/54>
Trace; c0207ee7 <vgacon_cursor+19f/1a8>
Trace; c01906ce <set_cursor+6e/80>

Best regards,

//jb
