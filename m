Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267393AbUHJBiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267393AbUHJBiM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 21:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267386AbUHJBiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 21:38:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22495 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267394AbUHJBhB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 21:37:01 -0400
Date: Mon, 9 Aug 2004 21:36:55 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@dhcp83-102.boston.redhat.com
To: John Richard Moser <nigelenki@comcast.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Locking scheme to block less
In-Reply-To: <41181909.3070702@comcast.net>
Message-ID: <Pine.LNX.4.44.0408092133390.25913-100000@dhcp83-102.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Aug 2004, John Richard Moser wrote:

> Currently, the kernel uses only spin_locks,

Oh ?   Haven't you seen the read/write locks in
include/linux/spinlock.h or the lockless synchronisation
provided by include/linux/rcu.h ?

> If the kernel provided a read-write locking semaphore,

Funny, it does.  You're not looking at a 2.0 kernel, are
you?

> spin_read_to_write_lock(spin_rwlock_t *lock);

> A read_to_write lock will block two such operations from occuring 
> concurrently, while still allowing read only operations AND still being 
> blocked when switched to write mode by both read and write operations.

In fact, two threads trying to upgrade their read lock to a
write lock simultaneously will block EACH OTHER, FOREVER.

Sounds like an exceedingly bad idea to me ;)

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

