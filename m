Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132619AbRDKQL3>; Wed, 11 Apr 2001 12:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132618AbRDKQLT>; Wed, 11 Apr 2001 12:11:19 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:41486 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S132619AbRDKQLK>;
	Wed, 11 Apr 2001 12:11:10 -0400
Date: Wed, 11 Apr 2001 18:11:01 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Mark Salisbury <gonar@mediaone.net>
Cc: george anzinger <george@mvista.com>, mark salisbury <mbs@mc.com>,
        high-res-timers-discourse@lists.sourceforge.net,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        David Schleef <ds@schleef.org>, Jeff Dike <jdike@karaya.com>,
        schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: No 100 HZ timer !
Message-ID: <20010411181101.B23974@pcep-jamie.cern.ch>
In-Reply-To: <20010410193521.A21133@pcep-jamie.cern.ch> <E14n2hi-0004ma-00@the-village.bc.nu> <20010410202416.A21512@pcep-jamie.cern.ch> <3AD35EFB.40ED7810@mvista.com> <3AD366DC.478E4AF@mc.com> <3AD38464.A1F97AC8@mvista.com> <002a01c0c221$32703e60$6501a8c0@gonar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <002a01c0c221$32703e60$6501a8c0@gonar.com>; from gonar@mediaone.net on Tue, Apr 10, 2001 at 08:48:52PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Salisbury wrote:
> > The complexity comes in when you want to maintain indexes into the list
> > for quick insertion of new timers.  To get the current insert
> > performance, for example, you would need pointers to (at least) each of
> > the next 256 centasecond boundaries in the list.  But the list ages, so
> > these pointers need to be continually updated.  The thought I had was to
> > update needed pointers (and only those needed) each time an insert was
> > done and a needed pointer was found to be missing or stale.  Still it
> > adds complexity that the static structure used now doesn't have.
> 
> actually, I think a head and tail pointer would be sufficient for most
> cases. (most new timers are either going to be a new head of list or a new
> tail, i.e. long duration timeouts that will never be serviced or short
> duration timers that are going to go off "real soon now (tm)")  the oddball
> cases would be mostly coming from user-space, i.e. nanosleep which a longerr
> list insertion disapears in the block/wakeup/context switch overhead

A pointer-based priority queue is really not a very complex thing, and
there are ways to optimise them for typical cases like the above.

-- Jamie
