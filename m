Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130195AbQLEKJO>; Tue, 5 Dec 2000 05:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129383AbQLEKJD>; Tue, 5 Dec 2000 05:09:03 -0500
Received: from se1.cogenit.fr ([195.68.53.173]:5137 "EHLO se1.cogenit.fr")
	by vger.kernel.org with ESMTP id <S130195AbQLEKIy>;
	Tue, 5 Dec 2000 05:08:54 -0500
Date: Tue, 5 Dec 2000 10:38:15 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: Ivan Passos <lists@cyclades.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Philip Blundell <philb@gnu.org>, netdev@oss.sgi.com
Subject: Re: [RFC-2] Configuring Synchronous Interfaces in Linux
Message-ID: <20001205103815.A25405@se1.cogenit.fr>
In-Reply-To: <Pine.LNX.4.10.10012042135090.5269-100000@main.cyclades.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <Pine.LNX.4.10.10012042135090.5269-100000@main.cyclades.com>
X-Organisation: Marie's fan club
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Passos <lists@cyclades.com> écrit :
[...]
> Anyhow, the parameters we currently need to configure on our board (the
> PC300) are as follows:
> 
> - Media: V.35, RS-232, X.21, T1, E1

drivers/net/wan/lmc/lmc_media.c:65
char *lmc_t1_cables[] = {
  "V.10/RS423", "EIA530A", "reserved", "X.21", "V.35",
  "EIA449/EIA530/V.36", "V.28/EIA232", "none", NULL
};
(Where it's used btw).
I don't exactly see the point here: do some of your cards supports these
media at the same time ? I would have believed it to be set in stone.

> - Protocol: Frame Relay, (Cisco)-HDLC, PPP, X.25 (not sure whether that is
>             already supported by the 'hw' option)

+ Transparent HDLC ?

> - Clock: 'ext' (or 0, which implies external clock) or some numeric value
>          > 0 (which implies internal clock); setting it to 'int' would set
>          it to some fixed numeric value > 0 (useful for T1/E1 links, just
>          to indicate master clock as opposed to slave or 'ext' clock) 

Ok.

[...]
> - T1/E1 only:
> 	- Line code: 
> 	- Frame mode:
> 	- LBO (T1 only): line-build-out
> 	- Rx Sensitivity: short-haul or long-haul
> 	- Active channels: mask that represents the possible 24/32
>                            channels (timeslots) on a T1/E1 line

May I ask what kind of protocol support you have in mind here ?

> I'm sure that _all_ the other sync cards need to configure the _same_
> parameters (or a subset of them), and there may be cards that need even
> more parameters (but we have to start somewhere ... ;). So having a
> unified interface and making the drivers compliant to it is not that hard
> and surely would help users to dump the currently ridiculous set of
> individual config. tools for these cards (yes, we currently have our own
> pc300cfg, along with the -- not absolute -- "standard" sethdlc utility).
> 
> I'm willing to go for this implementation, but I wanted to know first:
> - whether ifconfig is the right place to do it;

We can pass (media/clock) through his "media" parameter but I won't claim it
to be sexy. So far, I don't see how we may avoid some tool to do all the
required ioctl. 

> - where I should create the new ioctl's to handle these new parameters.

drivers/net/wan/sbni.[ch] uses the SIOCDEVPRIVATE range for different things.
The x25 protocol uses the SIOCPROTOPRIVATE. I'd rather avoid both.

> Suggestions / comments are more than welcome.

-- 
Ueimor
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
