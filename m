Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318924AbSG1HaB>; Sun, 28 Jul 2002 03:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318935AbSG1H3d>; Sun, 28 Jul 2002 03:29:33 -0400
Received: from mx1.elte.hu ([157.181.1.137]:10425 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318933AbSG1H2t>;
	Sun, 28 Jul 2002 03:28:49 -0400
Date: Sun, 28 Jul 2002 09:30:50 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] scheduler, migration startup fixes, 2.5.29 
In-Reply-To: <20020728033359.5D6D0442E@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0207280928500.7263-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 28 Jul 2002, Rusty Russell wrote:

> This is, AFAICT, overkill (the UP compilation fix appreciated though).
> 
> When a new CPU comes up, there is a semaphore which is held through the
> notifier, so you can't have two CPUs come up at once.
> 
> Therefore, the new migration thread is either started on a completely
> active cpu (ie. there's a migration thread on that CPU to use), or it's
> already on the new cpu, in which case set_cpus_allowed is a noop.
> 
> What am I missing? [...]

you are missing the following situation: if a newly forked migration
thread is put on a non-boot CPU that is already started up. Because it's
the target CPU's migration thread that counts - and since the newly online
CPU doesnt have one, we could deadlock.

so current BK is the right behavior.

	Ingo

