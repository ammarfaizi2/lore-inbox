Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315690AbSILNjq>; Thu, 12 Sep 2002 09:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315709AbSILNjq>; Thu, 12 Sep 2002 09:39:46 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:51464 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S315690AbSILNjo>; Thu, 12 Sep 2002 09:39:44 -0400
Date: Thu, 12 Sep 2002 15:44:01 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Alexander Viro <viro@math.psu.edu>, Daniel Phillips <phillips@arcor.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Raceless module interface 
In-Reply-To: <20020912130337.3FFBF2C1CD@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0209121520300.28515-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 12 Sep 2002, Rusty Russell wrote:

> Nope, that's one of the two problems.  Read my previous post: the
> other is partial initialization.
>
> Your patch is two-stage delete, with the additional of a usecount
> function.  So you have to move the usecount from the module to each
> object it registers: great for filesystems, but I don't think it buys
> you anything (since they were easy anyway).

I'm aware of the init problem, what I described was the core problem,
which prevents any further cleanup.
The usecount is optional, the only important question a module must be
able to answer is: Are there any objects/references belonging to the
module? It's a simple yes/no question. If a module can't answer that, it
likely has more problem than just module unloading.
How that interface is exactly done is open for discussion and needs to be
specified.

> Moreover, I don't see where your patch prevented someone increasing
> the module count during try_unregister_module(), so that check is
> pointless (do it in userspace unless they specify rmmod -f).

I don't see your problem, if someone looks up a module, he gets a
reference to the module structure, if a reference count goes to zero the
module must be completely freed. State changes are protected with a
separate lock, if a module is loaded/unloaded an extra reference is used
to prevent module removal.

bye, Roman

