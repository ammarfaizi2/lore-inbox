Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <161101-10502>; Sat, 9 Jan 1999 07:22:31 -0500
Received: by vger.rutgers.edu id <154916-3419>; Fri, 8 Jan 1999 19:36:07 -0500
Received: from chaos.analogic.com ([204.178.40.224]:1263 "EHLO chaos.analogic.com" ident: "SOCKWRITE-65") by vger.rutgers.edu with ESMTP id <169179-2781>; Fri, 8 Jan 1999 06:58:01 -0500
Date: Fri, 8 Jan 1999 09:14:14 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Pavel Machek <pavel@atrey.karlin.mff.cuni.cz>
cc: Kurt Garloff <K.Garloff@ping.de>, "B. James Phillippe" <bryan@terran.org>, Linux kernel list <linux-kernel@vger.rutgers.edu>
Subject: Re: [PATCH] HZ change for ix86
In-Reply-To: <19990107140917.23736@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.3.95.990108085724.1428A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

On Thu, 7 Jan 1999, Pavel Machek wrote:

> Hi!
> 
> > > I don't know anything about it (and my box is an Alpha for which HZ is
> > > 1024), but, one ignorant proposal: would it perhaps be worthwhile to have
> > > the HZ value higher for faster (x86) systems based on the target picked in
> > > make config?  Say, your 400 for Pentium+ and 100 for 486 or lower..?
> > 
> > Yes, I think this would be a good idea.
> > No time to code it into the CONFIG files, right now, though ...
> > If Linus tells me: "Hey, do it, it will be integrated then!" I will have
> > time, of course. 
> 
> You should _not_ need to increase HZ. But there've always been obscure
> "feature" in scheduler, and increased HZ work around it.
> 
> 								Pavel

There seems to be a general misinformation about what the HZ value is.
I will "simplicate and add lightness".

If your code does:
		while (1)
                     ;

The CPU gets taken away from you HZ times per second so that other
tasks can use the CPU cycles you are wasting. Under these conditions
it seems like a good idea to make the HZ value as high as possible.

However, if your code is doing:

		UncompressFonts(...........);
                ReadAudioFromDsp(...........);
                ConvolveImageData(..........);
                
	you don't want the CPU taken away until you are done.

For most interactive applications, it has been experimentally determined
that 100 Hz is (about) right because human beings can't detect flicker
above 80 Hz. In other words, getting the CPU stolen 100 times per second
doesn't produce visual effects. The higher the HZ value, the more
often the CPU gets stolen from the interactive user. There are trade-
offs as with most everything.

More is not better. More is just different.

Cheers,
Dick Johnson
                 ***** FILE SYSTEM WAS MODIFIED *****
Penguin : Linux version 2.1.131 on an i686 machine (400.59 BogoMips).
Warning : It's hard to remain at the trailing edge of technology.
Wisdom  : It's not a Y2K problem. It's a Y2Day problem.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
