Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265285AbTLaXQl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 18:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265287AbTLaXQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 18:16:41 -0500
Received: from dp.samba.org ([66.70.73.150]:12981 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265285AbTLaXQj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 18:16:39 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [PATCH 1/2] kthread_create 
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       mingo@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-reply-to: Your message of "Tue, 30 Dec 2003 21:56:05 -0800."
             <Pine.LNX.4.44.0312302149350.1457-100000@bigblue.dev.mdolabs.com> 
Date: Wed, 31 Dec 2003 17:27:44 +1100
Message-Id: <20031231231637.912362C013@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0312302149350.1457-100000@bigblue.dev.mdolabs.com> you write:
> plus eventually a spinlock) of the task struct. But IMO the code would be 
> cleaner, since you know who is the target of the message.

<shrug> The code's really not that complicated.

> Also, what happens in the task woke up by a send does not reschedule 
> before another CPU does another send? Wouldn't a message be lost?

There's a lock, so only one communication happens at a time, and all
communication is request-response, so it's pretty straightforward.

But an alternate implementation would be to have a "kthread" kernel
thread, which would actually be parent to the kthread threads.  This
means it can allocate and clean up, since it catches *all* thread
deaths, including "exit()".

What do you think?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
