Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133068AbRDLImP>; Thu, 12 Apr 2001 04:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133069AbRDLImF>; Thu, 12 Apr 2001 04:42:05 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:47628 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S133068AbRDLIlp>;
	Thu, 12 Apr 2001 04:41:45 -0400
Date: Thu, 12 Apr 2001 10:41:33 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: John Alvord <jalvo@mbay.net>
Cc: george anzinger <george@mvista.com>, Mark Salisbury <gonar@mediaone.net>,
        mark salisbury <mbs@mc.com>,
        high-res-timers-discourse@lists.sourceforge.net,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        David Schleef <ds@schleef.org>, Jeff Dike <jdike@karaya.com>,
        schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: No 100 HZ timer !
Message-ID: <20010412104133.C25536@pcep-jamie.cern.ch>
In-Reply-To: <E14n2hi-0004ma-00@the-village.bc.nu> <20010410202416.A21512@pcep-jamie.cern.ch> <3AD35EFB.40ED7810@mvista.com> <3AD366DC.478E4AF@mc.com> <3AD38464.A1F97AC8@mvista.com> <002a01c0c221$32703e60$6501a8c0@gonar.com> <20010411181101.B23974@pcep-jamie.cern.ch> <3AD48D81.6E7B23B1@mvista.com> <20010411205704.B24318@pcep-jamie.cern.ch> <3ad5ade8.18532709@mail.mbay.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3ad5ade8.18532709@mail.mbay.net>; from jalvo@mbay.net on Wed, Apr 11, 2001 at 07:21:38PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Alvord wrote:
> I bumped into a funny non-optimization a few years ago. A system with
> a timer queue like the above had been "optimized" by keeping old timer
> elements... ready for new tasks to link onto and activate. The
> granularity was 1 millsecond. Over time, all timer values from 0 to
> roughly 10 minutes had been used. That resulted in 60,000 permanent
> storage fragments laying about... a significant fragmentation problem.
> The end was a forced recycle every month or so.

This is the sort of thing that Linux does with slab, dentry, inode
caches and so on.  In theory the memory is reclaimed as required :-)

It's not a big issue with timers, as the timer elements are fixed size
structures that tend to be embedded in other structures.  So the
lifetime of the timer element is the same as the lifetime of the object
associated with the timer.

-- Jamie
