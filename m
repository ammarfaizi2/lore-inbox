Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267441AbTAWXV3>; Thu, 23 Jan 2003 18:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267439AbTAWXV3>; Thu, 23 Jan 2003 18:21:29 -0500
Received: from WARSL402PIP7.highway.telekom.at ([195.3.96.94]:39258 "HELO
	email02.aon.at") by vger.kernel.org with SMTP id <S267441AbTAWXV1>;
	Thu, 23 Jan 2003 18:21:27 -0500
Reply-To: <dk@webcluster.at>
From: "Daniel Khan" <dk@webcluster.at>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.20 CPU lockup - Now with OOPS message
Date: Fri, 24 Jan 2003 00:30:32 +0100
Message-ID: <DIEGIJEABDDLMLKJFCKJMEFJCEAA.dk@webcluster.at>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello List,

I reported frequently system lockups today.
Now after some playing around (cause I don't know anything about kernel
debugging - Thanks to Mark Hahn for the tipps)
I found a way to reproduce the lock and to get the OOPS.
Dan Kegel told me after the last post that only kernels built from the
kernel.org sources can be supported
by this list. I now used the 2.4.20-2.25smp kernel from RawHide. And I
didn't build a kernel from kernel.org.
O.K. here's the deal:
The OOPS below looks like spanish to me but for the hackers the thing could
be very clear.
So if you think that is a common kernel issue please help. Otherwise I'll
report to RedHat immediately.

Scenario:
2.4.20-2.25smp from RawHide

Doing a rsync from the crashing host _to_ another host over a 1000 Mbit 3com
(TG3).
The rsynced files include bigger files with about 1.5 gigs.
Heartbeat runs.

Below are the OOPS.
Please CC to dk@webcluster.at if you are wanting to help.

Thanks a lot

Daniel Khan

<------------------------CUT---------------------------->
NMI Watchdog detected LOCKUP on CPU0, eip c02499ac, registers:
via686a eeprom lm80 i2c-proc i2c-isa i2c-viapro i2c-core tg3 eepro100 mii
ipt_LOG ipt_limit ipt_state ipt_REJECT iptable_nat ip_cona
CPU:    0
EIP:    0060:[<c02499ac>]    Not tainted
EFLAGS: 00000086

EIP is at .text.lock.tcp_ipv4 [kernel] 0x182 (2.4.20-2.25smp)
eax: 00000001   ebx: d400010a   ecx: 00000000   edx: f78837d8
esi: f6f22ae0   edi: c3d3ad40   ebp: f74939f4   esp: f1335d8c
ds: 0068   es: 0068   ss: 0068
Process rsync (pid: 3151, stackpage=f1335000)
Stack: c3d3ad40 f3121f38 00000001 f1335e28 00000000 03ff0202 00000004
000003ff
       00000000 00000006 c3d3ad40 f74939e0 c022d67e c3d3ad40 f1335e28
c3d5a000
       00000000 00000006 00000000 00000001 00000000 c022d530 c021ce67
c3d3ad40
Call Trace:   [<c022d67e>] ip_local_deliver_finish [kernel] 0x14e
(0xf1335dbc))
[<c022d530>] ip_local_deliver_finish [kernel] 0x0 (0xf1335de0))
[<c021ce67>] nf_hook_slow [kernel] 0x107 (0xf1335de4))
[<c022d530>] ip_local_deliver_finish [kernel] 0x0 (0xf1335e00))
[<c022d2b3>] ip_local_deliver [kernel] 0x53 (0xf1335e1c))
[<c022d530>] ip_local_deliver_finish [kernel] 0x0 (0xf1335e34))
[<c022d8b9>] ip_rcv_finish [kernel] 0x219 (0xf1335e38))
[<c022d6a0>] ip_rcv_finish [kernel] 0x0 (0xf1335e5c))
[<c022d6a0>] ip_rcv_finish [kernel] 0x0 (0xf1335e6c))
[<c021ce67>] nf_hook_slow [kernel] 0x107 (0xf1335e70))
[<c022d6a0>] ip_rcv_finish [kernel] 0x0 (0xf1335e8c))
[<c022d480>] ip_rcv [kernel] 0x1a0 (0xf1335ea8))
[<c022d6a0>] ip_rcv_finish [kernel] 0x0 (0xf1335ec0))
[<c021566e>] netif_receive_skb [kernel] 0x14e (0xf1335ed8))
[<f89d2c7c>] tg3_rx [tg3] 0x27c (0xf1335ef8))
[<f89d2e71>] tg3_poll [tg3] 0x81 (0xf1335f38))
[<c0215917>] net_rx_action [kernel] 0xa7 (0xf1335f58))
[<c01289f9>] do_softirq [kernel] 0xd9 (0xf1335f80))
[<c010b81b>] do_IRQ [kernel] 0xfb (0xf1335f9c))
[<c010e7c8>] call_do_IRQ [kernel] 0x5 (0xf1335fc0))


Code: 7e f8 e9 68 e5 ff ff e8 2c ed eb ff e9 c3 ee ff ff e8 22 ed
console shuts up ...
 NMMI Watchdog detected LOCKUP on CPU1, eip f89d9f3b, registers:
<------------------------CUT---------------------------->

