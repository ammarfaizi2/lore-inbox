Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbUDDCtI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 21:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbUDDCtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 21:49:08 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:18057 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262119AbUDDCtF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 21:49:05 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sat, 3 Apr 2004 18:49:00 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Jamie Lokier <jamie@shareable.org>
cc: Ben Mansell <ben@zeus.com>, Steven Dake <sdake@mvista.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Is POLLHUP an input-only or bidirectional condition? (was: epoll
 reporting events when it hasn't been asked to)
In-Reply-To: <20040404020851.GB7074@mail.shareable.org>
Message-ID: <Pine.LNX.4.44.0404031845330.2877-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Apr 2004, Jamie Lokier wrote:

> A comment in eventpoll.c says:
> 
>  * This semaphore is acquired by ep_free() during the epoll file
>  * cleanup path and it is also acquired by eventpoll_release()
>  * if a file has been pushed inside an epoll set and it is then
>  * close()d without a previous call toepoll_ctl(EPOLL_CTL_DEL).
> 
> I.e. implying that the final close() is possible while it's registered.
> (Btw, a function called eventpoll_release() doesn't exist).

Woops, you're right. The function is inside include/linux/eventpoll.h 
because it has been split into an inline to handle the fast path, plus the 
slow path eventpoll_release_file(). I'll send a patch to Andrew to fix 
comments.


> What happens when a file descriptor is closed while it is inside the set?
> 
> I guess it's simply dropped from the set, is that right?

Yes, it is automatically removed from the epoll set, iif the underlying 
file* count goes to zero.


- Davide


