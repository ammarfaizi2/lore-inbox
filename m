Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129807AbQLETsp>; Tue, 5 Dec 2000 14:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129410AbQLETsg>; Tue, 5 Dec 2000 14:48:36 -0500
Received: from main.cyclades.com ([209.128.87.2]:42761 "EHLO cyclades.com")
	by vger.kernel.org with ESMTP id <S129807AbQLETsY> convert rfc822-to-8bit;
	Tue, 5 Dec 2000 14:48:24 -0500
Date: Tue, 5 Dec 2000 11:17:57 -0800 (PST)
From: Ivan Passos <lists@cyclades.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
cc: netdev@oss.sgi.com
Subject: Re: [RFC-2] Configuring Synchronous Interfaces in Linux
In-Reply-To: <20001205103815.A25405@se1.cogenit.fr>
Message-ID: <Pine.LNX.4.10.10012051110360.1713-100000@main.cyclades.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 5 Dec 2000, Francois Romieu wrote:

> Ivan Passos <lists@cyclades.com> écrit :
> > 
> > - Media: V.35, RS-232, X.21, T1, E1
> 
> I don't exactly see the point here: do some of your cards supports these
> media at the same time ? I would have believed it to be set in stone.

Yes. The PC300/RSV supports RS-232 and V.35, software selectable. The
PC300/TE supports T1 and E1, also software selectable.

> > - Protocol: Frame Relay, (Cisco)-HDLC, PPP, X.25 (not sure whether that is
> >             already supported by the 'hw' option)
> 
> + Transparent HDLC ?

As I said, for sure there will be parameters left out, but this would be
my _initial_ set of parameters. Subsequent patches would add more and more
parameters.

> > - T1/E1 only:
> > 	- Line code: 
> > 	- Frame mode:
> > 	- LBO (T1 only): line-build-out
> > 	- Rx Sensitivity: short-haul or long-haul
> > 	- Active channels: mask that represents the possible 24/32
> >                            channels (timeslots) on a T1/E1 line
> 
> May I ask what kind of protocol support you have in mind here ?

Same protocols as before: Frame Relay, X.25, PPP, HDLC ... Did I
misunderstood your question??

> We can pass (media/clock) through his "media" parameter but I won't claim it
> to be sexy. So far, I don't see how we may avoid some tool to do all the
> required ioctl. 

The point is not to prevent the tool from doing ioctl's, is having _one
single_ tool that generates _the same_ ioctl to all sync drivers. That
would mean that a user wouldn't care if his sync card is from X, Y or Z
manufacturer, the command syntax to set a specific link configuration
would be the same for all of them. How to translate this standard command
to the hardware, that's a device driver problem (no news here).

> > - where I should create the new ioctl's to handle these new parameters.
> 
> drivers/net/wan/sbni.[ch] uses the SIOCDEVPRIVATE range for different things.
> The x25 protocol uses the SIOCPROTOPRIVATE. I'd rather avoid both.

That's what everybody does currently, but each driver uses their _own_ set
of ioctl's. Having one unified set of ioctl's for all drivers would ease
the user's life a lot.

Later,
Ivan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
