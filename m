Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262519AbVDGR3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262519AbVDGR3m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 13:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262522AbVDGR3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 13:29:42 -0400
Received: from fire.osdl.org ([65.172.181.4]:40921 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262519AbVDGR3f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 13:29:35 -0400
Date: Thu, 7 Apr 2005 10:29:25 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: linux-os@analogic.com
Cc: magnus.damm@gmail.com, roland@topspin.com, asterixthegaul@gmail.com,
       damm@opensource.se, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] disable built-in modules V2
Message-Id: <20050407102925.2ab27740.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0504071319430.5977@chaos.analogic.com>
References: <20050405225747.15125.8087.59570@clementine.local>
	<54b5dbf505040618324186678a@mail.gmail.com>
	<528y3v72al.fsf@topspin.com>
	<aec7e5c305040701236289aacd@mail.gmail.com>
	<20050407100147.7b91a2d2.rddunlap@osdl.org>
	<Pine.LNX.4.61.0504071319430.5977@chaos.analogic.com>
Organization: OSDL
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: SvC&!/v_Hr`MvpQ*|}uez16KH[#EmO2Tn~(r-y+&Jb}?Zhn}c:Eee&zq`cMb_[5`tT(22ms
 (.P84,bq_GBdk@Kgplnrbj;Y`9IF`Q4;Iys|#3\?*[:ixU(UR.7qJT665DxUP%K}kC0j5,UI+"y-Sw
 mn?l6JGvyI^f~2sSJ8vd7s[/CDY]apD`a;s1Wf)K[,.|-yOLmBl0<axLBACB5o^ZAs#&m?e""k/2vP
 E#eG?=1oJ6}suhI%5o#svQ(LvGa=r
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Apr 2005 13:22:57 -0400 (EDT) Richard B. Johnson wrote:

| On Thu, 7 Apr 2005, Randy.Dunlap wrote:
| 
| > On Thu, 7 Apr 2005 10:23:32 +0200 Magnus Damm wrote:
| >
| > | On Apr 7, 2005 4:23 AM, Roland Dreier <roland@topspin.com> wrote:
| > | >  > > -#define module_init(x) __initcall(x);
| > | >  > > +#define module_init(x) __initcall(x); __module_init_disable(x);
| > | >  >
| > | >  > It would be better if there is brackets around them... like
| > | >  >
| > | >  > #define module_init(x) { __initcall(x); __module_init_disable(x); }
| > | >  >
| > | >  > then we know it wont break some code like
| > | >  >
| > | >  > if (..)
| > | >  >  module_init(x);
| > | >
| > | > This is all completely academic, since module_init() is a declaration
| > | > that won't be inside any code, but in general it's better still to use
| > | > the do { } while (0) idiom like
| > | >
| > | > #define module_init(x) do { __initcall(x); __module_init_disable(x); } while (0)
| > | >
| > | > so it won't break code like
| > | >
| > | >         if (..)
| > | >                 module_init(x);
| > | >         else
| > | >                 something_else();
| > | >
| > | > (Yes, that code is nonsense but if you're going to nitpick, go all the way...)
| > |
| > | Right. =)
| > | Anyway, besides nitpicking, is there any reason not to include this
| > | code? Or is the added feature considered plain bloat? Yes, the kernel
| > | will become a bit larger, but all the data added by this patch will go
| > | into the init section.
| >
| > Looks like a good idea to me.
| >
| > ---
| > ~Randy
| 
| Can't you disable module-loading with a module? I think so.
| You don't need to modify the kernel. Boot-scripts could
| just load the "final" module and there is nothing that
| can be done to add another module (or even unload existing
| ones).

Sounds likely, but that's not what the patch from Magnus is
even trying to do.  It's purely for boot-time selection of
troublesome modules or devices AFAICT.  I've had a few
occasions to use something like this -- or rebuild a kernel
or remove a device.

---
~Randy
