Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268317AbUHXVEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268317AbUHXVEQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 17:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268326AbUHXVEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 17:04:16 -0400
Received: from av7-1-sn4.m-sp.skanova.net ([81.228.10.110]:14829 "EHLO
	av7-1-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S268317AbUHXVEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 17:04:10 -0400
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Speed up the cdrw packet writing driver
References: <m33c2py1m1.fsf@telia.com> <20040823114329.GI2301@suse.de>
	<m3llg5dein.fsf@telia.com> <20040824202951.GA24280@suse.de>
From: Peter Osterlund <petero2@telia.com>
Date: 24 Aug 2004 23:04:07 +0200
In-Reply-To: <20040824202951.GA24280@suse.de>
Message-ID: <m3hdqsckoo.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> writes:

> On Mon, Aug 23 2004, Peter Osterlund wrote:
> > Jens Axboe <axboe@suse.de> writes:
> > 
> > > On Sat, Aug 14 2004, Peter Osterlund wrote:
> > > > 
> > > > This patch replaces the pd->bio_queue linked list with an rbtree.  The
> > > > list can get very long (>200000 entries on a 1GB machine), so keeping
> > > > it sorted with a naive algorithm is far too expensive.
> > > 
> > > It looks like you are assuming that bio->bi_sector is unique which isn't
> > > necessarily true. In that respect, list -> rbtree conversion isn't
> > > trivial (or, at least it requires extra code to handle this).
> > 
> > I don't think that is assumed anywhere.
> > 
> > [...]
> 
> You are right, the code looks fine indeed. The bigger problem is
> probably that a faster data structure is needed at all, having hundreds
> of thousands bio's pending for a packet writing device is not nice at
> all.

Why is it not nice? If the VM has decided to create 400MB of dirty
data on a DVD+RW packet device, I don't see a problem with submitting
all bio's at the same time to the packet device.

The situation happened when I dumped >1GB of data to a DVD+RW disc on
a 1GB RAM machine. For some reason, the number of pending bio's didn't
go much larger than 200000 (ie 400MB) even though it could probably
have gone to 800MB without swapping. The machine didn't feel
unresponsive during this test.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
