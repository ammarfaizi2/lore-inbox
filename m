Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274842AbRJFBz1>; Fri, 5 Oct 2001 21:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274846AbRJFBzR>; Fri, 5 Oct 2001 21:55:17 -0400
Received: from zok.sgi.com ([204.94.215.101]:6379 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S274842AbRJFBzI>;
	Fri, 5 Oct 2001 21:55:08 -0400
Date: Fri, 5 Oct 2001 18:54:33 -0700
From: Jesse Barnes <jbarnes@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.10 classzone update buglet
Message-ID: <Pine.SGI.4.21.0110051844080.999395-100000@spamtin.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I work a little bit on some NUMA machines here at SGI and was somewhat
disappointed to see the 2.4.10 VM rewritten.  The reason is that I found a
small problem with the old VM that I was able to fix, but the fix doesn't
apply to the new VM.  I'll try my best to articulate the problem here and
maybe Andrea or some other VM guru can help me out with it.

Each node on one of our systems has a pg_data_t associated with it (no
surprise), and each pg_data_t as a zonelist associated with it.  Only one
zone has a non-zero length however, since all of our memory is
DMAable.  The problem is that when alloc_pages is called, it used to
eventually call free_shortage and inactive_shortage to see if any zone was
low on memory.  Since we really don't care too much at this point if any
*one* zone is low, I fixed up the routines.  I added a flag to zone_t to
specify whether or not a zone should be 'aggregated' across pg_data_t
objects.  On our arch, all the zones should be so aggregated, so
free/inactive_shortage didn't bother to look for local shortages if this
flag was set.  I'm not quite sure how this should be applied to 2.4.10
though.

Is there any easy way to do this sort of thing in 2.4.10?  I'd be happy to
write the code if someone can point me in the right direction.

Thanks,
Jesse

