Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290634AbSA3Vwb>; Wed, 30 Jan 2002 16:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290635AbSA3VwV>; Wed, 30 Jan 2002 16:52:21 -0500
Received: from chaos.analogic.com ([204.178.40.224]:4486 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S290634AbSA3VwP>; Wed, 30 Jan 2002 16:52:15 -0500
Date: Wed, 30 Jan 2002 16:54:46 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Rob Landley <landley@trommello.org>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: TCP/IP Speed
In-Reply-To: <20020130212344.ZLSQ25963.femail43.sdc1.sfba.home.com@there>
Message-ID: <Pine.LNX.3.95.1020130163406.21490A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2002, Rob Landley wrote:

> On Wednesday 30 January 2002 11:07 am, Richard B. Johnson wrote:
> > When I ping two linux machines on a private link, I get 0.1 ms delay.
> > When I send large TCP/IP stream data between them, I get almost
> > 10 megabytes per second on a 100-base link. Wonderful.
> >
> > However, if I send 64 bytes from one machine and send it back, simple
> > TCP/IP strean connection, it takes 1 millisecond to get it back? There
> > seems to be some artifical delay somewhere.  How do I turn this OFF?
> 
> This is just a guess, but it sounds to me like a scheduling issue.  When 
> you're sending data from one network stack to another, how often the 
> receiving program scoops data out of the incoming file descriptor isn't too 
> much of a limiting factor, as long as you've got enough buffer space in the 
> receiving network stack that the sender doesn't have to pause.
> 
> But to bounce the data back, the program at the far end doing the receive and 
> resend has be woken up and handed a time slice with which to receive, 
> process, and return the packet.
> 
> Have you tried ingo's O(1) scheduler? :)

No. I set all sockets, even the original listen() socket to
TCP_NODELAY. Nothing makes any difference. I tried it on a
600+ MHz machine with and a 133 MHz machine with no aparent
difference in the turn-around time. Of course the 600 MHz
machine sends large buffers of data faster:

   With a 64k buffer:

   600 MHz  133MHz RAM  ~ 9.98 Megabytes/second.
   133 MHz  100MHz RAM  ~ 6.50 Megabytes/second.

   With a 4 k buffer:

   600 MHz  133MHz RAM  ~ 5.15 Megabytes/second.
   133 MHz  100MHz RAM  ~ 3.30 Megabytes/second.

   With 64 bytes:

   600 MHz  133MHz RAM  ~ 1.2 kilobytes/second.
   133 MHz  100MHz RAM  ~ 1.1 kilobytes/second.

   Time from transmission to reception of a small buffer
   from the simplist echo server (read, write, no select):

   600 MHz  133MHz RAM  ~ 0.9 millisecond.
   133 MHz  100MHz RAM  ~ 1.0 millisecond.

   This is with two eepro100 network boards and two
   pairs of machines.

   The turn-around time for small buffers is about
   1 millisecond for both.

   `ping` shows low microseconds in all cases.

   The problem was discovered on an embedded system at
   a customer site so I set up two pairs of machines to
   see what performance is possible. I though first that
   there was a half/full/duplex problem or a hub problem.
   These two pair are connected with a X-over cable, no
   hubs.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


