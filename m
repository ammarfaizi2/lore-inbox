Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263633AbTFPJJY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 05:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263637AbTFPJJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 05:09:23 -0400
Received: from dp.samba.org ([66.70.73.150]:42659 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263633AbTFPJJX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 05:09:23 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Martin Diehl <lists@mdiehl.de>
Cc: NeilBrown <neilb@cse.unsw.edu.au>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: [PATCH] Add module_kernel_thread for threads that live in modules. 
In-reply-to: Your message of "Mon, 16 Jun 2003 10:57:36 +0200."
             <Pine.LNX.4.44.0306161043020.2079-100000@notebook.home.mdiehl.de> 
Date: Mon, 16 Jun 2003 19:22:43 +1000
Message-Id: <20030616092316.3E31B2C013@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0306161043020.2079-100000@notebook.home.mdiehl.de> you write:
> On Mon, 16 Jun 2003, Rusty Russell wrote:
> > It would be syncronous:
> 
> You mean your cleanup_thread would block for completion of the keventd 
> stuff? Ok, this would work. But then, when calling cleanup_thread, f.e. we 
> must not hold any semaphore which might be acquired by _any_ other work 
> scheduled for keventd or we might end in deadlock (like the rtnl+hotplug 
> issue we had seen recently).

I think we're talking across each other: take a look at the existing
kernel/kmod.c __call_usermodehelper to see how we wait at the moment.

> > Also, this replaces complete_and_exit: the thread can just exit.  This
> > simplifies things for the users, too...
> 
> Personally I do like the complete_and_exit thing as a simple and clear 
> finalisation point.

Not as clean as "wait until the thread has exited", surely!

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
