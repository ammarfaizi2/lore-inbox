Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265885AbTBQCxH>; Sun, 16 Feb 2003 21:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266081AbTBQCxH>; Sun, 16 Feb 2003 21:53:07 -0500
Received: from dp.samba.org ([66.70.73.150]:53970 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265885AbTBQCxF>;
	Sun, 16 Feb 2003 21:53:05 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Russell King <rmk@arm.linux.org.uk>, Bob Miller <rem@osdl.org>
Cc: Lars Magne Ingebrigtsen <larsi@gnus.org>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.60 5/9] Update the Archimedes parallel port driver for new module API. 
In-reply-to: Your message of "Sat, 15 Feb 2003 10:04:24 -0000."
             <20030215100424.A20365@flint.arm.linux.org.uk> 
Date: Mon, 17 Feb 2003 13:54:59 +1100
Message-Id: <20030217030304.60DFA2C30D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030215100424.A20365@flint.arm.linux.org.uk> you write:
> On Fri, Feb 14, 2003 at 04:37:00PM -0800, Bob Miller wrote:
> > -static void arc_inc_use_count(void)
> > +static int arc_inc_use_count(void)
> >  {
> > -#ifdef MODULE
> > -	MOD_INC_USE_COUNT;
> > -#endif
> > +	return try_module_get(THIS_MODULE);
> >  }
> 
> Isn't one of the points of the module system that we don't try to run
> code inside a module without the module being reference counted?

Exactly.  You can do it if you *know* you already hold a reference
count, but as a general rule it's damn suspicious.

This looks wrong,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
