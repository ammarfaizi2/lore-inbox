Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319680AbSIMPKZ>; Fri, 13 Sep 2002 11:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319678AbSIMPKU>; Fri, 13 Sep 2002 11:10:20 -0400
Received: from dsl-213-023-022-092.arcor-ip.net ([213.23.22.92]:15247 "EHLO
	starship") by vger.kernel.org with ESMTP id <S319677AbSIMPKP>;
	Fri, 13 Sep 2002 11:10:15 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Thunder from the hill <thunder@lightweight.ods.org>
Subject: Re: [RFC] Raceless module interface
Date: Fri, 13 Sep 2002 17:17:07 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Thunder from the hill <thunder@lightweight.ods.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Roman Zippel <zippel@linux-m68k.org>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Alexander Viro <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0209130846370.10048-100000@hawkeye.luckynet.adm>
In-Reply-To: <Pine.LNX.4.44.0209130846370.10048-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17psBv-0008AP-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 September 2002 16:59, Thunder from the hill wrote:
> Hi,
> 
> On Fri, 13 Sep 2002, Daniel Phillips wrote:
> > On Friday 13 September 2002 16:33, Thunder from the hill wrote:
> > > Look, first we watch the module initialization, that is, we run the 
> > > critical stuff like resource allocation, data structure allocation, etc. 
> > > If we fail here, we can't load the module, because it would be unoperative 
> > > if we proceed. (Because the data simply isn't there.)
> 
> -> if we don't do the starting here, we can operate on the data structures
>    earlier, since we know they're running free.
> 
> Also could we run start again, even though it sounds buggy.

We can do this without having start separte from init as well.

> > please identify the race Rusty avoided and show how I did not avoid the
> > same race.
> 
> I'm sure Rusty could do that better.

I'd be surprised if Rusty can do it any better than you.  It's hard to
show a race that doesn't exist, even harder to prove that a four-prong
interface is necessary in order to be able to handle it.  The latter is
the question on the table.

> However, there might be some weird 
> situations. For example, take someone trying to bring all modules down 
> the moment we init. We might start running in unchecked environment, and 
> there we fail because there is no 'we' any more.

Oh indeed, there are weird situations, but they apply equally to the
two-prong and the four-prong interfaces.

> Thus rather module->init(). if (module) module->start(). Since then we can 
> be sure that the module is locked, and if somebody unloads it, he'll have 
> to wait for the use count to drop.

This applies equally to the two-prong interface.

> Or as another example, take someone trying to use the resources we claimed
> before the module is really up. If you can rely on the module to be known
> to be up, you know what do do. Yes, usually that's no real good example, 
> since resources ought to be locked as well.

This applies equally to the two-prong interface.  Do you see the pattern
yet?

-- 
Daniel
