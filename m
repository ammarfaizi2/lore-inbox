Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292620AbSBUDQL>; Wed, 20 Feb 2002 22:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292628AbSBUDPw>; Wed, 20 Feb 2002 22:15:52 -0500
Received: from everstor.com ([168.215.194.23]:28128 "EHLO jade.mw.net")
	by vger.kernel.org with ESMTP id <S292620AbSBUDPt>;
	Wed, 20 Feb 2002 22:15:49 -0500
Date: Wed, 20 Feb 2002 22:13:22 -0500 (EST)
Message-Id: <200202210313.g1L3DMK23053@jade.mw.net>
From: jon@jade.mw.net
To: linux-kernel@vger.kernel.org
Subject: TCP Seq num problem in 2.2?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Error messages shown from 'dmesg' during an automated FTP session:

out of order segment: rcv_next 560C7C3C seq 560C81AE - 560C81F4
ofo requeuing : rcv_next 560C81AE seq 560C81AE - 560C81F4
out of order segment: rcv_next 560C81F4 seq 560C8782 - 560C87D4
ofo requeuing : rcv_next 560C8782 seq 560C8782 - 560C87D4
out of order segment: rcv_next 47A329FF seq 47A32F8D - 47A32FDF
ofo requeuing : rcv_next 47A32F8D seq 47A32F8D - 47A32FDF
out of order segment: rcv_next 47A32FDF seq 47A3357A - 47A33B0A
ofo requeuing : rcv_next 47A33593 seq 47A3357A - 47A33B0A
out of order segment: rcv_next 488F0B14 seq 488F10A4 - 488F10E4
ofo requeuing : rcv_next 488F10A4 seq 488F10A4 - 488F10E4

This was reported on a Caldera 2.3 box (2.2 Kernel) as it was talking to proftpd on a Solaris
box across a loaded ISDN link.  Was running snoop on the Sun box at the time
of the failure and, to summerize:

<first part deleted>
2077: Rep:4578 -> Jade:21 (seq 2867933496  ack 279581710)
2079: Jade:21 -> Rep:4578 (seq 279581710  ack 2867933511)
2082: Jade:21 -> Rep:4578 (seq 279581710  ack 2867933511)
2083: Rep:4578 -> Jade:21 (seq 2867933511  ack 279581765)
2085: Jade:21 -> Rep:4578 (seq 279581765  ack 2867933511)
2088: Rep:4578 -> Jade:21 (seq 2867933511  ack 279581789)
2092: Rep:4578 -> Jade:21 (seq 2867932886  ack 279581789)
2093: Jade:21 -> Rep:4578 (seq 279581789  ack 2867933511)
2094: Rep:4578 -> Jade:21 (seq 2867932886  ack 279581789)
2095: Jade:21 -> Rep:4578 (seq 279581789  ack 2867933511)
2096: Rep:4578 -> Jade:21 (seq 2867932886  ack 279581789)
2097: Jade:21 -> Rep:4578 (seq 279581789  ack 2867933511)
2098: Rep:4578 -> Jade:21 (seq 2867932886  ack 279581789)

Note that between packet 2088 and 2092 that the seq number actually
went DOWN!  For definition (Jade is the Sun and Rep is the Linux 2.2
box which is running Caldera 2.3).  At the same time this happened
the Sun box (running proftpd) stopped listening.  Truss showed it
was in a select() waiting for input, which, although it shows in
the packet trace, never got to the application.

Looks as though my machine (Rep) has
tcp.c           1.140.2.7
tcp_input.c     1.164.2.11
tcp_ipv4.c      1.175.2.13
tcp_output.c    1.108.2.5
tcp_timer.c     1.62.2.6

Cannot find in the Changelogs that this problem has ever been 
addressed.  My interest is; is this a bug that HAS been fixed
and I should upgrade, or is this something new (in which case
I would be more than happy to help you with whatever I can as
far as info on the error).

Please cc: me answers/comments directly (jon@jade.mw.net) as I do
not subscribe to the list.

jon
