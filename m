Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbUDDCJH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 21:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262117AbUDDCJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 21:09:07 -0500
Received: from mail.shareable.org ([81.29.64.88]:7831 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S262110AbUDDCJF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 21:09:05 -0500
Date: Sun, 4 Apr 2004 03:08:51 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Ben Mansell <ben@zeus.com>, Steven Dake <sdake@mvista.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Is POLLHUP an input-only or bidirectional condition? (was: epoll reporting events when it hasn't been asked to)
Message-ID: <20040404020851.GB7074@mail.shareable.org>
References: <20040403223541.GB6122@mail.shareable.org> <Pine.LNX.4.44.0404031723570.2710-100000@bigblue.dev.mdolabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0404031723570.2710-100000@bigblue.dev.mdolabs.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> > Btw, I notice epoll never reports POLLNVAL.  Is that correct?
> 
> Yep, epoll does not allow you to push an invalid/unopen file descriptor 
> inside the set. So you get an EBADF from epoll_ctl().

A comment in eventpoll.c says:

 * This semaphore is acquired by ep_free() during the epoll file
 * cleanup path and it is also acquired by eventpoll_release()
 * if a file has been pushed inside an epoll set and it is then
 * close()d without a previous call toepoll_ctl(EPOLL_CTL_DEL).

I.e. implying that the final close() is possible while it's registered.
(Btw, a function called eventpoll_release() doesn't exist).

What happens when a file descriptor is closed while it is inside the set?

I guess it's simply dropped from the set, is that right?

-- Jamie
