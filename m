Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272582AbRIGMGs>; Fri, 7 Sep 2001 08:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272614AbRIGMGi>; Fri, 7 Sep 2001 08:06:38 -0400
Received: from nbd.it.uc3m.es ([163.117.139.192]:9732 "EHLO nbd.it.uc3m.es")
	by vger.kernel.org with ESMTP id <S272582AbRIGMGW>;
	Fri, 7 Sep 2001 08:06:22 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200109071206.OAA24577@nbd.it.uc3m.es>
Subject: Re: 2.4.8 NFS Problems
X-ELM-OSV: (Our standard violations) hdr-charset=US-ASCII
In-Reply-To: <shsae07md9d.fsf@charged.uio.no> "from Trond Myklebust at Sep 7,
 2001 01:49:50 pm"
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: Fri, 7 Sep 2001 14:05:10 +0200 (CEST)
CC: Mike Black <mblack@csihq.com>, linux-kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL89 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Trond Myklebust wrote:"
> >>>>> " " == Mike Black <mblack@csihq.com> writes:
> 
>      > I've been getting random NFS EIO errors for a few months but
>      > now it's repeatable.  Trying to copy a large file from one
>      > 2.4.8 SMP box to another is consistently failing (at different
>      > offsets each time).  This doesn't appear to be a network
>      > problem as the last comm between the machines looks OK.  By the
>      > timestamps it appears that a read() is taking too long and
>      > causing a timeout?
> 
> Morale: Don't use soft mounts: they are prone to these things. If you
> insist on using them, then try playing around with the `timeo' and

Unless you like having all your clients hang when the server happens to
be rebooted, and like having to go round hunting for them in dark
recesses in order to try and fool them into unmounting and remounting,
I'd recommend soft mounts every time!

> `retrans' mount variables.

It would be nice if nfs could do the a remount automatically when the
nfs handle it has goes stale an dit discovers it.  Is that part of v3
nfs or not?

> Soft mount timeouts are not only due to network problems, but can
> equally well be due to internal congestion. The rate at which the
> network can transmit requests is usually (unless you are using
> Gigabit) way below the rate at which your machine can generate them.

But soft mounts at least break nicely and automatically.  And since
failures are inevitable, I prefer them.

Come to think of it, why not have an option that does a hard,intr but
sends a ^C automatically to all referents when a stale handle is detected.

Peter
