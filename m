Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291323AbSBGV01>; Thu, 7 Feb 2002 16:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291324AbSBGV0S>; Thu, 7 Feb 2002 16:26:18 -0500
Received: from chaos.analogic.com ([204.178.40.224]:56196 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S291323AbSBGV0K>; Thu, 7 Feb 2002 16:26:10 -0500
Date: Thu, 7 Feb 2002 16:29:05 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: "Perches, Joe" <joe.perches@spirentcom.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Subject: Re: want opinions on possible glitch in 2.4 network error reporti ng
In-Reply-To: <3C62EC67.FCB9958A@nortelnetworks.com>
Message-ID: <Pine.LNX.3.95.1020207160857.12052A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2002, Chris Friesen wrote:

> "Richard B. Johnson" wrote:
> > 
> > On Thu, 7 Feb 2002, Chris Friesen wrote:
> 
[SNIPPED]

> 
> Okay, I buy the fact that sendto can't guarantee that the packet got
> anywhere. 
> Fine.  Now what about sending packets out faster than the output device can
> possibly handle them?  We know the device is busy, it's under our control.  It
> seems to me to be logical to block the sender until the congestion goes
> away, or
> return with an error code if the sender is non-blocking.  This may not
> play nice
> with the current kernel networking code (qdisc and all that) but doesn't
> it seem
> like a good idea in principle?
> 
> Chris
>

Basically it has nothing to do with the current networking code. If
you started from scratch and wrote the 'perfect' networking code you
would soon learn that various links run at different transfer speeds.
If you have a 100 Mb/s link that goes to a router that has a 9600-baud
dial-up connection, the only way you can do flow-control is to throw
away packets. So, you thought a single UDP packet got there --into
a full buffer on the router, trying to send all the M$ Netbeui packets
down the 9600 baud pipe. Guess again! Whatever host sends the most
data to the starved router will get the most packets through and no
host will get them all through. It's just that simple.

Since UDP, by definition isn't acknowledged, your perfect networking
software "thought" that everything was fine because it never got any
errors at all.

Just for information. Do `tcpdump -n` on your machine. Look at all
those packets. Now, how big a buffer would you need to save them all
and send them out a 9600-baud dial-up?  The answer is 'N', which
tends towards infinity, the longer the dial-up persists. So, if
you were routing these, in your perfect network, you would just
throw away the ones that you don't have room for. You can't tell
the sender(s); "Stop Sending!". They won't be listening to you.
They will only be listening to the end-point, and that, only if
the end-point is "connected".

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


