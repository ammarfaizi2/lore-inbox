Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262607AbRFBQRd>; Sat, 2 Jun 2001 12:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262609AbRFBQRW>; Sat, 2 Jun 2001 12:17:22 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:19983 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262607AbRFBQRL>; Sat, 2 Jun 2001 12:17:11 -0400
Subject: Re: [PATCH] support for Cobalt Networks (x86 only) systems (for
To: bogdan.costescu@iwr.uni-heidelberg.de (Bogdan Costescu)
Date: Sat, 2 Jun 2001 17:15:02 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), mark@somanetworks.com (Mark Frazer),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        zaitcev@redhat.com (Pete Zaitcev),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        netdev@oss.sgi.com
In-Reply-To: <Pine.LNX.4.33.0106021007290.22222-100000@kenzo.iwr.uni-heidelberg.de> from "Bogdan Costescu" at Jun 02, 2001 10:20:26 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E156E3K-0001sJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > keeps beating it. You don't even need maliciousness for this, synchronization
> > effects and locking on the file will ensure it gets you in the end
> 
> Sure, but as I already wrote, you can detect that something is wrong. Then
> shoot the person!

How does that solve the problem ?

> > fstat() mtime. That seems easy enough
> 
> This only answered the first part of the question: when. How do you pass
> the "how long" info ?
> Does the same applies for the MII ioctl case ?

The mtime tells you exactly that.

> Caching means that the driver (I don't think that it can be done at
> higher levels) has to keep track of accesses to all MII interfaces (yes,
> there can be more than one on a NIC) and all of their registers. One

I disagree. A non priviledged app should not be able to poke around in MII
registers anyway. So you only have to cache the generic state of the link.

> each MII register access. Another solution is to have each register start
> its own cache timer.

You don't need timers.

> OTOH, ioctl rate limiting can be done at higher level and you need only
> one timer per netdevice. So, it's done once and all net drivers benefit
> from it.

You don't need any timers if you are caching. Zilch nada none. You know the
last time a query came in. The mtime lets the app know the last time the value
was modified.

Alan


