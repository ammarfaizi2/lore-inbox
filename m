Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317402AbSHPBxA>; Thu, 15 Aug 2002 21:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317898AbSHPBxA>; Thu, 15 Aug 2002 21:53:00 -0400
Received: from [195.223.140.120] ([195.223.140.120]:33104 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S317402AbSHPBw7>; Thu, 15 Aug 2002 21:52:59 -0400
Date: Fri, 16 Aug 2002 03:57:17 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Pavel Machek <pavel@elf.ucw.cz>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: aio-core why not using SuS? [Re: [rfc] aio-core for 2.5.29 (Re: async-io API registration for 2.5.29)]
Message-ID: <20020816015717.GJ14394@dualathlon.random>
References: <1028223041.14865.80.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0208010924050.14765-100000@home.transmeta.com> <20020801140112.G21032@redhat.com> <20020815235459.GG14394@dualathlon.random> <20020815214225.H29874@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020815214225.H29874@redhat.com>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2002 at 09:42:25PM -0400, Benjamin LaHaise wrote:
> Read it again.  You've totally missed lio_listio.  Also keep in mind what 

you're saying you prefer glibc to wrap the aio_read/write/fsync and to
redirect all them to lio_listio after converting the iocb from user API to
kernel API, right? still I don't see why should we have different iocb,
I would understsand if you say we should simply overwrite aio_lio_opcode
inside the aio_read(3) inside glibc and to pass it over to kernel with a
single syscalls if it's low cost to just set the lio_opcode, but having
different data structures doesn't sounds the best still. I mean, it
would be nicer if things would be more consistent.

> happens with 4G/4G split for x86 which are needed to address the kernel 
> virtual memory starvation issues.

I don't see how the flushing flood is related to this, this is a normal
syscall, any issue that applies to these aio_read/write/fsync should
apply to all other syscalls too. Also the 4G starvation will be more
likely fixed by x86-64 or in software by using a softpagesize larger
than 4k so that the mem_map array doesn't load all the zone_normal.
That'll break backwards compatibility w.r.t. to the page size offset but
it'll at least not generate a so significant performance regression for
syscall performance (again this is generic issue, not related to
async-io as far as I can tell).

Andrea
