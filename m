Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261677AbULNWT3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbULNWT3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 17:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbULNWTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 17:19:15 -0500
Received: from fw.osdl.org ([65.172.181.6]:62182 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261718AbULNWSh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 17:18:37 -0500
Date: Tue, 14 Dec 2004 14:18:13 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Roland McGrath <roland@redhat.com>
cc: Ulrich Drepper <drepper@redhat.com>, Christoph Lameter <clameter@sgi.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] cpu-timers: high-resolution CPU clocks for POSIX
 clock_* syscalls
In-Reply-To: <200412142150.iBELoJc0011582@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.58.0412141410150.3279@ppc970.osdl.org>
References: <200412142150.iBELoJc0011582@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 14 Dec 2004, Roland McGrath wrote:
>
> I believe Christoph may have been referring exclusively to the per-process
> clocks, not the per-thread clocks.

Please do not confuse things.

There still are no such things as "threads" vs "processes" as far as the 
kernel is concerned.

They are all the same thing, and they are all threads or processes or
whatever you want to call them. I've tried to call them "contexts of
execution" just to clarify the fact that they are _not_ threads of
processes. And they all have a unified ID space.

They just happen to share different things. We should try to avoid at all
cost to take on stupidities from legacy systems. We've got a unified
process/thread/whatever space, and that's a good thing.

Yes, when you share the signal state (and you have to share the VM and
signal handlers to do so), you end up looking like a pthreads "process".
But dammit, people should NOT think that that is all that special from a
kernel standpoint.

And no kernel interface should really care about some pthreads rules. The 
interfaces should work with old linux-threads, and with pure "clone()" 
things too.

Of course, in this case, it's doubtful whether we want to expose non-local
clocks to anybody else, making the whole point pretty moot. I'd vote for
not exposing them any more than necessary (ie the current incidental "ps"  
interface is quite enough), at least until somebody can come up with a
very powerful example of why exposing them is a good idea.

		Linus
