Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266944AbUAXNnn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 08:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266946AbUAXNnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 08:43:43 -0500
Received: from [193.170.124.123] ([193.170.124.123]:54668 "EHLO 23.cms.ac")
	by vger.kernel.org with ESMTP id S266944AbUAXNni (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 08:43:38 -0500
Date: Sat, 24 Jan 2004 14:43:26 +0100
From: JG <jg@cms.ac>
To: Lincoln Dale <ltd@cisco.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: TG3: very high CPU usage
In-Reply-To: <20040122125516.7B671202CDC@23.cms.ac>
References: <5.1.0.14.2.20040121100550.03cff190@171.71.163.14>
	<20040119033527.GA11493@linux.comp>
	<20040119033527.GA11493@linux.comp>
	<5.1.0.14.2.20040121100550.03cff190@171.71.163.14>
	<5.1.0.14.2.20040122143222.02a06d68@171.71.163.14>
	<20040122125516.7B671202CDC@23.cms.ac>
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Gentoo 1.4 ;)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Sat__24_Jan_2004_14_43_26_+0100_7d.URyUJIYcCb0aw"
Message-Id: <20040124134334.A0BF9202CA0@23.cms.ac>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sat__24_Jan_2004_14_43_26_+0100_7d.URyUJIYcCb0aw
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

hi,

> i'm also going to test my systems with ttcp, because at the moment i'm transferring my backup from the server to my machine with 105.48 kB/s over the gigabit line via ftp :( but cpu is normal on both machines.

i did some tests now, here are the results.
box1 = 2.6.0 (tg3 driver v2.3, nov5/03)
box2 = 2.6.2-rc1-mm2 (tg3 v2.5, dec22/03)

box1 was sending, box2 receiving:

box1 # ttcp -t -l 65536 -v -b 2097152 -s -D -n100000 192.168.0.3
ttcp-t: buflen=65536, nbuf=100000, align=16384/0, port=5001, sockbufsize=2097152  tcp  -> 192.168.0.3
ttcp-t: socket
ttcp-t: sndbuf
ttcp-t: nodelay
ttcp-t: connect
ttcp-t: -2036334592 bytes in 1247.57 real seconds = 1768.00 KB/sec +++
ttcp-t: -2036334592 bytes in 30.01 CPU seconds = 73492.73 KB/cpu sec
ttcp-t: 100000 I/O calls, msec/call = 12.78, calls/sec = 80.16
ttcp-t: 0.1user 29.8sys 20:47real 2% 0i+0d 0maxrss 1+16pf 67585+105csw
ttcp-t: buffer address 0x807c000

------------------------------------------
now the opposite, box2 was sending, box1 receiving:

box2 ttcp # ttcp -t -l 65536 -v -b 2097152 -s -D -n100000 192.168.0.2
ttcp-t: buflen=65536, nbuf=100000, align=16384/0, port=5001, sockbufsize=2097152  tcp  -> 192.168.0.2
ttcp-t: socket
ttcp-t: sndbuf
ttcp-t: nodelay
ttcp-t: connect
ttcp-t: -2036334592 bytes in 153.82 real seconds = 14339.52 KB/sec +++
ttcp-t: -2036334592 bytes in 28.61 CPU seconds = 77085.45 KB/cpu sec
ttcp-t: 100000 I/O calls, msec/call = 1.58, calls/sec = 650.11
ttcp-t: 0.1user 28.4sys 2:33real 18% 0i+0d 0maxrss 0+17pf 63153+846csw
ttcp-t: buffer address 0x807c000

i thought the cable could be defective because of the results, but i tested with another machine (windows xp, 100mbit card) and both up and download speed via ftp (from both boxes!) was at about 8-9MB/s. so no problem with the cable and it seems also no problem with 100mbit, but as soon as i connect the two tg3 cards together with 1000mbit, one direction is slow (cable is gbit certified and worked with 2.4 kernels without any problem).

as i already mentionend in a previous email, the errors on the tg3 cards are quite high, but only in RX:
box1:
RX packets:18585312 errors:102500 dropped:0 overruns:0 frame:102598
TX packets:12435471 errors:0 dropped:0 overruns:0 carrier:0
box2:
RX packets:6864695 errors:202162 dropped:0 overruns:0 frame:204652
TX packets:10049776 errors:0 dropped:0 overruns:0 carrier:0

cpu usage was also normal in every test (about 15-30%).

JG

--Signature=_Sat__24_Jan_2004_14_43_26_+0100_7d.URyUJIYcCb0aw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAEnaGU788cpz6t2kRAocHAJ4+N2xhFYb5plz5VnyXj2wD01vOWgCeOY1c
OffDJQHtUtfDhnIhZl1eHyg=
=EpOI
-----END PGP SIGNATURE-----

--Signature=_Sat__24_Jan_2004_14_43_26_+0100_7d.URyUJIYcCb0aw--
