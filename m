Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289820AbSAWME6>; Wed, 23 Jan 2002 07:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289815AbSAWMEs>; Wed, 23 Jan 2002 07:04:48 -0500
Received: from fungus.teststation.com ([212.32.186.211]:1552 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S289820AbSAWMEf>; Wed, 23 Jan 2002 07:04:35 -0500
Date: Wed, 23 Jan 2002 13:04:26 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.teststation.com>
To: Martin Eriksson <nitrax@giron.wox.org>
cc: Justin A <justin@bouncybouncy.net>, Andy Carlson <naclos@swbell.net>,
        <linux-kernel@vger.kernel.org>,
        Stephan von Krawczynski <skraw@ithnet.com>
Subject: Re: via-rhine timeouts
In-Reply-To: <004101c1a3f9$dea1bb90$0201a8c0@HOMER>
Message-ID: <Pine.LNX.4.33.0201231255180.6354-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2002, Martin Eriksson wrote:

> >
> > I transfered a 100M file to someone here via http at 1.1MB/s(according
> > to IE, which is usually wrong but still)
> >
> > Seems to be working great now
> > thanks:)
> >
> > I wonder if that driver was included on one of those cd's that came with
> > the board, I never thought to look:)
> >
> > -Justin
> 
> This is extremely interesting! I didn't even know about that page. As I have
> a fondness for the via-rhine driver (I have too much of the DFE-530TX cards
> at home) I'll start to reverse-engineer ASAP =)

It's not much to reverse engineer, it comes in source form.

It's based on Donald Beckers via-rhine, they have added code for some
hardware issues(?) and removed some copyright texts. Some of the
workarounds have already been added to the kernel driver (I have seen a
similar version of this driver before).

I believe the reason that driver works better is that they use a larger
starting value for the TX threshold.

    writeb(readb(ioaddr + TxConfig) | 0x80, ioaddr + TxConfig);
    np->tx_thresh = 0x20;
(linuxfet.c)

        writeb(0x20, ioaddr + TxConfig);
        np->tx_thresh = 0x20;
(via-rhine.c)

Note how the linuxfet driver sets a higher value but does not make the
tx_thresh follow, so if it later gets a "IntrTxUnderrun" it will lower the
threshold. But the chosen value is probably large enough.

Those of you with this problem could try changing the 0x80 to 0x20 in the
linuxfet.c driver and see if the problem returns (or the other way around
in the via-rhine.c driver).

/Urban

