Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262905AbSLBAyY>; Sun, 1 Dec 2002 19:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262937AbSLBAyY>; Sun, 1 Dec 2002 19:54:24 -0500
Received: from fep02-svc.mail.telepac.pt ([194.65.5.201]:26610 "EHLO
	fep02-svc.mail.telepac.pt") by vger.kernel.org with ESMTP
	id <S262905AbSLBAyX>; Sun, 1 Dec 2002 19:54:23 -0500
Date: Mon, 2 Dec 2002 01:01:44 +0000
From: Nuno Monteiro <nuno@itsari.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Exaggerated swap usage
Message-ID: <20021202010144.GA728@hobbes.itsari.int>
References: <20021130182345.GA21410@lnuxlab.ath.cx> <20021130184317.GH28164@dualathlon.random> <20021201075921.GC2483@jerry.marcet.dyndns.org> <20021201103643.GL28164@dualathlon.random> <20021201143713.GA871@hobbes.itsari.int> <20021202002108.GQ28164@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20021202002108.GQ28164@dualathlon.random>; from andrea@suse.de on Mon, Dec 02, 2002 at 00:21:08 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.12.02 00:21 Andrea Arcangeli wrote:
> 
> ok, now it's clear what the problem is. there are inuse-dirty inodes
> that triggers a deadlock in the schedule-capable
> try_to_sync_unused_inodes of 2.4.20rc2aa1 (that avoided me to backout an
> otherwise corrupt lowlatency fix). It can trigger only in UP,
> in SMP the other cpu can always run kupdate that will flush all dirty
> inodes, so it would lockup one cpu as worse for 2.5 sec, this is
> probably why I couldn't reproduce it, I assume all of you reproducing
> the deadlock were running on an UP machine (doesn't matter if the kernel
> was compiled for SMP or not).
> 
> Can you give a spin to this untested incremental fix?

[snip snip]


Yes, this does the trick for me. With this fix it survived the last 30m 
of torture (consisting of make -j4 bzImage, a gcc build plus 2 mozillas 
and 1 OpenOffice.org word processor, bear in mind it is only a P200 box) 
blissfully -- previously it took only 15 seconds with a 1/3 that load to 
lock up. So, this patch definitely cures it.


	Nuno

