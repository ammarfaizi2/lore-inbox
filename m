Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262634AbTHZF7A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 01:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262636AbTHZF67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 01:58:59 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:12358 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262634AbTHZF65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 01:58:57 -0400
Date: Tue, 26 Aug 2003 01:58:51 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: rusty@rustcorp.com.au, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] Futex non-page-pinning fix
In-Reply-To: <20030825225011.2ad47c85.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0308260155490.1912-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 25 Aug 2003, Andrew Morton wrote:

> > but if all futexes pin down one page (worst-case), then to make it really
> >  safe we'll have to use a fairly low default RLIM_NRFUTEX value - which
> >  will decrease the generic utility of futexes.
> 
> We could make it RLIM_NRFUTEX_PAGES: the number of pages which the user
> can pin via futexes, perhaps.

the problem is that this is not really a deterministic limit. The nr of
thread or open files limit is deterministic: it will either fail or
succeed at clone() or open() time - and can be freely used afterwards. The
kernel doesnt in fact know about the first use of a futex: no-contention
futexes have zero kernel footprint. This is the big plus of them. So i'd
really favor some sort of hashing method and no limits, that way the Linux
VM is extended and every VM address is waitable and wakable on - a pretty
powerful concept.

	Ingo

