Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265708AbTAOHXH>; Wed, 15 Jan 2003 02:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265777AbTAOHXH>; Wed, 15 Jan 2003 02:23:07 -0500
Received: from almesberger.net ([63.105.73.239]:8975 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S265708AbTAOHXG>; Wed, 15 Jan 2003 02:23:06 -0500
Date: Wed, 15 Jan 2003 04:31:47 -0300
From: Werner Almesberger <wa@almesberger.net>
To: kuznet@ms2.inr.ac.ru
Cc: Roman Zippel <zippel@linux-m68k.org>, kronos@kronoz.cjb.net,
       rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Migrating net/sched to new module interface
Message-ID: <20030115043147.A1840@almesberger.net>
References: <3E24A981.1EA03E8B@linux-m68k.org> <200301150119.EAA14364@sex.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301150119.EAA14364@sex.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Wed, Jan 15, 2003 at 04:19:28AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kuznet@ms2.inr.ac.ru wrote:
> Somewhat overdone.

I think it would be nice to introduce in 2.7 a shutdowncall
(*) function class for modules that works like exitcall, but
with the following differences:

 - does not return before the module has really de-registered
   itself everywhere, including synchronization with any
   callbacks, etc.
 - has a return code, and can fail if it would have to sleep
   for a possibly long time

Before calling the shutdown function, all symbols exported by
the module are hidden, and after the shutdown functions returns,
the module can be unloaded.

That way, the module reference count becomes merely advisory
information, and the real locking, synchronization, etc. is
inside the module.

The module unload mechanism could then check whether the module
is old (uses exitcall) or new (uses shutdowncall), and act
accordingly. Modules and the services they use could then be
gradually fixed.

(*) Or maybe use a nicer name :-)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
