Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274111AbRISRVs>; Wed, 19 Sep 2001 13:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274114AbRISRVi>; Wed, 19 Sep 2001 13:21:38 -0400
Received: from c007-h008.c007.snv.cp.net ([209.228.33.214]:42113 "HELO
	c007.snv.cp.net") by vger.kernel.org with SMTP id <S274111AbRISRV0>;
	Wed, 19 Sep 2001 13:21:26 -0400
X-Sent: 19 Sep 2001 17:21:40 GMT
Message-ID: <3BA8D1E0.BD027FBA@distributopia.com>
Date: Wed, 19 Sep 2001 12:12:00 -0500
From: "Christopher K. St. John" <cks@distributopia.com>
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.0.36 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Dan Kegel <dank@kegel.com>, davidel@xmailserver.org
Subject: Re: [PATCH] /dev/epoll update ...
In-Reply-To: <3BA80108.C830D602@kegel.com> <3BA84367.239FA0B4@distributopia.com> <3BA8BBC9.EA1D0636@kegel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Kegel wrote:
> 
> >  My vote would be to always report the initial state, but
> > that would make the driver more complicated.
> >
> Stevens [UNPV1, in chapter on nonblocking accept] suggests that readiness
> notifications from the OS should only be considered hints, and that user
> programs should behave properly even if the OS feeds it false readiness
> events.
>

 I agree that apps must properly handle incorrect hints, but
there's a difference between:

 A) Signalling readiness when the fd really isn't ready. This
    happens because of the nature of the universe, and isn't
    avoidable (because the state can change after the signal is
    sent but before the signal is received)

 B) Not reliably signalling readiness when the fd is ready.
    This is a bug, because it makes the mechanism 99%
    useless (If you must manually poll all the fd's to make
    sure there hasn't been a lost event, then you haven't
    gained very much)

 Not signalling initial state isn't as bad as (B), because the
app can code around it. But boy it's ugly, and because the
kernel already knows the information, it's 100% fixable in the
driver. (Although I'm not sure how much complexity it would
add to the driver, so I can't comment if the tradeoff it 
worth it)


> Thus one possible approach would be for /dev/epoll (or users of /dev/epoll)
> to assume that an fd is initially ready for all (normal) events, and just
> try handling them all. 
>

 Right, that's the solution mentioned in the BMD paper, and
that's what I've done. But it's (IMHO) ugly and (as you point
out) unexpected. 

 Anybody know what Solaris /dev/poll does? The man page I 
read wasn't clear, and I don't have Solaris box to try it
out on.


-- 
Christopher St. John cks@distributopia.com
DistribuTopia http://www.distributopia.com
