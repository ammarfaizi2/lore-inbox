Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129464AbRBTMPQ>; Tue, 20 Feb 2001 07:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129461AbRBTMPH>; Tue, 20 Feb 2001 07:15:07 -0500
Received: from mail.inf.elte.hu ([157.181.161.6]:31909 "HELO mail.inf.elte.hu")
	by vger.kernel.org with SMTP id <S129464AbRBTMOy>;
	Tue, 20 Feb 2001 07:14:54 -0500
Date: Tue, 20 Feb 2001 13:14:46 +0100 (CET)
From: BERECZ Szabolcs <szabi@inf.elte.hu>
To: Peter Samuelson <peter@cadcamlab.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] new setprocuid syscall
In-Reply-To: <20010219230106.A23699@cadcamlab.org>
Message-ID: <Pine.A41.4.31.0102201250290.127214-100000@pandora.inf.elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Feb 2001, Peter Samuelson wrote:

> [BERECZ Szabolcs]
> > +       p = find_task_by_pid(pid);
> > +       p->fsuid = p->euid = p->suid = p->uid = uid;
> Race -- you need to make sure the task_struct doesn't disappear out
> from under you.

Yes, but we need a write_lock, not a read_lock.

> Anyway, why not use the interface 'chown uid /proc/pid'?  No new
> syscall, no arch-dependent part, no user-space tool, etc.

We need a userspace tool, because we must check if the user, who want to
change the uid, knows the other user's passwd.
Or what if user1 want to change user2's process to user3 uid?

Bye,
Szabolcs

