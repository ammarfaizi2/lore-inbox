Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263693AbTETKiF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 06:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263700AbTETKiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 06:38:04 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:62269 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263693AbTETKiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 06:38:02 -0400
Date: Tue, 20 May 2003 03:53:22 -0700
From: Andrew Morton <akpm@digeo.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, davidm@hpl.hp.com, dipankar@in.ibm.com
Subject: Re: [PATCH 1/3] Per-cpu UP unification
Message-Id: <20030520035322.27211c07.akpm@digeo.com>
In-Reply-To: <20030520012307.53A502C082@lists.samba.org>
References: <20030520012307.53A502C082@lists.samba.org>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 May 2003 10:50:56.0955 (UTC) FILETIME=[B158E0B0:01C31EBD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> wrote:
>
> [ Untested on ia64, but fairly trivial if I've broken something ].
> 
> Name: Unification of per-cpu headers for non-SMP
> Author: Rusty Russell
> Status: Trivial

I applied all these to the ppc64 kernel (you missed ppc64 btw) and it dies.

Quite late in boot, during floppy_init->init_disk_stats->alloc_percpu.

I'm reduced to debugging with printk on ppc64.  __alloc_percpu() calls
new_block(), loops around and then dies in here:


#define D() printk("at %s:%d\n", __FILE__, __LINE__)

			D();
			/* Transfer extra to previous block. */
			if (b->size[i-1] < 0)
				b->size[i-1] -= extra;
			else
				b->size[i-1] += extra;
			b->size[i] -= extra;
			ptr += extra;

			D();

Not sure what happened - no oops, no xmon, no sysrq, no nuthin.  It even
manages to lock up minicom on the other end of the cable.  Impressed.





