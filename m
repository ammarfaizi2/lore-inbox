Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262067AbSKRK7N>; Mon, 18 Nov 2002 05:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262207AbSKRK7N>; Mon, 18 Nov 2002 05:59:13 -0500
Received: from mx2.elte.hu ([157.181.151.9]:52400 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S262067AbSKRK7M>;
	Mon, 18 Nov 2002 05:59:12 -0500
Date: Mon, 18 Nov 2002 13:21:20 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Luca Barbieri <ldb@ldb.ods.org>
Cc: Ulrich Drepper <drepper@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] threading fix, tid-2.5.47-A3
In-Reply-To: <1037608252.1774.49.camel@ldb>
Message-ID: <Pine.LNX.4.44.0211181318280.1639-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 18 Nov 2002, Luca Barbieri wrote:

> How about adding a MAP_DONTCOPY flag to mmap, using it for the thread
> stacks and then adding yet another flag and pointer to the clone
> syscall, pointing to a userspace array of addresses and flags, allowing
> to specify whether vmas should be copied, ignored (or maybe shared, as a
> future extension) so that userspace could specify that the current
> thread stack should be copied anyway?

i'd just add MAP_DONTCOPY, and use a new non-MAP_DONTCOPY descriptor for
the forked process. It's clearly possible with SETTID and SETTLS, nothing
says that the new process must have the same TLS as the old one.

this means that you can define VM-private data structures upon allocation
- this reduces the overhead at fork() time, with your other method the
kernel would have to parse & interpret the userspace array.

plus it might make sense to expressly enable this via a clone flag, ie.  
CLONE_VM_COPYABLE.

	Ingo

