Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317267AbSGIABQ>; Mon, 8 Jul 2002 20:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317269AbSGIABP>; Mon, 8 Jul 2002 20:01:15 -0400
Received: from OL65-148.fibertel.com.ar ([24.232.148.65]:44474 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S317267AbSGIABO>;
	Mon, 8 Jul 2002 20:01:14 -0400
Date: Mon, 8 Jul 2002 21:07:13 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Bill Davidsen <davidsen@tmr.com>, Keith Owens <kaos@ocs.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [OKS] Module removal
Message-ID: <20020708210713.R2295@almesberger.net>
References: <20020707220933.B11999@kushida.apsleyroad.org> <Pine.LNX.3.96.1020707201054.19682A-100000@gatekeeper.tmr.com> <20020708014626.B13387@kushida.apsleyroad.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020708014626.B13387@kushida.apsleyroad.org>; from lk@tantalophile.demon.co.uk on Mon, Jul 08, 2002 at 01:46:26AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> The more I think about it, the more I think the `owner' thing in
> file_operations et al. is the right thing in all cases,

What troubles me most in this discussion is that nobody seems to
think of how these issues affect non-modules.

Entry-after-removal is an anomaly in the subsystem making that call.
Fixing it for modules is fine as long as only modules will ever
un-register, but what do you do if non-module code ever wants to
un-register too ? (E.g. think hot-plugging or software devices.)

Invent some pseudo-module framework for it ? Require all code using
that subsystem to be a module ? What happens if there are multiple
registrations per chunk of code ?

Besides, a common pattern for those "hold this down, kick that, then
slowly count to ten, and now it's safe to release" solutions seems
to be that it takes roughly ten times as long to find the race
condition buried deep within them, than it took for the respective
predecessor.

I'm not sure the incremental band aid approach works in this case.

I'm sorry that I don't have to offer anything more constructive at
the moment, but I first want to build some testing framework. One
oops says more than ten pages of analysis explaining a race
condition :-)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://icapeople.epfl.ch/almesber/_____________________________________/
