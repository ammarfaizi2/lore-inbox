Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032403AbWLGQuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032403AbWLGQuq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 11:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032406AbWLGQup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 11:50:45 -0500
Received: from smtp.osdl.org ([65.172.181.25]:43103 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032403AbWLGQuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 11:50:17 -0500
Date: Thu, 7 Dec 2006 08:49:02 -0800 (PST)
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
In-Reply-To: <20061206224207.8a8335ee.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0612070846550.3615@woody.osdl.org>
References: <1165125055.5320.14.camel@gullible> <20061203011625.60268114.akpm@osdl.org>
 <Pine.LNX.4.64N.0612051642001.7108@blysk.ds.pg.gda.pl>
 <20061205123958.497a7bd6.akpm@osdl.org> <6FD5FD7A-4CC2-481A-BC87-B869F045B347@freescale.com>
 <20061205132643.d16db23b.akpm@osdl.org> <adaac22c9cu.fsf@cisco.com>
 <20061205135753.9c3844f8.akpm@osdl.org> <Pine.LNX.4.64N.0612061506460.29000@blysk.ds.pg.gda.pl>
 <20061206075729.b2b6aa52.akpm@osdl.org> <Pine.LNX.4.64.0612060822260.3542@woody.osdl.org>
 <Pine.LNX.4.64.0612061719420.3542@woody.osdl.org> <20061206224207.8a8335ee.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Dec 2006, Andrew Morton wrote:
>
> But this will return to the caller if the callback is presently running on
> a different CPU.  The whole point here is to be able to reliably kill off
> the pending work so that the caller can free resources.

I mentioned that in one of the emails.

We do not _have_ the information to not do that. It simply doesn't exist. 
We can either wait for _all_ pending entries on the to complete (by 
waiting for the workqueue counters for added/removed to be the same), or 
we can have the race.

> Also, I worry that this code can run the callback on the caller's CPU. 

Right.

> Users of per-cpu workqueues can legitimately assume that each callback runs
> on the right CPU.

Not if they use this interface, they can't.

They asked for it, they get it. That's the unix philosophy. 

		Linus
