Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbUAAXem (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 18:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbUAAXem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 18:34:42 -0500
Received: from dp.samba.org ([66.70.73.150]:5848 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261837AbUAAXek (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 18:34:40 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       mingo@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] kthread_create 
In-reply-to: Your message of "Tue, 30 Dec 2003 23:12:24 -0800."
             <Pine.LNX.4.44.0312302255080.1457-100000@bigblue.dev.mdolabs.com> 
Date: Thu, 01 Jan 2004 10:25:38 +1100
Message-Id: <20040101233438.1A0822C05A@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0312302255080.1457-100000@bigblue.dev.mdolabs.com> you write:
> On Wed, 31 Dec 2003, Srivatsa Vaddagiri wrote:
> 
> > The messages should not be lost because we take the cpucontrol
> > semaphore in kthread_start or kthread_destroy before sending 
> > a (start or destroy) message.
> 
> I see, ok. At that point though, having the message struct inside the task 
> struct could save the *to pointer and (because of the big lock above), using 
> barrier and proper order in setting *from and *info, the spin lock.

My original version used barriers.  But IMHO if you're using barriers
and your code isn't speed-critical, you don't have enough locks.

So I just threw a spinlock around the struct, and no more barrier
issues.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
