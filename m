Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265628AbUADXDK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 18:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265765AbUADXDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 18:03:10 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:27800 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265628AbUADXDF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 18:03:05 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sun, 4 Jan 2004 15:03:01 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Davide Libenzi <davidel@xmailserver.org>, <mingo@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] kthread_create 
In-Reply-To: <20040104220836.7EAFF2C224@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0401041501510.12666-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Jan 2004, Rusty Russell wrote:

> In message <Pine.LNX.4.44.0401032039350.2022-100000@bigblue.dev.mdolabs.com> you write:
> > > You can get around (2) by having a permenant parent "kthread" thread
> > > which is a parent to all the kthreads (it'll get a SIGCHLD when
> > > someone does "do_exit()").  But the implementation was pretty ugly,
> > > since it involved having a communications mechanism with the kthread
> > > parent, which means you have the global ktm_message-like-thing for
> > > this...
> > 
> > You will lose in any case. What happens if the thread does do_exit() and 
> > you do kthread_stop() after that?
> 
> That's illegal.  Either your thread exits, or you call kthread_stop().
> 
> > With the patch I posted to you, the kthread_stop() will simply miss the 
> > lookup and return -ENOENT.
> 
> Or find some other random kthread which has reused the task struct and
> kill that 8(

I can see two options:

1) We do not allow do_exit() from kthreads

2) We give kthread_exit()

What do you think?



- Davide


