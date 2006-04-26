Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932474AbWDZVOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbWDZVOg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 17:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbWDZVOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 17:14:35 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:47294 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S932474AbWDZVOf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 17:14:35 -0400
X-AuthUser: davidel@xmailserver.org
Date: Wed, 26 Apr 2006 14:14:16 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@alien.or.mcafeemobile.com
To: kyle@pbx.org
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: accept()ing socket connections with level triggered epoll
In-Reply-To: <20060426205557.GA5483@www.t3inc.us>
Message-ID: <Pine.LNX.4.64.0604261411460.16727@alien.or.mcafeemobile.com>
References: <20060426205557.GA5483@www.t3inc.us>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Apr 2006, kyle@pbx.org wrote:

> I think I may have found a bug in Linux's implementation of epoll.  My
> program creates a server socket that listens for incoming SOCK_STREAM
> connections.  It uses epoll to wait for notification of a new connection
> (and also to handle the client sockets).  While the client sockets use edge
> triggered epoll, for performance reasons, the server socket uses level
> triggered epoll.
>
> I have found that when I open connections to my program very quickly, it is
> sometimes possible to call accept more than once before reaching the point
> where no more connections are available and EAGAIN is returned.  If I return
> to epoll_wait without accepting all of the available connections, I should
> immediately be notified that a read is still available on the server socket,
> since I am using level triggered epoll for that descriptor (at least that is
> my understanding of how all of this is supposed to work ;).  However, epoll
> does not make this notification.  Even if the program accepts further
> incoming connections, the missed connection is never accepted, and
> eventually times out on the client side.
>
> Kernel version is 2.6.9.  I can provide test code if needed.

Correct, if it's LT you have to get the event because before returning 
from epoll_wait(), the event is automatically re-armed if f_op->poll() 
returns it. Can you post the *minimal* test code for this case?



- Davide


