Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317898AbSHPB5C>; Thu, 15 Aug 2002 21:57:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317945AbSHPB5C>; Thu, 15 Aug 2002 21:57:02 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:62456 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S317898AbSHPB5B>; Thu, 15 Aug 2002 21:57:01 -0400
Date: Thu, 15 Aug 2002 22:00:54 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Pavel Machek <pavel@elf.ucw.cz>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: aio-core why not using SuS? [Re: [rfc] aio-core for 2.5.29 (Re: async-io API registration for 2.5.29)]
Message-ID: <20020815220054.J29874@redhat.com>
References: <1028223041.14865.80.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0208010924050.14765-100000@home.transmeta.com> <20020801140112.G21032@redhat.com> <20020815235459.GG14394@dualathlon.random> <20020815214225.H29874@redhat.com> <20020816015717.GJ14394@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020816015717.GJ14394@dualathlon.random>; from andrea@suse.de on Fri, Aug 16, 2002 at 03:57:17AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2002 at 03:57:17AM +0200, Andrea Arcangeli wrote:
> you're saying you prefer glibc to wrap the aio_read/write/fsync and to
> redirect all them to lio_listio after converting the iocb from user API to
> kernel API, right? still I don't see why should we have different iocb,
> I would understsand if you say we should simply overwrite aio_lio_opcode
> inside the aio_read(3) inside glibc and to pass it over to kernel with a
> single syscalls if it's low cost to just set the lio_opcode, but having
> different data structures doesn't sounds the best still. I mean, it
> would be nicer if things would be more consistent.

The iocb is as minimally different from the posix aio api as possible.  The 
main reason for the difference is that struct sigevent is unreasonably huge.  
A lightweight posix aio implementation on top of the kernel API shares the 
fields between the kernel iocb and the posix aiocb.

> I don't see how the flushing flood is related to this, this is a normal
> syscall, any issue that applies to these aio_read/write/fsync should
> apply to all other syscalls too. Also the 4G starvation will be more
> likely fixed by x86-64 or in software by using a softpagesize larger
> than 4k so that the mem_map array doesn't load all the zone_normal.

A 4G/4G split flushes the TLB on every syscall.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
