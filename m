Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbUCBV6O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 16:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261915AbUCBV6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 16:58:13 -0500
Received: from chaos.analogic.com ([204.178.40.224]:29824 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261904AbUCBV6I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 16:58:08 -0500
Date: Tue, 2 Mar 2004 16:59:05 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Roland Dreier <roland@topspin.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: poll() in 2.6 and beyond
In-Reply-To: <52n06zq67n.fsf@topspin.com>
Message-ID: <Pine.LNX.4.53.0403021651010.9048@chaos>
References: <Pine.LNX.4.53.0403021318580.796@chaos> <527jy3qalg.fsf@topspin.com>
 <Pine.LNX.4.53.0403021510270.1856@chaos> <52vflnq807.fsf@topspin.com>
 <Pine.LNX.4.53.0403021624300.2296@chaos> <52n06zq67n.fsf@topspin.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Mar 2004, Roland Dreier wrote:

>     Roland> I don't think so.  Even in kernel 2.4, poll_wait() just
>     Roland> calls __pollwait().  I don't see anything in __pollwait()
>     Roland> that sleeps.  Think about it.  How would the kernel handle
>     Roland> userspace calling poll() with more than one file
>     Roland> descriptor if each individual driver slept?
>
>     Richard> Well what to you think they do? Spin?
>
> I don't know why I continue this, but.... can you point out the line
> in the kernel 2.4 source for __pollwait() where it sleeps?
>

You are playing games with semantics because you are wrong.
The code in fs/select.c about line 101, adds the current caller
to the wait-queue. This wait-queue is the mechanism by which the
current caller sleeps, i.e., gives the CPU up to somebody else.
That caller's thread will not return past that line until
a wake_up_interruptible() call has been made for/from the
driver or interface handling that file descriptor. In this manner
any number of file discriptors may be handled because the poll()
routine for each of then makes its own entry into the wait-queue
using the described mechanism.

> Or think about it.  Suppose a user called poll() with two fds, each of
> which belonged to a different driver.  Suppose each driver slept in
> its poll method.  If the first driver never became ready (and stayed
> asleep), how would poll() return to user space if the second driver
> became ready?
>

Explained above.
[SNIPPED bullshit]


Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


