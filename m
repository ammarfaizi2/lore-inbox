Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274862AbRLBK5G>; Sun, 2 Dec 2001 05:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282835AbRLBK44>; Sun, 2 Dec 2001 05:56:56 -0500
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:12815
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP
	id <S274862AbRLBK4n>; Sun, 2 Dec 2001 05:56:43 -0500
Subject: 2.4.16: TCP shutdown generating infinite ACK storm
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 02 Dec 2001 02:56:42 -0800
Message-Id: <1007290602.1892.2.camel@ixodes.goop.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm looking at my box and a server at Tom's Hardware pounding each other
with packets.  It looks like Linux has got confused about sequence
numbers (or maybe the other end is confused?).

02:51:20.405848 ad.tomshardware.com.http > ixodes.goop.org.33708: . ack 1 win 17376 <nop,nop,timestamp 14994023 3826698> (DF)
02:51:20.405880 ixodes.goop.org.33708 > ad.tomshardware.com.http: . ack 4294920827 win 6432 <nop,nop,timestamp 3826706 14993505> (DF)
02:51:20.415964 ad.tomshardware.com.http > ixodes.goop.org.33708: . ack 1 win 17376 <nop,nop,timestamp 14994023 3826699> (DF)
02:51:20.415995 ixodes.goop.org.33708 > ad.tomshardware.com.http: . ack 4294920827 win 6432 <nop,nop,timestamp 3826707 14993505> (DF)
02:51:20.422607 ad.tomshardware.com.http > ixodes.goop.org.33708: . ack 1 win 17376 <nop,nop,timestamp 14994023 3826700> (DF)
02:51:20.422638 ixodes.goop.org.33708 > ad.tomshardware.com.http: . ack 4294920827 win 6432 <nop,nop,timestamp 3826707 14993505> (DF)
02:51:20.429027 ad.tomshardware.com.http > ixodes.goop.org.33708: . ack 1 win 17376 <nop,nop,timestamp 14994023 3826700> (DF)
02:51:20.429057 ixodes.goop.org.33708 > ad.tomshardware.com.http: . ack 4294920827 win 6432 <nop,nop,timestamp 3826708 14993505> (DF)
02:51:20.435654 ad.tomshardware.com.http > ixodes.goop.org.33708: . ack 1 win 17376 <nop,nop,timestamp 14994023 3826701> (DF)
02:51:20.435684 ixodes.goop.org.33708 > ad.tomshardware.com.http: . ack 4294920827 win 6432 <nop,nop,timestamp 3826709 14993505> (DF)
02:51:20.446010 ad.tomshardware.com.http > ixodes.goop.org.33708: . ack 1 win 17376 <nop,nop,timestamp 14994023 3826702> (DF)
02:51:20.446041 ixodes.goop.org.33708 > ad.tomshardware.com.http: . ack 4294920827 win 6432 <nop,nop,timestamp 3826710 14993505> (DF)
02:51:20.462525 ad.tomshardware.com.http > ixodes.goop.org.33708: . ack 1 win 17376 <nop,nop,timestamp 14994023 3826704> (DF)
02:51:20.462557 ixodes.goop.org.33708 > ad.tomshardware.com.http: . ack 4294920827 win 6432 <nop,nop,timestamp 3826711 14993505> (DF)
02:51:20.475581 ad.tomshardware.com.http > ixodes.goop.org.33708: . ack 1 win 17376 <nop,nop,timestamp 14994023 3826705> (DF)
02:51:20.475611 ixodes.goop.org.33708 > ad.tomshardware.com.http: . ack 4294920827 win 6432 <nop,nop,timestamp 3826713 14993505> (DF)
02:51:20.482239 ad.tomshardware.com.http > ixodes.goop.org.33708: . ack 1 win 17376 <nop,nop,timestamp 14994023 3826706> (DF)
02:51:20.482271 ixodes.goop.org.33708 > ad.tomshardware.com.http: . ack 4294920827 win 6432 <nop,nop,timestamp 3826713 14993505> (DF)
02:51:20.492100 ad.tomshardware.com.http > ixodes.goop.org.33708: . ack 1 win 17376 <nop,nop,timestamp 14994023 3826707> (DF)
[...]

Naturally, this looks bad.  After a while it seemed to stop of its own
accord, I presume when something timed out of LAST_ACK.  While it was
happening, there were two sockets ixising to ad.tomshardware.com:

tcp        1      1 ixodes.goop.org:33674   ad.tomshardware.co:http LAST_ACK    
tcp        1      1 ixodes.goop.org:33708   ad.tomshardware.co:http LAST_ACK    

I'm using 2.4.16 with no particularly special patches.  The gateway
machine is another 2.4.16 box doing NAT with ipchains emulation.

Any other info needed?

	J

