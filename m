Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264549AbTKNSSN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 13:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264551AbTKNSSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 13:18:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:26584 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264549AbTKNSSJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 13:18:09 -0500
Date: Fri, 14 Nov 2003 10:17:56 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jack Steiner <steiner@sgi.com>
cc: Andrew Morton <akpm@osdl.org>, Ravikiran G Thirumalai <kiran@in.ibm.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: hot cache line due to note_interrupt()
In-Reply-To: <20031114174535.GA30388@sgi.com>
Message-ID: <Pine.LNX.4.44.0311141015050.1861-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 14 Nov 2003, Jack Steiner wrote:
> > 
> > The note_interrupt() stuff is only useful for diagnosing mysterious lockups
> > (and hasn't proven useful for that, actually).  It should be disabled for
> > production use.
> 
> Probably too late for 2.6.0, but here is a patch that disables noirqdebug:

Why do people hate irqdebug?

Sure, there's some overhead on big machines, but there aren't that many of 
them, and you can just disable them for those.

The fact is, irqdebug _has_ resulted in a few reports where instead of a 
silent and total lock-up, the kernel just said "I'll disable this irq" and 
the machine continued limping along.

Which is a huge improvement, since otherwise especially newcomers really 
have nothing to even report. Just "it locked up at boot" is not very 
useful, while a "it said nobody cared about irq5 and now my PCMCIA card 
doesn't work" is a _huge_ cluebat.

It doesn't catch everything, but it doesn't really cost anything on any
normal machines either..

		Linus

