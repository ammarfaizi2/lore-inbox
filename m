Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262242AbRFBIUu>; Sat, 2 Jun 2001 04:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262288AbRFBIUk>; Sat, 2 Jun 2001 04:20:40 -0400
Received: from mail.iwr.uni-heidelberg.de ([129.206.104.30]:16840 "EHLO
	mail.iwr.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S262242AbRFBIUa>; Sat, 2 Jun 2001 04:20:30 -0400
Date: Sat, 2 Jun 2001 10:20:26 +0200 (CEST)
From: Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Mark Frazer <mark@somanetworks.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Pete Zaitcev <zaitcev@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <netdev@oss.sgi.com>
Subject: Re: [PATCH] support for Cobalt Networks (x86 only) systems (for
In-Reply-To: <E155srs-0000nu-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0106021007290.22222-100000@kenzo.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Jun 2001, Alan Cox wrote:

> No the application gets back no data, ever, because a third party application
> keeps beating it. You don't even need maliciousness for this, synchronization
> effects and locking on the file will ensure it gets you in the end

Sure, but as I already wrote, you can detect that something is wrong. Then
shoot the person!

> > With caching, you'd have to let the application know when the cached
> > value was last read and how long it will be cached for.  With rate
>
> fstat() mtime. That seems easy enough

This only answered the first part of the question: when. How do you pass
the "how long" info ?
Does the same applies for the MII ioctl case ?

Now let's talk about implementation issues. For the MII case, you have
several registers that have to be read. The way it generally done is for
the ioctl to pass MII address and register number and receive back the
value.

Caching means that the driver (I don't think that it can be done at
higher levels) has to keep track of accesses to all MII interfaces (yes,
there can be more than one on a NIC) and all of their registers. One
solution is to read all registers at once and start the cache timer for
each MII register access. Another solution is to have each register start
its own cache timer.

OTOH, ioctl rate limiting can be done at higher level and you need only
one timer per netdevice. So, it's done once and all net drivers benefit
from it.

Guess which one I prefer...

-- 
Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De

