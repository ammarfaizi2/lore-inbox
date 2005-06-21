Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262221AbVFUSB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbVFUSB3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 14:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262222AbVFUSB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 14:01:28 -0400
Received: from gold.veritas.com ([143.127.12.110]:51784 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S262221AbVFUSB0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 14:01:26 -0400
Date: Tue, 21 Jun 2005 19:02:26 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Timur Tabi <timur.tabi@ammasso.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: get_user_pages() and shared memory question
In-Reply-To: <42B82DF2.2050708@ammasso.com>
Message-ID: <Pine.LNX.4.61.0506211840210.5784@goblin.wat.veritas.com>
References: <42B82DF2.2050708@ammasso.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 21 Jun 2005 18:01:25.0655 (UTC) FILETIME=[3DA2FA70:01C5768B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2005, Timur Tabi wrote:
> 
> Is it possible for a page of memory that's been "grabbed" with
> get_user_pages() to ever be allocated to another process?  I'm assuming the
> answer is no, but I have a specific case I want to ask about.
> 
> Let's say an application allocates some shared memory, and then calls into a
> driver which calls get_user_pages().  The driver exits without releasing the
> pages, so they now have a reference count on them.  Then the application
> deallocates the shared memory.  At this point, the virtual addresses
> disappear, and no process owns them, but the pages still have a reference
> count.
> 
> Another process now tries to allocate a shared memory buffer.  Is there any
> way that this new buffer can contain those pages that were grabbed with
> get_user_pages() (i.e. that already have a reference count)?

It depends on what you mean by allocate and deallocate.  If the second
process is attaching the same shared memory segment as the first process
had attached, then yes, its buffer will contain those very pages which
the driver erroneously failed to release.

> Until 2.6.7, there was a bug in the VM where a page that was grabbed with
> get_user_pages() could be swapped out.  Those of you familar with the OpenIB
> work know what I'm talking about.  Would that bug affect anything I'm talking
> about?

No.  That was a bug peculiar to anonymous memory,
whereas shared memory is treated like file cache.

Hugh
