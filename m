Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbVLMLec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbVLMLec (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 06:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbVLMLeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 06:34:31 -0500
Received: from mx1.redhat.com ([66.187.233.31]:31452 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750764AbVLMLeb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 06:34:31 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <974.1134472981@warthog.cambridge.redhat.com> 
References: <974.1134472981@warthog.cambridge.redhat.com>  <439E1381.2060201@yahoo.com.au> <dhowells1134431145@warthog.cambridge.redhat.com> 
To: David Howells <dhowells@redhat.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, torvalds@osdl.org, akpm@osdl.org,
       hch@infradead.org, arjan@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Tue, 13 Dec 2005 11:34:14 +0000
Message-ID: <1253.1134473654@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> > Any reason why you're setting up your own style of waitqueue in
> > mutex-simple.c instead of just using the kernel's style of waitqueue?
> 
> Because I can steal the code from FRV's semaphores or rw-semaphores, and this
> way I can be sure of what I'm doing.

And because:

	struct mutex {
		int			state;
		wait_queue_head_t	wait_queue;
	};

Wastes 8 more bytes of memory than:

	struct mutex {
		int			state;
		spinlock_t		wait_lock;
		struct list_head	wait_list;
	};

on a 64-bit machine if spinlock_t is 4 bytes. Both waste 4 bytes if spinlock_t
is 8 bytes.

David
