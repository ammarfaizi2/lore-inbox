Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964772AbVLSPgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964772AbVLSPgR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 10:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbVLSPgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 10:36:17 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:31425 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932199AbVLSPgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 10:36:17 -0500
Date: Mon, 19 Dec 2005 10:35:24 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Christoph Hellwig <hch@infradead.org>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       Paul Jackson <pj@sgi.com>
Subject: Re: [patch 10/15] Generic Mutex Subsystem, mutex-migration-helper-core.patch
In-Reply-To: <20051219150007.GA9809@infradead.org>
Message-ID: <Pine.LNX.4.58.0512191026130.11583@gandalf.stny.rr.com>
References: <20051219013837.GF28038@elte.hu> <20051219150007.GA9809@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Dec 2005, Christoph Hellwig wrote:

> On Mon, Dec 19, 2005 at 02:38:37AM +0100, Ingo Molnar wrote:
> >
> > introduce the mutex_debug type, and switch the semaphore APIs to it in a
> > type-sensitive way. Plain semaphores will still use the proper
> > arch-semaphore calls.
>
> I think we shouldn't introduce this one.  It just encourages people to do
> really things.  Everything else in the patchseries looks sensible to me.

I believe that Ingo is adding the "arch_semaphore" temporarily mainly for
debugging. From Ingo's 00/15 email:

   once all semaphores have been safely categorized and converted to one
   group or another, and all out-of-tree codebases are fixed and a
   deprecation period has passed, we can rename arch_semaphores back to
   'struct semaphore'.

The arch_semaphore is not for a global change or to be what we call
semaphores from now on.  It is used as a place marker for debugging, until
we feel comfortable that we got all the places that need to be mutexes.
So with this arch_semaphore, we can hit a debug option that turns all non
arch_semaphores into mutexes and if it runs fine, we know we can change
them from semaphores to mutexes.

So once the system has been audit enuough, we remove both the mutex_debug
and the arch_semaphores, where all the remaining arch_semaphores become
semaphores, and those semaphores that were not arch_semaphores should have
become full mutexes.

-- Steve

