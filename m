Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270680AbTGNSSb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 14:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270700AbTGNSSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 14:18:30 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:57539 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S270680AbTGNSSY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 14:18:24 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 14 Jul 2003 11:25:49 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: kuznet@ms2.inr.ac.ru
cc: "David S. Miller" <davem@redhat.com>, jmorris@redhat.com,
       jamie@shareable.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fw: Re: [Patch][RFC] epoll and half closed TCP connections
In-Reply-To: <200307141739.VAA05290@dub.inr.ac.ru>
Message-ID: <Pine.LNX.4.55.0307141122260.4828@bigblue.dev.mcafeelabs.com>
References: <200307141739.VAA05290@dub.inr.ac.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jul 2003 kuznet@ms2.inr.ac.ru wrote:

> > it looks as though _every_ TCP ACK you receive will cause epoll to wake up
> > a task which is interested in _any_ socket events,
>
> This is not quite true. sk->write_space() is called only after write
> queue is full, and it is exactly one wakeup until the next overflow.
>
> But, actually, yes, it is right observation: one wait queue for all
> the socket events is painful. Note, that with current poll() improvements
> are suboptimal, tcp_poll() does not know _what_ this poll polls for,
> so it has to stand in all the wait queues. The same thing kills lots
> of possible improvements.

Indeed. This can be improved though, with some serious work. The poll(2)
and epoll caller supply events he is interested in. We could have
poll_wait() (and f_op->poll()) to accept an events parameter so that the
f_op->poll() code can drop inside separate wait queue depending on what
the caller is waiting for.



- Davide

