Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317642AbSHPAJj>; Thu, 15 Aug 2002 20:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317751AbSHPAJj>; Thu, 15 Aug 2002 20:09:39 -0400
Received: from mx1.elte.hu ([157.181.1.137]:41104 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S317642AbSHPAJj>;
	Thu, 15 Aug 2002 20:09:39 -0400
Date: Fri, 16 Aug 2002 02:14:06 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] user-vm-unlock-2.5.31-A2
In-Reply-To: <Pine.LNX.4.44.0208160205190.6746-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0208160212280.6837-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 16 Aug 2002, Ingo Molnar wrote:

> i think i see where the misunderstanding comes from: thread Y does not
> want to get into the address space of X - this is how the current
> CLEAR_TID code works and is expected to work. Threads always free their
> *own* thread state descriptor upon exit (eg. they set a flag in their
> own thread descriptor), not some field in the parent's domain. So thread
> Y does not ever want to write into X's address space - it wants to write
> into the VM that it's part of currently - if a fork() created a new VM
> then so be it, it's not attached to X in any way.

and this is the reason why i named the clone flag CLONE_RELEASE_VM - upon
exit a thread wants to 'release its reference to the VM' - and free all
state it still holds. Stack or whatever other state it has.

	Ingo

