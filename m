Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263600AbTFPInS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 04:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263628AbTFPInS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 04:43:18 -0400
Received: from bart.one-2-one.net ([217.115.142.76]:35594 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S263600AbTFPInQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 04:43:16 -0400
Date: Mon, 16 Jun 2003 10:57:36 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: Rusty Russell <rusty@rustcorp.com.au>
cc: NeilBrown <neilb@cse.unsw.edu.au>, Linus Torvalds <torvalds@transmeta.com>,
       <linux-kernel@vger.kernel.org>, <akpm@zip.com.au>
Subject: Re: [PATCH] Add module_kernel_thread for threads that live in modules.
In-Reply-To: <20030616082925.AF5EE2C0D2@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0306161043020.2079-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jun 2003, Rusty Russell wrote:

> In message <Pine.LNX.4.44.0306160907470.2079-100000@notebook.home.mdiehl.de> you write:
> > Why using keventd? Personally I'd prefer a synchronous thread start/stop, 
> > particularly with the thread living in a module.
> > Maybe some generalisation of:
> 
> It would be syncronous:

You mean your cleanup_thread would block for completion of the keventd 
stuff? Ok, this would work. But then, when calling cleanup_thread, f.e. we 
must not hold any semaphore which might be acquired by _any_ other work 
scheduled for keventd or we might end in deadlock (like the rtnl+hotplug 
issue we had seen recently).

> but doing kernel_thread yourself means trying
> to clean up using daemonize et al, which is incomplete and always
> makes me nervous.

I thought this was fixed in 2.5 for some time now, but seems I shouldn't 
rely on that ;-)

> An implementation detail to users, but IMHO an important one.
> 
> Also, this replaces complete_and_exit: the thread can just exit.  This
> simplifies things for the users, too...

Personally I do like the complete_and_exit thing as a simple and clear 
finalisation point. And if I didn't miss something above wrt. your 
cleanup_kthread being synchronous I'm not sure whether the locking 
implication do really make things easier - YMMV of course.

Thanks.
Martin

