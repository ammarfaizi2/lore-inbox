Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263650AbTKKSR5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 13:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263653AbTKKSR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 13:17:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:60141 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263650AbTKKSRy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 13:17:54 -0500
Date: Tue, 11 Nov 2003 10:17:47 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Erik Jacobson <erikj@subway.americas.sgi.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: 2.6 /proc/interrupts fails on systems with many CPUs
In-Reply-To: <Pine.SGI.4.53.0311111116440.360387@subway.americas.sgi.com>
Message-ID: <Pine.LNX.4.44.0311111007350.30657-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Nov 2003, Erik Jacobson wrote:
> 
> I'm looking for suggestions on how to fix this.  I came up with one fix
> that seems to work OK for ia64.  I have attached it to this message.
> I'm looking for advice on what should be proposed for the real fix.

This is not the real fix.

Allowing people to use up vmalloc() space by opening the /proc files would 
be a major DoS attack. Not worth it.

Instead, just make /proc/interrupts use the proper _sequence_ things, so
that instead of trying to print out everything in one go, you have the
"s_next()" thing to print them out one at a time. The seqfile interfaces
will then do the rigth thing with blocking/caching, and you only need a
single page.

Al - do we have some good documentation of how to use the seq-file 
interface? 

In the meantime, without documentation, the best place to look is just at 
other examples. One such example would be the kernel/kallsyms.c case: see 
how it does s_start/s_show/s_next/s_stop (or /proc/slabinfo, or vmstat, or 
any number of them).

		Linus

