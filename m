Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266286AbTBPKvo>; Sun, 16 Feb 2003 05:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266296AbTBPKvn>; Sun, 16 Feb 2003 05:51:43 -0500
Received: from mail3.bluewin.ch ([195.186.1.75]:7145 "EHLO mail3.bluewin.ch")
	by vger.kernel.org with ESMTP id <S266286AbTBPKvm>;
	Sun, 16 Feb 2003 05:51:42 -0500
Date: Sun, 16 Feb 2003 12:01:17 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
Subject: Re: [0/4][via-rhine] Improvements
Message-ID: <20030216110117.GA2821@k3.hellgate.ch>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
References: <20030215225204.GA6887@k3.hellgate.ch> <Pine.LNX.4.44.0302151611310.23496-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302151611310.23496-100000@home.transmeta.com>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.5.61 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, 15 Feb 2003, Roger Luethi wrote:
> > 
> > Thanks for raising that issue. It is my understanding that PIO ops are
> > synchronous (on IA-32). If that is correct, problems should only occur if
> > the driver is built with MMIO support, no?
> 
> No, even PIO ops are asynchronous. They are _more_ synchronous than the
> MMIO ones (I think the CPU waits until they hit the bus, and most bridges

Hmmm... A recent thread on PCI write posting seemed to confirm my view [1].
What am I missing here?

------------------------------ cut here -----------------------------------
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.4.21-pre3-ac4
Date: 12 Jan 2003 20:40:54 +0000

On Sun, 2003-01-12 at 19:51, Benjamin Herrenschmidt wrote:
> What about PCI write posting ? How can we enforce the 400ns delay here ?

For i/o space it is ok as in*/out* are synchronous. For mmio right now I
don't know. I need to talk to Andre about that for SATA. I guess for the
PPC its going to be fun

[...]
------------------------------ cut here -----------------------------------

> don't need a IO read to force it out. But considering the wide variety of 
> PCI bridges out there I bet there are some that will post even PIO writes 
> and might hold on to them for some time, especially if other activity like 
> DMA keeps the bus busy.

There was some talking about hwif->IOSYNC() (for IDE). That might be
interesting for other devices, too. It could resolve to a nop for
synchronous operations, and say a read* for MMIO. IMHO it shouldn't be up
to a driver maintainer to figure out what sync op some arch the driver may
run on needs. What a maintainer typically _can_ provide is type of
operation (MMIO/PIO) and a register that is considered safe for a sync
read.

Roger

[1] http://marc.theaimsgroup.com/?l=linux-kernel&m=104240180906935&w=4
