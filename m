Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265334AbUBPDmq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 22:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265339AbUBPDmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 22:42:45 -0500
Received: from dp.samba.org ([66.70.73.150]:56736 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265334AbUBPDmj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 22:42:39 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Christophe Saout <christophe@saout.de>
Subject: Re: kthread vs. dm-daemon (was: Oopsing cryptoapi (or loop device?) on 2.6.*) 
Cc: Joe Thornber <thornber@redhat.com>, linux-kernel@vger.kernel.org
In-reply-to: Your message of "Sun, 15 Feb 2004 21:24:28 BST."
             <1076876668.21968.22.camel@leto.cs.pocnet.net> 
Date: Mon, 16 Feb 2004 14:02:04 +1100
Message-Id: <20040216034250.EDCC82C053@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1076876668.21968.22.camel@leto.cs.pocnet.net> you write:
> Am So, den 15.02.2004 schrieb Christoph Hellwig um 20:46:
> 
> > > The only reason, I guess, is that it depends on this very small
> > > dm-daemon thing:
> > > http://people.sistina.com/~thornber/dm/patches/2.6-unstable/2.6.2/2.6.2-u
dm1/00016.patch
> >
> > Well, actually the above code should not enter the kernel tree at all.
> > Care to rewrite dm-crypt to use Rusty's kthread code in -mm instead and
> > submit a patch to Andrew?  Whenever he merges the kthread stuff to mainline
> > he could just include dm-crypt then.
> 
> Sure I could.
> 
> But kthread is currently not a full replacement for dm-daemon. kthread
> provides thread creation and destruction functions. But dm-daemon
> additionaly does mainloop handling.

Yes, looks like dm-daemon is a workqueue.

> There seems to beg a small race conditition that can appear when using
> only wake_up for notifies so dm-daemon uses an additional atomic_t
> variable to make sure nothing gets missed. Just see the function
> ``daemon'' in dm-daemon.c.

This is why using a workqueue, rather than having everyone invent
their own methods, is a good idea.

> It seems to me that this functionality could perhaps be somehow added to
> kthread without changing it too much... ?

You could build it on top of kthread probably.  You could also change
workqueues to resize dynamically, rather than be one per cpu (but
that's some fairly tricky code).

Thanks for bringing this code to my attention...
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
