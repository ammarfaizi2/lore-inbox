Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130731AbRBPRpq>; Fri, 16 Feb 2001 12:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130431AbRBPRpf>; Fri, 16 Feb 2001 12:45:35 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:49078 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S130739AbRBPRp2>; Fri, 16 Feb 2001 12:45:28 -0500
Date: Fri, 16 Feb 2001 12:44:05 -0500 (EST)
From: Ben LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
        Manfred Spraul <manfred@colorfullife.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: x86 ptep_get_and_clear question
In-Reply-To: <Pine.LNX.4.10.10102160936210.14020-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.30.0102161241040.17251-100000@today.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Feb 2001, Linus Torvalds wrote:

> How do you expect to ever see this in practice? Sounds basically
> impossible to test for this hardware race. The obvious "try to dirty as
> fast as possible on one CPU while doing an atomic get-and-clear on the
> other" thing is not valid - it's in fact quite likely to get into
> lock-step because of page table cache movement synchronization. And as
> such it could hide any race.

That's not the behaviour I'm testing, but whether the CPU is doing

lock
pte = *ptep
if (present && writable)
	pte |= dirty
*ptep = pte
unlock

versus

lock
pte = *ptep
pte |= dirty
*ptep = pte
unlock

Which can be tested by means of getting the pte into the tlb then changing
the pte without flushing and observing the results (page fault vs changed
pte).  I'm willing to bet that all cpus are doing the first version.

		-ben

