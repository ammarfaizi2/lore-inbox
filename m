Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbUCAUql (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 15:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbUCAUql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 15:46:41 -0500
Received: from ns.suse.de ([195.135.220.2]:21979 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261423AbUCAUqk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 15:46:40 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: yi.zhu@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [start_kernel] Suggest to move parse_args() before trap_init()
References: <Pine.LNX.4.44.0403011721220.2367-100000@mazda.sh.intel.com>
	<20040301025637.338f41cf.akpm@osdl.org>
From: Andi Kleen <ak@suse.de>
Date: 01 Mar 2004 21:46:38 +0100
In-Reply-To: <20040301025637.338f41cf.akpm@osdl.org.suse.lists.linux.kernel>
Message-ID: <p73vfloz45t.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> I think the only problem with this is if we get a fault during
> parse_args(), the kernel flies off into outer space.  So you lose some
> debuggability when using an early console.
> 
> But 2.4 does trap_init() after parse_args() and nobody has complained, as
> did 2.6 until recently.  So the change is probably OK.

The standard way to fix this is to add an explicit check for lapic
to the early argument parsing in setup.c (but keep the __setup so that
no unknown argument is reported).

I think that's better than moving it and getting possible bugs that cannot
even be catched with early printk.

Another way that i've considered on x86-64 for 2.7 at least is a special
__early_setup() for this

-Andi
