Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269404AbUJFQ5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269404AbUJFQ5s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 12:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269414AbUJFQxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 12:53:03 -0400
Received: from fw.osdl.org ([65.172.181.6]:1236 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269404AbUJFQvC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 12:51:02 -0400
Date: Wed, 6 Oct 2004 09:51:00 -0700
From: Chris Wright <chrisw@osdl.org>
To: Stuart MacDonald <stuartm@connecttech.com>
Cc: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: Proper use of daemonize()?
Message-ID: <20041006095100.B2441@build.pdx.osdl.net>
References: <030601c4abb7$af573770$294b82ce@stuartm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <030601c4abb7$af573770$294b82ce@stuartm>; from stuartm@connecttech.com on Wed, Oct 06, 2004 at 11:18:07AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stuart MacDonald (stuartm@connecttech.com) wrote:
> I've been looking at the kernel threads that use daemonize() and have
> some questions about the proper use of this call:

What kernel are you looking at?  Take a look at current 2.6 and you
should find it much more uniform.

> 1: Some threads use the lock_kernel() calls around the daemonize()
> call. Is this necessary? I thought the BKL was phasing out.

I don't see why it'd be necessary.

> 2: Some threads do their setup (like changing the comm string, setting
> the signal masks, etc) before daemonize(), some do it after. Is there
> any benefit to a particular order of operations? I can't see one.

Current daemonize api includes name.

> 3: Some threads set current->tty to NULL. Why would a thread *not* do
> this?

Current daemonize function does this.

> 4: Some threads grab the sigmask_lock before manipulating their masks.
> Is this necessary? If so, some threads have bugs. If not, why do some
> threads bother?

Yes it's required.

> 5: Some threads do flush_signals() or recalc_sigpending() before
> updating their blocked mask, some do it after. Does the order matter?
> I suspect not.

Current daemonize gets this right.

> 6: MOD_INC_USE_COUNT should be used by all threads that could be in
> drivers built as modules, correct?

Not necessarily, modules can handle this in other ways (killing thread
on unload, for example).

> 7: If you're not spawning a permanent kernel thread (like kswapd frex)
> is the any benefit to using reparent_to_init()? I can't see one.

To give thread proper security credentials.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
