Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266124AbTLaFgH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 00:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266126AbTLaFgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 00:36:07 -0500
Received: from dp.samba.org ([66.70.73.150]:21684 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266124AbTLaFgF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 00:36:05 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       mingo@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] kthread_create 
In-reply-to: Your message of "Tue, 30 Dec 2003 21:06:18 -0800."
             <Pine.LNX.4.44.0312302100550.1457-100000@bigblue.dev.mdolabs.com> 
Date: Wed, 31 Dec 2003 16:34:14 +1100
Message-Id: <20031231053603.65CA52C08B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0312302100550.1457-100000@bigblue.dev.mdolabs.com> you write:
> Wouldn't it be better to put a kt_message inside a tast_struct?

Expand task_struct for this one usage?  I don't think that's
worthwhile.

The whole code is written so there is no datastructure associated with
the kthread.  When something like kt_message is needed (to kill a
thread, for example), they grab the lock and use the static one.

This means that threads can exit without having to do cleanup.

Hope that clarifies,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
