Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129776AbQLaP65>; Sun, 31 Dec 2000 10:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129870AbQLaP6r>; Sun, 31 Dec 2000 10:58:47 -0500
Received: from mailframe.cabinet.net ([213.169.1.9]:48140 "HELO
	mailframe.cabinet.net") by vger.kernel.org with SMTP
	id <S129776AbQLaP6d>; Sun, 31 Dec 2000 10:58:33 -0500
Date: Sun, 31 Dec 2000 17:28:05 +0200 (EET)
From: Jussi Hamalainen <count@theblah.org>
To: <linux-kernel@vger.kernel.org>
Subject: Re: path MTU bug still there?
In-Reply-To: <Pine.LNX.4.30.0012311409390.14553-100000@uplift.swm.pp.se>
Message-ID: <Pine.LNX.4.30.0012311601410.9994-100000@shodan.irccrew.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Dec 2000, Mikael Abrahamsson wrote:

> When the linux box does TCP to the outside it'll use the MTU of
> the tunnel (default route is the tunnel) and thus works perfectly
> (since TCP MSS will be set low enough to fit into the tunnel).

In my case I can't access a problematic host even from the router
box.

> Could it be some kind of incompability at the tunnel level that
> make you unable to receive large packets over the tunnel?

Could be. The internet connection is a 64k ISDN link.

> Have you tcpdump:ed to see if the tunnel packets actually make it
> the way they should?

I can't snoop the actual tunnel device, because tcpdump and sniffit
give me an unknown media type error. Here's a tcpdump from the router
box's ethernet device of a HTTP session (using lynx) to
www.doomworld.com:

17:19:46.126297 xxx.xxx.xxx.xxx.1029 > 206.96.221.6.80: S 2549095564:2549095564(0) win 32120 <mss 1460,sackOK,timestamp 649398[|tcp]> (DF)
17:19:46.386142 206.96.221.6.80 > xxx.xxx.xxx.xxx.1029: S 1631828281:1631828281(0) ack 2549095565 win 30660 <mss 1460,sackOK,timestamp 91687185[|tcp]> (DF)
17:19:46.386142 206.96.221.6.80 > xxx.xxx.xxx.xxx.1029: S 1631828281:1631828281(0) ack 2549095565 win 30660 <mss 1460,sackOK,timestamp 91687185[|tcp]> (DF)
17:19:46.386142 xxx.xxx.xxx.xxx.1029 > 206.96.221.6.80: . ack 1 win 32120 <nop,nop,timestamp 649423 91687185> (DF)
17:19:46.386142 xxx.xxx.xxx.xxx.1029 > 206.96.221.6.80: P 1:369(368) ack 1 win 32120 <nop,nop,timestamp 649423 91687185> (DF)
17:19:46.685963 206.96.221.6.80 > xxx.xxx.xxx.xxx.1029: . ack 369 win 30660 <nop,nop,timestamp 91687216 649423> (DF)
17:19:46.685963 206.96.221.6.80 > xxx.xxx.xxx.xxx.1029: . ack 369 win 30660 <nop,nop,timestamp 91687216 649423> (DF)

And the connection locks up. This happens every time. I don't have
access to the Cisco so I can't dump traffic on the remote end of
my tunnel.

-- 
-=[ Count Zero / TBH - Jussi Hämäläinen - email count@theblah.org ]=-

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
