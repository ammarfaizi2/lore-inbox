Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbWEWBLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWEWBLv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 21:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbWEWBLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 21:11:50 -0400
Received: from THUNK.ORG ([69.25.196.29]:55784 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750761AbWEWBLu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 21:11:50 -0400
Date: Mon, 22 May 2006 21:11:23 -0400
From: Theodore Tso <tytso@mit.edu>
To: Arjan van de Ven <arjan@infradead.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add user taint flag
Message-ID: <20060523011123.GA32164@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Arjan van de Ven <arjan@infradead.org>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <E1FhwyO-0001YQ-O1@candygram.thunk.org> <1148307276.3902.71.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1148307276.3902.71.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2006 at 04:14:36PM +0200, Arjan van de Ven wrote:
> On Sun, 2006-05-21 at 19:04 -0400, Theodore Ts'o wrote:
> > Allow taint flags to be set from userspace by writing to
> > /proc/sys/kernel/tainted, and add a new taint flag, TAINT_USER, to be
> > used when userspace is potentially doing something naughty that might
> > compromise the kernel. 
> 
> we should then patch the /dev/mem driver or something to set this :)
> (well and possibly give it an exception for now for PCI space until the
> X people fix their stuff to use the proper sysfs stuff)

It may make sense to have an explicit taint flag which means direct
access to memory, via /dev/mem or otherwise, with exceptions for I/O
mapped memory not claimed by a device driver (and of course X until it
is fixed, or never, whichever comes first).

As I've mentioned, the original reason why I did this was because I
needed to mmap physical memory, which at the time when I originally
did things, /dev/mem didn't support except for the I/O mapped memory
range, and I assumed that any attempt to enhance /dev/mem's mmap()
capabilities in a patch intended for mainline wouldn't be looked at as
a friendly act.  In fact, I was so unhappy about being forced by the
RTSJ specification to do this insane thing that I wanted to make sure
that if it were ever used, it would set a TAINT flag to warn people
that just about anything unsane could have happened, and the system's
stability was at the mercy of the competence of Java application
programmers.  :-)

						- Ted
