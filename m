Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262803AbSKZEe0>; Mon, 25 Nov 2002 23:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262804AbSKZEe0>; Mon, 25 Nov 2002 23:34:26 -0500
Received: from dp.samba.org ([66.70.73.150]:8938 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262803AbSKZEeZ>;
	Mon, 25 Nov 2002 23:34:25 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Werner Almesberger <wa@almesberger.net>
Cc: linux-kernel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
       Alexander Viro <viro@math.psu.edu>
Subject: Re: Module Refcount & Stuff mini-FAQ 
In-reply-to: Your message of "Mon, 25 Nov 2002 23:26:10 -0300."
             <20021125232610.A22825@almesberger.net> 
Date: Tue, 26 Nov 2002 14:16:44 +1100
Message-Id: <20021126044142.48F332C07F@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021125232610.A22825@almesberger.net> you write:
> Rusty Russell wrote:
> > There's currently no way to abort if you've exposed interfaces and then
> > something fails ("don't do that" is great except noone knows that, and
> > it's not always possible or nice)
> 
> Hmm, if "expose interface" == "publish symbol", why can't you simply
> defer publishing until after initialization completes ? If "expose
> interface" == "register something somewhere", then this has to be
> undone anyway. Or am I overlooking something here ?

Yes, but between doing and undoing (in the failure path) someone has
started using the module.  The old modutils would unload it underneath
them here.  I catch it (if CONFIG_MODULE_UNLOAD, otherwise I can't)
and yell "module is now stuck" and leave it hanging.

Given we have a method of isolating a module already, it seems logical
to use it to prevent exactly this race.  Unfortunately my last attempt
assumed noone did this, and broke IDE and SCSI (hence pissing
*everyone* off 8).

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
