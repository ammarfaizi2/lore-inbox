Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266117AbTLaFag (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 00:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266124AbTLaFaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 00:30:35 -0500
Received: from dp.samba.org ([66.70.73.150]:3252 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266117AbTLaFae (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 00:30:34 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kthread_create 
In-reply-to: Your message of "Tue, 30 Dec 2003 23:33:53 CDT."
             <3FF251B1.4070404@pobox.com> 
Date: Wed, 31 Dec 2003 16:28:44 +1100
Message-Id: <20031231053032.255202C08B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3FF251B1.4070404@pobox.com> you write:
> Rusty Russell wrote:
> > Hi all,
> > 
> > 	Ingo read through this before and liked it: this is the basis
> > of the Hotplug CPU patch, and as such has been stressed fairly well.
> > Tested stand-alone, and included here for wider review.
> 
> Hey, this is pretty cool.
> 
> Recalling threads from LKML past, there are two mechanisms I (and some 
> others) felt were missing from the equally nifty workqueue stuff:
> 1) one-shot threads
> 2) keventd overflow
> 
> For #1, your patch seems to cover that nicely.

It's really for persistent threads, but you can use it as one-shot by
either (1) calling exit() in the core function (and noone calls
kthread_destroy), or (2) not having a core function and just having an
init function.  I used this in a test patch.

For #2, if you really can't wait for keventd, perhaps your own
workqueue is in order?

> Anyway, thanks for doing this, it fills a need, I believe.

Yes: stopping threads manually is a real PITA, and things like
complete_and_exit() always make me wince.

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
