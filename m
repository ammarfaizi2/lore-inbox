Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129469AbRBTMxN>; Tue, 20 Feb 2001 07:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129528AbRBTMxE>; Tue, 20 Feb 2001 07:53:04 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:9221 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129469AbRBTMw6>; Tue, 20 Feb 2001 07:52:58 -0500
From: Peter Samuelson <peter@cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14994.26784.82642.367253@wire.cadcamlab.org>
Date: Tue, 20 Feb 2001 06:52:48 -0600 (CST)
To: BERECZ Szabolcs <szabi@inf.elte.hu>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] new setprocuid syscall
In-Reply-To: <20010219230106.A23699@cadcamlab.org>
	<Pine.A41.4.31.0102201250290.127214-100000@pandora.inf.elte.hu>
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
X-Face: ?*2Jm8R'OlE|+C~V>u$CARJyKMOpJ"^kNhLusXnPTFBF!#8,jH/#=Iy(?ehN$jH
        }x;J6B@[z.Ad\Be5RfNB*1>Eh.'R%u2gRj)M4blT]vu%^Qq<t}^(BOmgzRrz$[5
        -%a(sjX_"!'1WmD:^$(;$Q8~qz\;5NYji]}f.H*tZ-u1}4kJzsa@id?4rIa3^4A$
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[BERECZ Szabolcs]
> > Race -- you need to make sure the task_struct doesn't disappear out
> > from under you.
> 
> Yes, but we need a write_lock, not a read_lock.

No, it's a read_lock because it is locking the task *list*, which is
not being changed.  The only thing being changed is data within a task
struct.  The lock is merely to prevent the task itself from
disappearing.

> We need a userspace tool, because we must check if the user, who want
> to change the uid, knows the other user's passwd.
> Or what if user1 want to change user2's process to user3 uid?

That is a mere 'sudo'-type issue -- just a matter of figuring out who
has the right to do this to whom and under what circumstances.  Root,
in any case, can do the job without a special tool.

Anyhow, according to Alan bad things can happen if the uid set is
changed unexpectedly.  I assume he means certain permissions checks
could be confused by accessing ->euid more than once and getting
different answers.  If so, I agree that this is a bad idea....

Peter
