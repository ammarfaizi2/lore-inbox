Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267861AbTGWOxJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 10:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270368AbTGWOxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 10:53:09 -0400
Received: from chaos.analogic.com ([204.178.40.224]:23169 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S267861AbTGWOxE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 10:53:04 -0400
Date: Wed, 23 Jul 2003 11:10:08 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Valdis.Kletnieks@vt.edu, jimis@gmx.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Feature proposal (scheduling related)
In-Reply-To: <1058970206.5520.71.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.53.0307231050150.13607@chaos>
References: <3F1E6A25.5030308@gmx.net>  <200307231417.h6NEHoqj010244@turing-police.cc.vt.edu>
 <1058970206.5520.71.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jul 2003, Alan Cox wrote:

> On Mer, 2003-07-23 at 15:17, Valdis.Kletnieks@vt.edu wrote:
> > Basically, you're stuck.  The biggest part of the problem is that although you
> > can certainly control the outbound packets, you have no real control over when
> > inbound packets arrive at the other end of your dial-up.  One person suggested
> > using QoS to help things along - but that needs to be implemented at the OTHER
> > end of the dial-up - which means unless your provider does QoS on the terminal
> > server, you're basically stuck.  Packets will probably just get queued up in
> > order of arrival.
>
> There are a few things that help in the general real world but not
> mathematical sense. Use an ftp client like gnome-ftp which can set the
> rate it accepts data and window sizes. It'll still jam the modem a
> little when it starts a transfer but then it'll generally be ok if you
> have a bit of buffering for your icecast stream.
>

More info. I use a 56k dialup link and PPD to essentially become
my own ISP for my network at home. The machines at home are nodes
on the company's LAN. I have two dedicated machines, one at
work and one at home who's only purpose is to forward IP packets.
These machines are, otherwise, idle.

When I am using ftp to download some work to one of my other
home computers, it is functional impossible to do any useful
work on any other connection. The connections persist, but
no data will get through when a FTP transfer is in progress
except for the FTP data. Somehow the FTP data stream is able
to hog the entire transmission bandwidth. Attempts to "fix" it
be tuning Nagle off, Van Jacobson, etc., all off doesn't do
anything useful.

I have from time-to-time reported as far back as Linux 2.0, the
fact that there are TCP stalls when using PPP. These stalls
still persist with 2.4.20 and I've just had to accept the so-
called "fact" that 1 to 10 second stalls when using PPP are
"normal".

At one time I thought it was just that the modems had lost
sync so I set up a wire-to-wire PPP link here at work. The
stalls still exist when using the RS-232C link with a null-
modem cable. Evidence is that packets are lost, even with
a direct connection. It takes <too much> time for Linux to
discover the missing datagram and have it re-sent. When a
stream of data (FTP) is being sent, nothing seems to get
lost except the ACKs from the receiving end. It seems as
though RS-232C is not full duplex. If something is being
sent, nothing will be received and vice versa.

But... If you write to RS-232C with a test program, with
pins 2,3 shorted (loop-back), you can always read what
you wrote with no errors IFF hardware CRTCTS is turned OFF.

If I enable hardware handshaking, necessary for a modem,
with RTS jumpered to CTS, all bets are off. There are
many missing bytes, even at 9600 baud. However, when
connected through modems, this affect goes away. So,
it seems as though the PPP problem is related to RS-232C
problems, but I'll be damned if I can find it.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.

