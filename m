Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262507AbVDGRX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262507AbVDGRX4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 13:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262510AbVDGRX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 13:23:56 -0400
Received: from alog0304.analogic.com ([208.224.222.80]:9395 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262507AbVDGRXs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 13:23:48 -0400
Date: Thu, 7 Apr 2005 13:22:57 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: Magnus Damm <magnus.damm@gmail.com>, roland@topspin.com,
       asterixthegaul@gmail.com, damm@opensource.se,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] disable built-in modules V2
In-Reply-To: <20050407100147.7b91a2d2.rddunlap@osdl.org>
Message-ID: <Pine.LNX.4.61.0504071319430.5977@chaos.analogic.com>
References: <20050405225747.15125.8087.59570@clementine.local><54b5dbf505040618324186678a@mail.gmail.com><528y3v72al.fsf@topspin.com><aec7e5c305040701236289aacd@mail.gmail.com>
 <20050407100147.7b91a2d2.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Apr 2005, Randy.Dunlap wrote:

> On Thu, 7 Apr 2005 10:23:32 +0200 Magnus Damm wrote:
>
> | On Apr 7, 2005 4:23 AM, Roland Dreier <roland@topspin.com> wrote:
> | >  > > -#define module_init(x) __initcall(x);
> | >  > > +#define module_init(x) __initcall(x); __module_init_disable(x);
> | >  >
> | >  > It would be better if there is brackets around them... like
> | >  >
> | >  > #define module_init(x) { __initcall(x); __module_init_disable(x); }
> | >  >
> | >  > then we know it wont break some code like
> | >  >
> | >  > if (..)
> | >  >  module_init(x);
> | >
> | > This is all completely academic, since module_init() is a declaration
> | > that won't be inside any code, but in general it's better still to use
> | > the do { } while (0) idiom like
> | >
> | > #define module_init(x) do { __initcall(x); __module_init_disable(x); } while (0)
> | >
> | > so it won't break code like
> | >
> | >         if (..)
> | >                 module_init(x);
> | >         else
> | >                 something_else();
> | >
> | > (Yes, that code is nonsense but if you're going to nitpick, go all the way...)
> |
> | Right. =)
> | Anyway, besides nitpicking, is there any reason not to include this
> | code? Or is the added feature considered plain bloat? Yes, the kernel
> | will become a bit larger, but all the data added by this patch will go
> | into the init section.
>
> Looks like a good idea to me.
>
> ---
> ~Randy

Can't you disable module-loading with a module? I think so.
You don't need to modify the kernel. Boot-scripts could
just load the "final" module and there is nothing that
can be done to add another module (or even unload existing
ones).

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
