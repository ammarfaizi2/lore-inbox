Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265491AbRGLPOv>; Thu, 12 Jul 2001 11:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265636AbRGLPOl>; Thu, 12 Jul 2001 11:14:41 -0400
Received: from lsmls01.we.mediaone.net ([24.130.1.20]:40628 "EHLO
	lsmls01.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S265491AbRGLPOc>; Thu, 12 Jul 2001 11:14:32 -0400
Message-ID: <3B4DBFDC.91C27FFB@kegel.com>
Date: Thu, 12 Jul 2001 08:18:52 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, x@xman.org
Subject: Re: Improving (network) IO performance ...
In-Reply-To: <XFMail.20010711220804.davidel@xmailserver.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> 
> On 12-Jul-2001 Dan Kegel wrote:
> > Very cool.  Thanks for doing a no-scan implementation of /dev/poll!
> > Two questions:
> >
> > 1) have you compared its performance against Vitaly Luban's
> > signal-per-fd patch?  Even though it's realtime-signal based,
> > there's some hope for it being quite efficient.  See
> > http://www.luban.org/GPL/gpl.html and
> > http://boudicca.tux.org/hypermail/linux-kernel/2001week20/1353.html
> 
> There's more than the event collapsing inside the patch.
> I saw the Luban's work but I decided to use the Lever-Provos /dev/poll as a
> performance meter ( and the old poll() obviously ).
> This coz I read papers where RT signals implementations resulted to have less
> performance when compared to /dev/poll.

It was absolutely great that you benchmarked it relative to the Lever-Provos
/dev/poll, since that made it quite clear yours scaled much better than theirs
to large numbers of idle sockets.  

Perhaps somebody who uses the realtime signal - based readiness notifications
can enhance Davide's benchmark to also cover them (with and without Luban's patch)?
That would help those of us who are trying to decide whether to go with
/dev/poll or realtime signals.

> > 2) A little birdie told me that someone had gotten a freebsd
> > box to handle something like half a million connections.
> > I would like to see you extend the horizontal axis of your graph
> > by a couple orders of magnitude :-)
> 
> Here You can find the new statistics with 16000 connections :
> 
> http://www.xmailserver.org/linux-patches/nio-improve.html
> 
> I cannot reach that number of connections of the test machine coz the socket
> buffer space will eat all my memory ( 128 Mb ).
> Anyway the graph speaks quite clear about the tendency to greater numbers of
> connections.

Yes, in fact, it shows that adding more dead connections actually
improves performance using your patch :-)

Here's what the little birdie told me exactly:
> You'll be happy to know I've achieved over 500,000 connections
> on Pentium hardware with 4G of RAM and 2 1Gbit cards on FreeBSD 4.3.

I think the application was similar to your benchmark configuration;
no idea what the ratio of live to dead connections was.
Let's see: if you have 1/32nd as much RAM as she had, you ought to 
be able to handle 1/32nd as many connections, right?  Since you
hit 16000 connections, I guess you just about did.
- Dan
