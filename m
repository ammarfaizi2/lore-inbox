Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbTKXXuZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 18:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbTKXXuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 18:50:24 -0500
Received: from ns.suse.de ([195.135.220.2]:25560 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261763AbTKXXuU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 18:50:20 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, mason@suse.com
Subject: Re: What exactly are the issues with 2.6.0-test10 preempt?
References: <20031124224514.56242.qmail@web40908.mail.yahoo.com.suse.lists.linux.kernel>
	<Pine.LNX.4.58.0311241452550.15101@home.osdl.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 25 Nov 2003 00:50:17 +0100
In-Reply-To: <Pine.LNX.4.58.0311241452550.15101@home.osdl.org.suse.lists.linux.kernel>
Message-ID: <p733ccdpbra.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:
> 
> The PAGEFREE debug option works well for page allocations, but the slab
> cache is not very amenable to it. For slab debugging, it would be
> wonderful if somebody made a _truly_ debugging slab allocator that didn't
> use the slab cache at all, but used the page allocator (and screw the fact
> that you use too much memory ;) instead.

One way to find slab corruptions qickly is to write a thrasher:
identify for which slab size the corruptions happens and then write a
small module that runs a thread that just allocates from that slab,
writes a pattern to it, sleeps a bit, and checks the pattern (allocate
multiple slabs to make it more effective). Repeat.

If you don't know the size cycle through the different cache sizes.

Me and Chris used that to track down some nasty corruptions on x86-64,
it is especially useful together with LTP which calls a lot of system
calls that could cause corruption.

-Andi
