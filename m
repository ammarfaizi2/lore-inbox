Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316580AbSGGVWT>; Sun, 7 Jul 2002 17:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316582AbSGGVWS>; Sun, 7 Jul 2002 17:22:18 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:14565 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S316580AbSGGVWR>; Sun, 7 Jul 2002 17:22:17 -0400
Date: Sun, 7 Jul 2002 22:24:25 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Thunder from the hill <thunder@ngforever.de>
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
       M?ns Rullg?rd <mru@users.sourceforge.net>,
       Mohamed Ghouse Gurgaon <MohamedG@ggn.hcltech.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Diff b/w 32bit & 64-bit
Message-ID: <20020707222425.A12535@kushida.apsleyroad.org>
References: <20020707191232.A11999@kushida.apsleyroad.org> <Pine.LNX.4.44.0207071338570.10105-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0207071338570.10105-100000@hawkeye.luckynet.adm>; from thunder@ngforever.de on Sun, Jul 07, 2002 at 01:41:35PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thunder from the hill wrote:
> > > don't cast from "foo *" to "bar *" if sizeof(foo)<sizeof(bar)
> > 
> > What is the reason for this?  I do it quite routinely ("poor man's
> > inheritance").
> 
> This should only be OK if you pad bar before.

Erm, crossed wire :-)

I do it for inheritance in the same way as, say, Xlib with X events.
That's perfectly safe and commonplace.

I didn't understand Albert's reason for prohibiting the mere cast.
(Notions of old machines where the char * representation is different
from int * came to mind, but Linux doesn't run on those... does it?)

Oliver Neukum explained that you shouldn't dereference a pointer to a
larger type because of alignment issues on some machines.
sizeof(foo)<sizeof(bar) captures this rule just fine for the basic data
types (char, int etc.).

But for structures, it's actually possible to have a smaller type with a
larger alignment requirement, and vice versa:

     struct small { double x; };
     struct large { char y [11]; };

Also, it is certainly permitted to cast "char *" to "int *" if you know
that the underlying object is an "int" or something compatible with one.

So, the general rule `don't cast from "foo *" to "bar *" if
sizeof(foo)<sizeof(bar)' is wrong, and is routinely not followed.

An alternative rule might be `never dereference a "bar *" if it might
not have the correct alignment for "bar" on any platform'.

-- Jamie
