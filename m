Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbUDHPf3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 11:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbUDHPf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 11:35:28 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:27266 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261982AbUDHPfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 11:35:17 -0400
Date: Thu, 8 Apr 2004 16:35:12 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrea Arcangeli <andrea@suse.de>
cc: James Bottomley <James.Bottomley@steeleye.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       <parisc-linux@parisc-linux.org>
Subject: Re: [parisc-linux] rmap: parisc __flush_dcache_page
In-Reply-To: <20040408151415.GB31667@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0404081626460.7248-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Apr 2004, Andrea Arcangeli wrote:
> On Thu, Apr 08, 2004 at 09:40:37AM -0500, James Bottomley wrote:
> > Whatever seems most convenient that won't impact the flushing fast path,
> > I suppose.  It's one of the hottest paths in the system since all data
> > transfers go through it for user visibility.
> 
> you'd need to take a semaphore there to be safe, so it's basically
> unfixable since you can't sleep or just trylock.

It's not fixable via the i_shared_sem, but we can add another layer
of spin_lock around the i_mmap* list/tree manipulations, one that
preprocesses away to nothing on all arches but parisc and arm, and
is used in their __flush_dcache_page.  *Not* the page_table_lock ;)
Unappealing, but a lot better than leaving them unsafe.

Hugh

