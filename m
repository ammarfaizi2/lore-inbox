Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129170AbRBVBvG>; Wed, 21 Feb 2001 20:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129243AbRBVBu5>; Wed, 21 Feb 2001 20:50:57 -0500
Received: from palrel3.hp.com ([156.153.255.226]:9992 "HELO palrel3.hp.com")
	by vger.kernel.org with SMTP id <S129170AbRBVBuu>;
	Wed, 21 Feb 2001 20:50:50 -0500
Message-ID: <3A947078.81A0F86D@cup.hp.com>
Date: Wed, 21 Feb 2001 17:50:48 -0800
From: Rick Jones <raj@cup.hp.com>
Organization: the Unofficial HP
X-Mailer: Mozilla 4.75 [en] (X11; U; HP-UX B.11.00 9000/785)
X-Accept-Language: en
MIME-Version: 1.0
To: Nye Liu <nyet@curtis.curtisfong.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Very high bandwith packet based interface and performance problems
In-Reply-To: <20010221140055.A8113@curtis.curtisfong.org> <E14VhQ7-0002s0-00@the-village.bc.nu> <20010221172431.A10657@curtis.curtisfong.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > This is NOT what I'm seeing at all.. the kernel load appears to be
> > > pegged at 100% (or very close to it), the user space app is getting
> > > enough cpu time to read out about 10-20Mbit, and FURTHERMORE the kernel
> > > appears to be ACKING ALL the traffic, which I don't understand at all
> > > (e.g. the transmitter is simply blasting 300MBit of tcp unrestricted)
> >
> > TCP _requires_ the remote end ack every 2nd frame regardless of progress.
> 
> YIPES. I didn't realize this was the case.. how is end-to-end application
> flow control handled when the bottle neck is user space bound and not b/w
> bound? e.g. if i write a test app that does a

If the app is not reading from the socket buffer, the receiving TCP is
supposed to stop sending window-updates, and the sender is supposed to
stop sending data when it runs-out of window.

If TCP ACK's data, it really should (must?) not then later drop it on
the floor without aborting the connection. If a TCP is ACKing data and
then that data is dropped before it is given to the application, and the
connection is not being reset, that is probably a bug.

A TCP _is_ free to drop data prior to sending an ACK - it simply drops
it and does not ACK it.

rick jones

-- 
ftp://ftp.cup.hp.com/dist/networking/misc/rachel/
these opinions are mine, all mine; HP might not want them anyway... :)
feel free to email, OR post, but please do NOT do BOTH...
my email address is raj in the cup.hp.com domain...
