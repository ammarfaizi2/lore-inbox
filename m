Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280547AbRKSSth>; Mon, 19 Nov 2001 13:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280597AbRKSSt2>; Mon, 19 Nov 2001 13:49:28 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:37130 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S280547AbRKSStO>;
	Mon, 19 Nov 2001 13:49:14 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200111191849.VAA21085@ms2.inr.ac.ru>
Subject: Re: more tcpdumpinfo for nfs3 problem: aix-server --- linux 2.4.15pre5 client
To: trond.myklebust@fys.uio.no
Date: Mon, 19 Nov 2001 21:49:05 +0300 (MSK)
Cc: b.lammering@science-computing.de, linux-kernel@vger.kernel.org
In-Reply-To: <15353.19920.461805.879956@charged.uio.no> from "Trond Myklebust" at Nov 19, 1 07:22:08 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Alexey: Do you have any comments? Is it correct to check for
> sock_writeable() on a TCP socket?

No. sock_writable() is for datagram sockets, TCP never used or
satisfied this predicate, it used(s) more interesting one.

BTW applications need not use this anyway, we do not awake people
for no reasons. If a write failed with EAGAIN, wakeup will happen
only when there is some room for write. And it will not be awaken
again until the next write will fail. So, if you rejected wakeup
(due to wrong predicate), nobody will remind you again.

Alexey
