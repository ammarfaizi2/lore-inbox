Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266330AbTAUPfd>; Tue, 21 Jan 2003 10:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266564AbTAUPfd>; Tue, 21 Jan 2003 10:35:33 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:52359 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP
	id <S266330AbTAUPfb>; Tue, 21 Jan 2003 10:35:31 -0500
Date: Tue, 21 Jan 2003 16:44:30 +0100 (CET)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Subject: SIOCGSTAMP does not work ?
Message-ID: <Pine.LNX.4.51.0301211636500.3454@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i was recently trying to use SIOCGSTAMP to get the date of the last packet
that arrived on the socket. like so:

	struct timeval tv;
	...
	ioctl(fd, SIOCGSTAMP, &tv);

Unfortunately no matter how i tried that i always got errno: ENOENT, which
is explained by `man 7 ip':
SIOCGSTAMP was called on a socket where no packet arrived.

Little browsing through the net/ipv4 dir showed that there is a macro
TCP_CHECK_TIMER(sk) that is being used around tcp.c, tcp_ipv4.c and
tcp_timer.c

More grepping showed that TCP_CHECK_TIMER(sk) defined in include/net/tcp.h
does absolutely nothing!

#define TCP_CHECK_TIMER(sk) do { } while (0)

The questions are:
1. Is this all really related?

2. Why is TCP_CHECK_TIMER not coded ?

Regards,
Maciej Soltysiak

-----BEGIN GEEK CODE BLOCK-----
VERSION: 3.1
GIT/MU d-- s:- a-- C++ UL++++$ P L++++ E- W- N- K- w--- O! M- V- PS+ PE++
Y+ PGP- t+ 5-- X+ R tv- b DI+ D---- G e++>+++ h! y?
-----END GEEK CODE BLOCK-----
