Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751021AbVJXNiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbVJXNiV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 09:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751022AbVJXNiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 09:38:21 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:18930 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751014AbVJXNiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 09:38:21 -0400
Subject: Re: select() for delay.
From: Steven Rostedt <rostedt@goodmis.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: madhu.subbaiah@wipro.com, linux-kernel@vger.kernel.org
In-Reply-To: <1130160451.2775.8.camel@laptopd505.fenrus.org>
References: <EE111F112BBFF24FB11DB557FA2E5BF301992F02@BLR-EC-MBX02.wipro.com>
	 <1130159934.7804.15.camel@localhost.localdomain>
	 <1130160451.2775.8.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 24 Oct 2005 09:37:52 -0400
Message-Id: <1130161072.7804.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-24 at 15:27 +0200, Arjan van de Ven wrote:
> On Mon, 2005-10-24 at 09:18 -0400, Steven Rostedt wrote:
> > Hi Maduhu,
> > 
> > On Mon, 2005-10-24 at 16:25 +0530, madhu.subbaiah@wipro.com wrote:
> > 
> > > +                        put_user(sec, &tvp->tv_sec);
> > > +                        put_user(usec, &tvp->tv_usec);
> > 
> > I won't comment on the rest of the patch, but this part is definitely
> > wrong.  The pointer tvp is a user space address and once you dereference
> > that pointer to get to tv_sec, you can have a fault, which might
> > segfault the
> 
> &pointer->member  doesn't dereference the pointer, it just adds the
> offset of "member" to the content of the pointer.
> 

Oh crap! You're right ;-)

Argh, that's what I get for replying before my first cup of coffee and
suffering jet lag.

I should have known this since I just copied over the container_of macro
to a user process, and if what I said was true, ((type *)0)->member
would never work.

Oh well, time to wake up :-)

-- Steve




