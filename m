Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277905AbRJ1Jce>; Sun, 28 Oct 2001 04:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277949AbRJ1JcZ>; Sun, 28 Oct 2001 04:32:25 -0500
Received: from fungus.teststation.com ([212.32.186.211]:43018 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S277905AbRJ1JcM>; Sun, 28 Oct 2001 04:32:12 -0500
Date: Sun, 28 Oct 2001 10:32:46 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
To: Hans-Joachim Baader <hjb@pro-linux.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.14-3 via-rhine lockup
In-Reply-To: <20011027225007.A718@mandel.hjb.de>
Message-ID: <Pine.LNX.4.30.0110280950380.12850-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Oct 2001, Hans-Joachim Baader wrote:

> on heavy load the via-rhine driver locks up. Even reloading the module
> doesn't help, only reboot cures the problem.

How do you generate the heavy load? (what is heavy)

What hardware do you have? via-rhine chip model? (dmesg/lspci -n)


> I've set the debug variable in via-rhine.c to 7 and loaded the module
> without options. In the kernel log I see:
> 
> via_rhine_rx() status is 00409700.

0040 - received packet length
9700 - 1001 0111 0000 0000 = RXOK, BAR, CHN, STP, EDP

RXOK = Received ok
BAR = Broadcast packet
CHN = Chain buffer
STP&EDP = Single buffer descriptor

Or in other words, it sucessfully received a 64 byte broadcast packet.

With debug=7, surely you get lots of other messages too ... ?


> It still does interrupts and queues packets to send, but it either doesn't
> send them or doesn't receive anything.

If it is generating interrupts the driver and network code will not detect
anything strange. There is a timer that detects transmit attempts that do
not complete, but a transmit interrupt will clear that.

Donald Becker has a diagnostics tool at
    ftp://ftp.scyld.com/pub/diag/via-diag.c
Comparing the output of 'via-diag -aaeemm' (or something) when working and
when not working could be helpful.

After it stops working, do you still get log messages from it?
Including via_rhine_rx()?

/Urban

