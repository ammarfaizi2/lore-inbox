Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270753AbTGNR0K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 13:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270748AbTGNRZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 13:25:44 -0400
Received: from dub.inr.ac.ru ([193.233.7.105]:43730 "HELO dub.inr.ac.ru")
	by vger.kernel.org with SMTP id S270753AbTGNRYp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 13:24:45 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200307141739.VAA05290@dub.inr.ac.ru>
Subject: Re: Fw: Re: [Patch][RFC] epoll and half closed TCP connections
To: davem@redhat.com (David S. Miller)
Date: Mon, 14 Jul 2003 21:39:25 +0400 (MSD)
Cc: jmorris@redhat.com, jamie@shareable.org, linux-kernel@vger.kernel.org
In-Reply-To: <20030713070352.3f21a9f8.davem@redhat.com> from "David S. Miller" at Jul 13, 2003 07:03:52 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> it looks as though _every_ TCP ACK you receive will cause epoll to wake up
> a task which is interested in _any_ socket events,

This is not quite true. sk->write_space() is called only after write
queue is full, and it is exactly one wakeup until the next overflow.

But, actually, yes, it is right observation: one wait queue for all
the socket events is painful. Note, that with current poll() improvements
are suboptimal, tcp_poll() does not know _what_ this poll polls for,
so it has to stand in all the wait queues. The same thing kills lots
of possible improvements.


> further, we might as well admit that POLLHUP should be called
> POLLWRHUP.)

No, really. POLLHUP=POLLRDHUP&POLLWRHUP, plus POLLHUP is unmaskable event.
Yes, SVR4 screwed up its semantics in such extent that it is mostly
meaningless.

Alexey
