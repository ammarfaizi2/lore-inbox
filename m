Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265051AbTLCQKx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 11:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265053AbTLCQKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 11:10:53 -0500
Received: from fw.osdl.org ([65.172.181.6]:28594 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265051AbTLCQKw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 11:10:52 -0500
Date: Wed, 3 Dec 2003 08:10:44 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Tigran Aivazian <tigran@veritas.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: bug in 2.4.22:  process left in 'T' state.
In-Reply-To: <Pine.LNX.4.44.0312031505520.1772-100000@einstein.homenet>
Message-ID: <Pine.LNX.4.58.0312030805050.5258@home.osdl.org>
References: <Pine.LNX.4.44.0312031505520.1772-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Dec 2003, Tigran Aivazian wrote:
>
> Now, after tcpdump captured the two icmp packets I waited until strace
> showed it blocked in the next recvfrom() system call and pressed ^C to
> terminate strace. It did terminate, but it left tcpdump in the 'traced'
> state and I couldn't do anything to kill tcpdump from within (i.e. all
> SIGINTs were blocked).

"T" isn't "traced", it's "sTopped" ("S" was already taken by "Sleeping").

And yes, terminating strace unexpectedly sometimes seems to leave the
tracee stopped. I _think_ the bug might be the kernel (reparent_thread()
should probably do all the same things that "ptrace_detach()" does, namely
wake the thread up), but it has never bothered me enough for me to care
deeply enough to check.

You can wake up the tracee by hand with a "kill -CONT pid".

If you dig into this and decide to fix the kernel, holler.

		Linus
