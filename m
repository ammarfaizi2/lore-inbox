Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbUDHQNZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 12:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261991AbUDHQNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 12:13:25 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:41384
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261899AbUDHQNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 12:13:24 -0400
Date: Thu, 8 Apr 2004 18:13:22 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       parisc-linux@parisc-linux.org
Subject: Re: [parisc-linux] rmap: parisc __flush_dcache_page
Message-ID: <20040408161322.GE31667@dualathlon.random>
References: <20040408151415.GB31667@dualathlon.random> <Pine.LNX.4.44.0404081626460.7248-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0404081626460.7248-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2004 at 04:35:12PM +0100, Hugh Dickins wrote:
> It's not fixable via the i_shared_sem, but we can add another layer

I meant it's unfixable unless we change the VM common code.

> of spin_lock around the i_mmap* list/tree manipulations, one that
> preprocesses away to nothing on all arches but parisc and arm, and
> is used in their __flush_dcache_page.  *Not* the page_table_lock ;)

I'd prefer to use only a spinlock then to carry around two overlapping
locks, the need_resched() check is needed anyways even with preempt in
the real costly paths.
