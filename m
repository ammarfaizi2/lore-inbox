Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130383AbRAWR6E>; Tue, 23 Jan 2001 12:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129776AbRAWR5y>; Tue, 23 Jan 2001 12:57:54 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:5896 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S129752AbRAWR5t>;
	Tue, 23 Jan 2001 12:57:49 -0500
Message-ID: <3A6DC619.64019749@mandrakesoft.com>
Date: Tue, 23 Jan 2001 12:57:45 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Ford <david@linux.com>
CC: LKML <linux-kernel@vger.kernel.org>,
        Matti Aarnio <matti.aarnio@zmailer.org>
Subject: Re: NETDEV timeout on tulips [was: Re: 2.4.1-test10]
In-Reply-To: <Pine.LNX.4.10.10101221711560.1309-100000@penguin.transmeta.com> <3A6CF5B7.57DEDA11@linux.com> <3A6D2D54.619AFA7E@mandrakesoft.com> <3A6D616F.63EB34A6@linux.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ford wrote:
> 
> > > Do the tulip driver updates address the increasingly common NETDEV timeout
> > > repots?
> >
> > In general you can answer this yourself by reading
> > drivers/net/tulip/ChangeLog.
> >
> > I don't see increasingly common timeout reports.. with which hardware?
> > They are likely on the newer LinkSys 4.1 cards, and there are still
> > problesm with PNIC.  Outside of that, other cards should be ok.
> 
> I have four machines now that exhibit this problem.  Three have in them the
> Linksys card family, similar PCI cards, one is my laptop which I have three
> different cardbus cards but they all use the tulip driver.
> 
> In the PCI situation, not all machines using these cards act the same way.
> I got a 10 pack of LNE100TX cards and so far only two out of the batch are doing
> this, they are all the same revision, identical in every way that I've found.
> 
> The three cardbus cards are slightly different in numerous ways.  For them they
> normally fault with an APM event, an eject/insert cycle via software will reset
> them and a link down/up won't fix it.  For the PCI cards most times a link
> down/up cycle will fix them.  It's a 2.4 v.s. 2.2 issue, the 2.2 kernels aren't
> exhibiting this error.

Sounds like the PCI PM state is getting mangled.  Can you provide a
"lspci -vvv", as root, for each of the three cardbus cards?  Make sure
to run lspci when the cards are up and active and working.


> The PCI cards are hard to get into this state, sometimes they'll run millions of
> packets for months on end before they'll burp.  Sometimes it'll happen three
> times a night.  The amount of traffic doesn't seem to matter, nor does the type
> of traffic.
> 

> 00:0a.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
>         Subsystem: Netgear FA310TX

If the link is getting lost (which may explain the randomness of the
error), the following patch might help: 
http://sourceforge.net/patch/?func=detailpatch&patch_id=103294&group_id=13004

There are still some media fixes that need to be integrated from the
Becker driver, and tested, too.

Also, downloading tulip-diag.c and capturing the register state before
and after the breakage is useful.  A useful command line is "tulip-diag
-mmmaaavvveef".

	Jeff


-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
