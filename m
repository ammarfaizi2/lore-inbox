Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317078AbSG3SMQ>; Tue, 30 Jul 2002 14:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317309AbSG3SMQ>; Tue, 30 Jul 2002 14:12:16 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22020 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317078AbSG3SMP>; Tue, 30 Jul 2002 14:12:15 -0400
Date: Tue, 30 Jul 2002 11:15:26 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: Jeff Dike <jdike@karaya.com>, Andrea Arcangeli <andrea@suse.de>,
       Christoph Hellwig <hch@infradead.org>, <linux-kernel@vger.kernel.org>,
       <linux-aio@kvack.org>
Subject: Re: async-io API registration for 2.5.29
In-Reply-To: <20020730140939.F10315@redhat.com>
Message-ID: <Pine.LNX.4.33.0207301114001.2534-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 30 Jul 2002, Benjamin LaHaise wrote:

> On Tue, Jul 30, 2002 at 02:10:35PM -0500, Jeff Dike wrote:
> > We did come up with a scheme that sounded to me like it would work.
> 
> A constant address is still an option with an mmap'd device.  Just do 
> an mmap of the device and assert that it is the correct value.

That still doesn't get the TLB advantages of a globally shared page at the
same address.. It also has the overhead of mapping it, which you don't
have if the thing is just always in the address space, and all processes
just get created with that page mapped. That can be a big deal for process
startup latency for small processes.

		Linus

