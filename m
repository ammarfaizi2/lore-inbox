Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130783AbRBMH27>; Tue, 13 Feb 2001 02:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130789AbRBMH2t>; Tue, 13 Feb 2001 02:28:49 -0500
Received: from smtp4.libero.it ([193.70.192.54]:51391 "EHLO smtp4.libero.it")
	by vger.kernel.org with ESMTP id <S130783AbRBMH2k>;
	Tue, 13 Feb 2001 02:28:40 -0500
Message-ID: <3A88E120.284CCBC2@alsa-project.org>
Date: Tue, 13 Feb 2001 08:24:16 +0100
From: Abramo Bagnara <abramo@alsa-project.org>
Organization: Opera Unica
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19pre6 i586)
X-Accept-Language: it, en
MIME-Version: 1.0
To: Andrew Morton <andrewm@uow.edu.au>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@suse.cz>,
        Tom Eastep <teastep@seattlefirewall.dyndns.org>,
        "Michael B. Trausch" <fd0man@crosswinds.net>,
        Josh Myer <jbm@joshisanerd.com>, linux-kernel@vger.kernel.org
Subject: Re: [OT] Major Clock Drift
In-Reply-To: <20010212113213.B235@bug.ucw.cz> from "Pavel Machek" at Feb 12, 2001 11:32:13 AM <E14SGLm-0006es-00@the-village.bc.nu> <3A87CB3B.B05C03B5@uow.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> Alan Cox wrote:
> >
> > > >                     queued_writes=1;
> > > >                     return;
> > > >             }
> > > >     }
> > >
> > > Unfortunately, that means that if machine crashes in interrupt, it may
> > > "loose" printk message. That is considered bad (tm).
> >
> > The alternative is that the machine clock slides continually and the machine
> > is unusable. This is considered even worse by most people
> 
> Neither.  I was going to dust off my enhanced "bust_spinlocks"
> patch which sets a little flag when we're doing an
> oops, BUG(), panic() or die().  If the flag
> is set, printk() just punches through the lock.

IMO to treat this as an exception it's not the right solution.

A better alternative is to flush one entry of Alan proposed queue on the
following conditions:
- in_interrupt() is true AND queue is full

-- 
Abramo Bagnara                       mailto:abramo@alsa-project.org

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy

ALSA project is            http://www.alsa-project.org
sponsored by SuSE Linux    http://www.suse.com

It sounds good!
