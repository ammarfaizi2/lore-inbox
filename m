Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261496AbTCZGyW>; Wed, 26 Mar 2003 01:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261501AbTCZGyW>; Wed, 26 Mar 2003 01:54:22 -0500
Received: from smtp01.uc3m.es ([163.117.136.121]:23559 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S261496AbTCZGyU>;
	Wed, 26 Mar 2003 01:54:20 -0500
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200303260705.h2Q75Ph03622@oboe.it.uc3m.es>
Subject: Re: [PATCH] ENBD for 2.5.64
In-Reply-To: <20030326064829.GC20244@waste.org> from Matt Mackall at "Mar 26,
 2003 00:48:29 am"
To: Matt Mackall <mpm@selenic.com>
Date: Wed, 26 Mar 2003 08:05:25 +0100 (MET)
Cc: "Peter T. Breuer" <ptb@it.uc3m.es>, Jeff Garzik <jgarzik@pobox.com>,
       Justin Cormack <justin@street-vision.com>,
       linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Matt Mackall wrote:"
> > > Both iSCSI and ENBD currently have issues with pending writes during
> > > network outages. The current I/O layer fails to report failed writes
> > > to fsync and friends.
> > 
> > ENBD has two (configurable) behaviors here. Perhaps it should have
> > more. By default it blocks pending reads and writes during times when
> > the connection is down. It can be configured to error them instead.
> 
> And in this case, the upper layers will silently drop write errors on
> current kernels.
> 
> Cisco's Linux iSCSI driver has a configurable timeout, defaulting to
> 'infinite', btw.

That corresponds to enbd's default behavior.  Sigh. Guess I'll have to
make it 0-infty, instead of 0 or infty. It's easy enough - just need to
make it settable in proc (and think about which is the one line I need
to touch ...).

> Hrrmm. The potential to lose data by surprise here is not terribly
> appealing.

Making the driver "intelligent" is indeed bad news for the more
intelligent admin.  I was thinking of making it default to 0 timeout if
it knows it's running under raid, but I have a natural antipathy to
such in-driver decisions. My conscience would be slightly less on
alert if the userspace daemon did the decision-making. I suppose it
could.

>  It might be better to add an accounting mechanism to say
> "never go above x dirty pages against block device n" or something of
> the sort but you can still get into trouble if you happen to have
> hundreds of iSCSI devices each with their own request queue..

Well, you can get in trouble if you allow even a single dirty page to
be outstanding to something, and have thousands of those somethings.

That's not the normal situation, however, whereas it is normal to
have a single network device and to be writing pell-mell to it
oblivious to the state of the device itself.

Peter
