Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280663AbRKSTw6>; Mon, 19 Nov 2001 14:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280674AbRKSTwi>; Mon, 19 Nov 2001 14:52:38 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:28428 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S280663AbRKSTwg>;
	Mon, 19 Nov 2001 14:52:36 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200111191952.WAA21731@ms2.inr.ac.ru>
Subject: Re: more tcpdumpinfo for nfs3 problem: aix-server --- linux 2.4.15pre5 client
To: trond.myklebust@fys.uio.no
Date: Mon, 19 Nov 2001 22:52:28 +0300 (MSK)
Cc: b.lammering@science-computing.de, linux-kernel@vger.kernel.org
In-Reply-To: <15353.23941.858943.218040@charged.uio.no> from "Trond Myklebust" at Nov 19, 1 08:29:09 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> The problem is that when EAGAIN is returned by sendmsg,

BTW this is already problem. UDP should not hit EAGAIN case, if the
predicate is right.


> requests), and then reactivate it as soon as sock_wspace() reports
> that the available free buffer space is large enough to fit the next
> request.

sock_wspace() is OK. sock_writable() is bad.


> released and that sock_wspace() does indeed reflect more or less the
> maximum message size for which there is free buffer space (I allow a
> couple of kilobytes for extra padding)

Do not economize. :-) The longer you wait the less you scheduled.
We used to wait for half of sndbuf to be freed.


>						 then the current UDP code
> should be correct and race-free.

BTW recently I was reported it deadlocks on some spinlock...

Alexey
