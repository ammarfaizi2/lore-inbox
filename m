Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319665AbSIMOyo>; Fri, 13 Sep 2002 10:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319666AbSIMOyo>; Fri, 13 Sep 2002 10:54:44 -0400
Received: from pD952AD04.dip.t-dialin.net ([217.82.173.4]:25069 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S319665AbSIMOym>; Fri, 13 Sep 2002 10:54:42 -0400
Date: Fri, 13 Sep 2002 08:59:26 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Daniel Phillips <phillips@arcor.de>
cc: Thunder from the hill <thunder@lightweight.ods.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Roman Zippel <zippel@linux-m68k.org>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Alexander Viro <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Raceless module interface
In-Reply-To: <E17prgo-00089o-00@starship>
Message-ID: <Pine.LNX.4.44.0209130846370.10048-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 13 Sep 2002, Daniel Phillips wrote:
> On Friday 13 September 2002 16:33, Thunder from the hill wrote:
> > Look, first we watch the module initialization, that is, we run the 
> > critical stuff like resource allocation, data structure allocation, etc. 
> > If we fail here, we can't load the module, because it would be unoperative 
> > if we proceed. (Because the data simply isn't there.)

-> if we don't do the starting here, we can operate on the data structures
   earlier, since we know they're running free.

Also could we run start again, even though it sounds buggy.

> > And possibly Rusty wanted to avoid a certain race, which is unrelated to
> > school and kids.

Ouch. I've referred to a comparison here which I've dropped lateron. Sorry 
if you felt insulted.

> please identify the race Rusty avoided and show how I did not avoid the
> same race.

I'm sure Rusty could do that better. However, there might be some weird 
situations. For example, take someone trying to bring all modules down 
the moment we init. We might start running in unchecked environment, and 
there we fail because there is no 'we' any more.

Thus rather module->init(). if (module) module->start(). Since then we can 
be sure that the module is locked, and if somebody unloads it, he'll have 
to wait for the use count to drop.

Or as another example, take someone trying to use the resources we claimed
before the module is really up. If you can rely on the module to be known
to be up, you know what do do. Yes, usually that's no real good example, 
since resources ought to be locked as well.

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-


