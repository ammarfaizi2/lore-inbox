Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163179AbWLGS2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163179AbWLGS2k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 13:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163181AbWLGS2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 13:28:39 -0500
Received: from smtp.osdl.org ([65.172.181.25]:53914 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1163179AbWLGS2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 13:28:38 -0500
Date: Thu, 7 Dec 2006 10:27:10 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: David Howells <dhowells@redhat.com>,
       "Maciej W. Rozycki" <macro@linux-mips.org>,
       Roland Dreier <rdreier@cisco.com>,
       Andy Fleming <afleming@freescale.com>,
       Ben Collins <ben.collins@ubuntu.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Export current_is_keventd() for libphy
In-Reply-To: <20061207101605.ba446f79.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0612071022210.3615@woody.osdl.org>
References: <1165125055.5320.14.camel@gullible> <20061203011625.60268114.akpm@osdl.org>
 <Pine.LNX.4.64N.0612051642001.7108@blysk.ds.pg.gda.pl>
 <20061205123958.497a7bd6.akpm@osdl.org> <6FD5FD7A-4CC2-481A-BC87-B869F045B347@freescale.com>
 <20061205132643.d16db23b.akpm@osdl.org> <adaac22c9cu.fsf@cisco.com>
 <20061205135753.9c3844f8.akpm@osdl.org> <Pine.LNX.4.64N.0612061506460.29000@blysk.ds.pg.gda.pl>
 <20061206075729.b2b6aa52.akpm@osdl.org> <Pine.LNX.4.64.0612060822260.3542@woody.osdl.org>
 <Pine.LNX.4.64.0612061719420.3542@woody.osdl.org> <20061206224207.8a8335ee.akpm@osdl.org>
 <Pine.LNX.4.64.0612070846550.3615@woody.osdl.org> <20061207095253.30059224.akpm@osdl.org>
 <Pine.LNX.4.64.0612071000380.3615@woody.osdl.org> <20061207101605.ba446f79.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Dec 2006, Andrew Morton wrote:
> 
> We _can_ trust it in the context of
> 
> 	void flush_work(struct work_struct *work)

Yes, but the way the bits are defined, the "pending" bit is not meaningful 
as a synchronization event, for example - because _other_ users can't 
trust it once they've dispatched the function. So even in the synchronous 
run/flush_scheduled_work() kind of situation, you end up having to work 
with the fact that nobody _else_ can rely on the data structures, and that 
they are designed to work that way..

> ho-hum.  I'll take a look at turning that into something which compiles,
> then I'll convert a few oft-used flush_scheduled_work() callers over to use
> it.  To do this on a sensible timescale perhaps means that we should export
> current_is_keventd(), get the howling hordes off our backs.

Well, I simply committed my work that doesn't guarantee synchronization - 
the synchronization can now be added in kernel/workqueue.c any way we 
want. It's better than what we used to have, for sure, in both compiling 
and solving the practical problem, but also as a "go forward" point.

			Linus
