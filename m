Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136611AbREANpF>; Tue, 1 May 2001 09:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136613AbREANo4>; Tue, 1 May 2001 09:44:56 -0400
Received: from cp26357-a.gelen1.lb.nl.home.com ([213.51.0.86]:21854 "HELO
	lunchbox.oisec.net") by vger.kernel.org with SMTP
	id <S136611AbREANoo>; Tue, 1 May 2001 09:44:44 -0400
Date: Tue, 1 May 2001 15:44:37 +0200
From: Cliff Albert <cliff@oisec.net>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: 2.4.4, 2.4.4-ac1, 2.4.4-ac2, neighbour discovery bug (ipv6)
Message-ID: <20010501154437.A23200@oisec.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When i traceroute6 my 2.4.4 box on my local lan, the 2.4.4 box panic's after about 10 seconds. The traceroute6 completes on the other box.

2.4.3-ac14 doesn't experience these problems. Only 2.4.4 (with or without ac{1,2}) panics

---- traceroute6 output ----
traceroute to neve.oisec.net (3ffe:8114:2000:0:250:bfff:fe21:629a) from 3ffe:8114:2000:0:210:4bff:feb3:1fb4, 30 hops max, 16 byte packets
 1  neve.oisec.net (3ffe:8114:2000:0:250:bfff:fe21:629a)  0.583 ms  0.278 ms  0.233 ms


wait 10 seconds and the following appears (unfortunately no stack dumps :()

---- panic info 2.4.4-ac2 ----
CPU	0
EIP	0010:[<c0217314>]
EFLAGS  00010206
eax: c13c2060
ebx: fffffffd
ecx: 00000000
edx: ca65b1dc
esi: 00000000
edi: 00000018
ebp: cbf72000
esp: c029feb0
ds:  0018
es:  0018
ss:  0018
Process swapper (pid: 0, stackpage=c029f000)

Call Trace:

 c021e828 [ndisc_send_ns]
 c01e912c [deliver_to_old_ones]
 c021ecfd [ndisc_error_report]
 c01efd2b [ip_route_input_slow]
 c01eb7ab [neigh_timer_handler]
 c01eb664 [neigh_timer_handler]
 c0119f12 [timer_bh]
 c010b2db [timer_interrupt]
 c0116e5f [bh_action]
 c0116d98 [tasklet_hi_action]
 c0116c9f [do_softirq]
 c0107e41 [do_IRQ]
 c0105120 [default_idle]
 c0105120 [default_idle]
 c0106b14 [ret_from_intr]
 c0105120 [default_idle]
 c0105120 [default_idle]
 c0100018 [startup_32]
 c0105143 [default_idle]
 c01051a9 [cpu_idle]
 c0105000 [init]
 c0100197 [L6]

---- panic info 2.4.4-ac1 ----
CPU	0
EIP	0010:[<c0217354>]
EFLAGS  00010206
eax: c13c2060
ebx: fffffffd
ecx: 00000000
edx: cb73e35c
esi: 00000000
edi: 00000018
ebp: cbf72000
esp: c029feb0
ds:  0018
es:  0018
ss:  0018
Process swapper (pid: 0, stackpage=c029f000)

Call Trace:

 c021e868 [ndisc_send_ns]
 c01e916c [deliver_to_old_ones]
 c021ed3d [ndisc_error_report]
 c01e5d6b [ip_route_input_slow]
 c01eb7eb [neigh_timer_handler]
 c01eb6a4 [neigh_timer_handler]
 c0119f02 [timer_bh]
 c010b2db [timer_interrupt]
 c0116e4f [bh_action]
 c0116d88 [tasklet_hi_action]
 c0116c8f [do_softirq]
 c0107e41 [do_IRQ]
 c0105120 [default_idle]
 c0105120 [default_idle]
 c0106b14 [ret_from_intr]
 c0105120 [default_idle]
 c0105120 [default_idle]
 c0100018 [startup_32]
 c0105143 [default_idle]
 c01051a9 [cpu_idle]
 c0105000 [init]
 c0100197 [L6]

---- panic info 2.4.4 ----

CPU	0
EIP	0010:[<c021aa64>]
EFLAGS  00010206
eax: c13e3060
ebx: fffffffd
ecx: 00000000
edx: c80ef3dc
esi: 00000000
edi: 00000018
ebp: cbf7ac00
esp: c02b9eb0
ds:  0018
es:  0018
ss:  0018
Process swapper (pid: 0, stackpage=c02b9000)

Call Trace:

 c0221fe8 [ndisc_send_ns]
 c01ec2bc [deliver_to_old_ones]
 c02224ed [ndisc_error_report]
 c01e8d0b [ip_route_input_slow]
 c01ee93b [neigh_timer_handler]
 c01ee7f4 [neigh_timer_handler]
 c0119402 [timer_bh]
 c010aa3c [timer_interrupt]
 c011634f [bh_action]
 c0116288 [tasklet_hi_action]
 c011618f [do_softirq]
 c0107ec1 [do_IRQ]
 c0105120 [default_idle]
 c0105120 [default_idle]
 c0106b24 [ret_from_intr]
 c0105120 [default_idle]
 c0105120 [default_idle]
 c0100018 [startup_32]
 c0105143 [default_idle]
 c01051a9 [cpu_idle]
 c0105000 [init]
 c0100197 [L6]


-- 
Cliff Albert		| IRCNet:    #linux.nl, #ne2000, #linux, #freebsd.nl
cliff@oisec.net		| 	     #openbsd, #ipv6, #cu2.nl
-[ICQ: 18461740]--------| 6BONE:     CA2-6BONE       RIPE:     CA3348-RIPE
