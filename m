Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266129AbTLaF4I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 00:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266125AbTLaF4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 00:56:08 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:48256 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S266129AbTLaF4G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 00:56:06 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 30 Dec 2003 21:56:05 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       <mingo@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] kthread_create 
In-Reply-To: <20031231053603.65CA52C08B@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0312302149350.1457-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Dec 2003, Rusty Russell wrote:

> In message <Pine.LNX.4.44.0312302100550.1457-100000@bigblue.dev.mdolabs.com> you write:
> > Wouldn't it be better to put a kt_message inside a tast_struct?
> 
> Expand task_struct for this one usage?  I don't think that's
> worthwhile.
> 
> The whole code is written so there is no datastructure associated with
> the kthread.  When something like kt_message is needed (to kill a
> thread, for example), they grab the lock and use the static one.
> 
> This means that threads can exit without having to do cleanup.

I agree on one side, there's the drawback on a size increase (3 pointers, 
plus eventually a spinlock) of the task struct. But IMO the code would be 
cleaner, since you know who is the target of the message. Also it would 
not require any cleanup since there would be nothing allocated, just a 
struct member inside task_struct.
Also, what happens in the task woke up by a send does not reschedule 
before another CPU does another send? Wouldn't a message be lost?



- Davide


