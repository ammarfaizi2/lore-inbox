Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261885AbVF0HQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbVF0HQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 03:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbVF0HQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 03:16:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:2188 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261916AbVF0HN2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 03:13:28 -0400
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: VFS scalability (was: [rfc] lockless pagecache)
References: <42BF9CD1.2030102@yahoo.com.au> <42BFA014.9090604@yahoo.com.au>
From: Andi Kleen <ak@suse.de>
Date: 27 Jun 2005 09:13:27 +0200
In-Reply-To: <42BFA014.9090604@yahoo.com.au>
Message-ID: <p733br4w9uw.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> writes:

> This is with the filesystem mounted as noatime, so I can't work
> out why update_atime is so high on the list. I suspect maybe a
> false sharing issue with some other fields.

Did all the 64CPUs write to the same file?

Then update_atime was just the messenger - it is the first function
to read the inode so it eats the cache miss overhead.

Maybe adding a prefetch for it at the beginning of sys_read() 
might help, but then with 64CPUs writing to parts of the inode
it will always thrash no matter how many prefetches.

-Andi
