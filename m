Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750957AbWBPVXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbWBPVXm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 16:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbWBPVXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 16:23:42 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:1495 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750880AbWBPVXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 16:23:41 -0500
Date: Thu, 16 Feb 2006 13:23:09 -0800
From: Paul Jackson <pj@sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, drepper@redhat.com, tglx@linutronix.de,
       arjan@infradead.org, akpm@osdl.org
Subject: Re: [patch 0/6] lightweight robust futexes: -V3
Message-Id: <20060216132309.fd4e4723.pj@sgi.com>
In-Reply-To: <20060216094130.GA29716@elte.hu>
References: <20060216094130.GA29716@elte.hu>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nice stuff ...

I wonder if some of the initial questions about whether gcc would be
forcing something on the kernel, and whether it was unsafe for the
kernel to be walking a user list, are distracting from a more
interesting (in my view) question.

One can view this as just another sort of "interesting" system call,
where user code puts some data in various register and memory
locations, and then ends up by some predictable path in kernel code
which is acting on the request encoded in that data.

As always with system calls:
 1) the kernel can't trust the user data any further than the user
    could have thrown it, and
 2) the interface needs a robust ABI and one or more language API's,
    which will stand the test of time, over various architectures
    and 32-64 emulations.

>From what I could see glancing at the code and comments, Ingo has (1)
covered easily enough.

Would it make sense to have a language independent specification of
this interface, providing a detailed ABI, suitably generalized to cover
the various big endian, little endian, 32 and 64 and cross environments
that Linux normally supports?

I have in mind something that a competent assembly language coder could
write to, directly, when coding user access to this facility?  Or some
other language or library implementor, besides C and glibc, could
develop to?

The biggest problem that I find in new and interesting ways for the
kernel to interact with user space is not thinking carefully through
and documenting in obscene detail the exact interface (this byte here
means this, that little endian quad there means thus, ...) for all
archs and emulations of interest.  This tends to result in some corner
cases that have warts which can never be fixed, in order to maintain
compatibility.

This is sort of like specifying the over the wire protocols the
internet, where each byte is spelled out, avoiding any assumption
of what sort of computing device is on the other end.  Well, not
quite that bad.  I guess we can assume the user code is running
on the same arch as the kernel, give or take possible word size
and endian emulations ... though if performance of this even from
within machine architecture emulators was a priority, even that
assumption is perhaps not desirable.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
