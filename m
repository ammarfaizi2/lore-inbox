Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263126AbUDLVKn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 17:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbUDLVKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 17:10:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:37052 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263126AbUDLVKf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 17:10:35 -0400
Date: Mon, 12 Apr 2004 14:12:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: vrajesh@umich.edu, hugh@veritas.com, andrea@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] anobjrmap 9 priority mjb tree
Message-Id: <20040412141244.5e225cdf.akpm@osdl.org>
In-Reply-To: <69200000.1081804458@flay>
References: <Pine.LNX.4.44.0404122006050.10504-100000@localhost.localdomain>
	<Pine.LNX.4.58.0404121531580.15512@red.engin.umich.edu>
	<69200000.1081804458@flay>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> Turns out he'd turned the
> locking in find_get_page from "spin_lock(&mapping->page_lock)" into
> "spin_lock_irq(&mapping->tree_lock)",

That's from the use-radix-tree-walks-for-writeback code.

Use oprofile - it's NMI-based.

> and I'm using readprofile, which
> doesn't profile with irqs off, so it's not really disappeared, just hidden.
> Not sure which sub-patch that comes from, and it turned out to be a bit of
> a dead end, but whilst I'm there, I thought I'd point out this was contended,
> and show the diffprofile with and without spinline for aa5:
> 
>      22210  246777.8% find_trylock_page
>       2538    36.4% atomic_dec_and_lock

profiler brokenness, surely.  Almost nothing calls find_trylock_page(),
unless Andrea has done something peculiar.  Use oprofile.
