Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264292AbUAOBjY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 20:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264538AbUAOBhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 20:37:39 -0500
Received: from dp.samba.org ([66.70.73.150]:20871 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264539AbUAOBh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 20:37:26 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Cc: Horacio de Oro <hgdeoro@yahoo.com>, mingo@redhat.com
Subject: Re: [2.6.1-mm2] Badness in futex_wait at kernel/futex.c:509 
In-reply-to: Your message of "Tue, 13 Jan 2004 22:36:12 -0800."
             <20040113223612.4fe709d9.akpm@osdl.org> 
Date: Thu, 15 Jan 2004 09:46:45 +1100
Message-Id: <20040115013723.33EF22C21C@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040113223612.4fe709d9.akpm@osdl.org> you write:
> Horacio de Oro <hgdeoro@yahoo.com> wrote:
> >
> > Hi!
> > 
> > This happen every time I switch from X to console:
> > 
> > Badness in futex_wait at kernel/futex.c:509
> > Call Trace:
> >  [futex_wait+434/448] futex_wait+0x1b2/0x1c0
> >  [default_wake_function+0/32] default_wake_function+0x0/0x20
> >  [default_wake_function+0/32] default_wake_function+0x0/0x20
> >  [do_futex+112/128] do_futex+0x70/0x80
> >  [sys_futex+292/320] sys_futex+0x124/0x140
> >  [syscall_call+7/11] syscall_call+0x7/0xb
> > 
> 
> 	/* A spurious wakeup should never happen. */
> 	WARN_ON(!signal_pending(current));
> 
> (looks at Rusty)

You were the one who said spurious wakeups shouldn't happen 8)

This implies that the console code decided to do wake_up_process() on
us.  We returned -EINTR to userspace, but there was no signal, which
is odd.

Anyone have any ideas *why*?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
