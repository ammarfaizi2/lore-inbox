Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265310AbUADWIt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 17:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265319AbUADWIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 17:08:48 -0500
Received: from dp.samba.org ([66.70.73.150]:33980 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265310AbUADWIk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 17:08:40 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: mingo@redhat.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] kthread_create 
In-reply-to: Your message of "Sat, 03 Jan 2004 20:42:26 -0800."
             <Pine.LNX.4.44.0401032039350.2022-100000@bigblue.dev.mdolabs.com> 
Date: Sun, 04 Jan 2004 20:35:54 +1100
Message-Id: <20040104220836.7EAFF2C224@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0401032039350.2022-100000@bigblue.dev.mdolabs.com> you write:
> > You can get around (2) by having a permenant parent "kthread" thread
> > which is a parent to all the kthreads (it'll get a SIGCHLD when
> > someone does "do_exit()").  But the implementation was pretty ugly,
> > since it involved having a communications mechanism with the kthread
> > parent, which means you have the global ktm_message-like-thing for
> > this...
> 
> You will lose in any case. What happens if the thread does do_exit() and 
> you do kthread_stop() after that?

That's illegal.  Either your thread exits, or you call kthread_stop().

> With the patch I posted to you, the kthread_stop() will simply miss the 
> lookup and return -ENOENT.

Or find some other random kthread which has reused the task struct and
kill that 8(

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
