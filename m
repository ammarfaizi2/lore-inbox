Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264003AbTHZGgl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 02:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263678AbTHZGgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 02:36:41 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:37705 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S264848AbTHZGgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 02:36:39 -0400
Date: Tue, 26 Aug 2003 02:36:36 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: rusty@rustcorp.com.au, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] Futex non-page-pinning fix
In-Reply-To: <20030825231449.7de28ba6.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0308260233550.20822-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 25 Aug 2003, Andrew Morton wrote:

> Ingo Molnar <mingo@redhat.com> wrote:
> >
> > The
> >  kernel doesnt in fact know about the first use of a futex: no-contention
> >  futexes have zero kernel footprint. This is the big plus of them. So i'd
> >  really favor some sort of hashing method and no limits, that way the Linux
> >  VM is extended and every VM address is waitable and wakable on - a pretty
> >  powerful concept.
> 
> What about the option of not pinning the pages at all: just fault
> them in when required?

precisely what scheme do you mean by this? There are two important points:  
when a thread sleeps on a futex, and when some thread does a wakeup on a
futex address. We cannot hash the futex based on the virtual address
(arbitrary share-ability of futex pages is another key appeal of them),
and if by the time the wakeup happens the physical page goes away how do
we find which threads are queued on this address?

	Ingo


