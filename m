Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbVDDVxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbVDDVxQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 17:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbVDDVvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 17:51:33 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:49100 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261373AbVDDVtl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 17:49:41 -0400
Date: Mon, 4 Apr 2005 14:49:50 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] kernel/rcupdate.c: make the exports EXPORT_SYMBOL_GPL
Message-ID: <20050404214950.GG1297@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050327143454.GJ4285@stusta.de> <20050403060200.GA1332@us.ibm.com> <1112602705.6270.33.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112602705.6270.33.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2005 at 10:18:24AM +0200, Arjan van de Ven wrote:
> On Sat, 2005-04-02 at 22:02 -0800, Paul E. McKenney wrote:
> 
> > These need to be put back.  Moving them to GPL -- but in a measured
> > manner, as I proposed on this list some months ago -- is fine.  Changing
> > these particular exports precipitously is most definitely -not- fine.
> > Here is my earlier proposal:
> 
> ok so there is no disagreement that these should become _GPL eventually,
> only about the "when".

Agreed.  I would indeed look pretty silly arguing that they should -never-
go _GPL, since I proposed moving in that direction some months ago.  ;-)

>                        There is agreement also about the expectation
> that currently no binary module is using these.

Agreed, in that I know of no binary module that uses RCU.  However,
I cannot -prove- that there is no such module.

>                                                 Personally I would then
> suggest removing them right now (as is done in -bk); the longer you wait
> the higher the chance of anyone out there starting to use them and
> giving/having a problem a year from now, while the current "damage" is
> expected to be zero.

If someone starts using the exports in a binary module given the warnings
("/* WARNING: GPL-only in April 2006. */"), they have done so with the
knowledge that they will need to change.  Therefore, any future "damage"
would be self-inflicted.  Even if they failed to notice the warnings,
IBM would have made a reasonable and conscientious effort to inform them.
In contrast, if the exports change suddenly now, then the (unlikely, but
still possible) "damage" could be argued to be inflicted, indirectly,
by IBM.  I would (and do) vehemently disagree with such an argument,
but my opinion might not count for much.  IANAL, after all.

And of course, these exports are a special case due to the well-known
presence of the RCU patents.

This line of reasoning might seem a bit strange (it certainly did to me at
first!), but I eventually had to admit that it is quite a bit less strange
than some things that have actually happened over the past few years.  :-/

Finally, please note that this is not a "Mr. Binary-Module, you have
a year to complain and maybe change my mind" type of notification.
This is instead a "this change -will- happen, but I am doing you
the courtesy of giving you advance notice of an upcoming change in an
implicit patent license" type of notification.  From the patch:

+       So these will move to GPL after a grace period to allow
+       people, who might be using implementations that I am not aware
+       of, to adjust to this upcoming change.

Fair enough?

							Thanx, Paul
