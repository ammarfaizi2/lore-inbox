Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262383AbTEFIRR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 04:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262430AbTEFIRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 04:17:17 -0400
Received: from dp.samba.org ([66.70.73.150]:18097 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262383AbTEFIRQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 04:17:16 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@digeo.com>
Cc: "David S. Miller" <davem@redhat.com>, rusty@rustcorp.com.au,
       dipankar@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kmalloc_percpu 
In-reply-to: Your message of "Mon, 05 May 2003 22:02:50 MST."
             <20030505220250.213417f6.akpm@digeo.com> 
Date: Tue, 06 May 2003 18:06:45 +1000
Message-Id: <20030506082948.B994D2C04C@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030505220250.213417f6.akpm@digeo.com> you write:
> "David S. Miller" <davem@redhat.com> wrote:
> >
> > I think you should BUG() if a module calls kmalloc_percpu() outside
> > of mod->init(), this is actually implementable.
> > 
> > Andrew's example with some module doing kmalloc_percpu() inside
> > of fops->open() is just rediculious.
> 
> crap.  Modules deal with per-device and per-mount objects.  If a module
> cannot use kmalloc_per_cpu on behalf of the primary object which it manages
> then the facility is simply not useful to modules.

No, the allocator is dog-slow.  If you want to use it on open, you
need a new allocator, not one that does a linear search for blocks.

> A case in point, which Rusty has twice mentioned, is the three per-mount
> fuzzy counters in the ext2 superblock.  And lo, ext2 cannot use the code in
> this patch, because people want to scale to 4000 mounts.

Well, 4000 will fit on 32-bit archs, easily.  Yes, it's a limit.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
