Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272064AbTG1CBa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 22:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272060AbTG1ABS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:01:18 -0400
Received: from zeus.kernel.org ([204.152.189.113]:14071 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272941AbTG0XB5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 19:01:57 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Stephen Hemminger <shemminger@osdl.org>,
       "David S. Miller" <davem@redhat.com>, arjanv@redhat.com,
       Greg KH <greg@kroah.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove module reference counting. 
In-reply-to: Your message of "Sat, 26 Jul 2003 12:31:25 MST."
             <Pine.LNX.4.44.0307261230110.1841-100000@home.osdl.org> 
Date: Mon, 28 Jul 2003 05:34:36 +1000
Message-Id: <20030727193919.832302C450@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0307261230110.1841-100000@home.osdl.org> you write:
> 
> First off - we're not changing fundamental module stuff any more.

OK.  Who are you and what have you done with the real Linus?

I guess it's back to fixing up reference counting in the rest of the
kernel.  It's not hard, it's just not done. 8(

> > No, it would just leak memory.  Not really a concern for developers.
> > It's fairly trivial to hack up a backdoor "remove all freed modules
> > and be damned" thing for developers if there's real demand.
> 
> It's not just a developer thing. At least installers etc used to do some 
> device probing by loading modules and depending on the result.

A similar case.  At this point you don't have random users trying to
access things, so freeing is actually fairly safe (modulo other
bugs).

The kudzu one and Alan's USB firmware example bother me more: they
load then unload modules currently?  Since modern device drivers are
not supposed to fail to load just because there isn't currently
hardware, I guess they'd have to.

Oh well,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
