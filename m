Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266011AbUGELFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266011AbUGELFt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 07:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266013AbUGELFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 07:05:49 -0400
Received: from almesberger.net ([63.105.73.238]:21003 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S266011AbUGELFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 07:05:48 -0400
Date: Mon, 5 Jul 2004 08:05:32 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Andrew Morton <akpm@osdl.org>
Cc: vrajesh@umich.edu, linux-kernel@vger.kernel.org
Subject: Re: prio_tree generalization
Message-ID: <20040705080532.B1453@almesberger.net>
References: <20040704222438.A11865@almesberger.net> <20040704214609.71b0084d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040704214609.71b0084d.akpm@osdl.org>; from akpm@osdl.org on Sun, Jul 04, 2004 at 09:46:09PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Offtopic, but that's a premature optmztn.

Hmm, maybe. But it's actually not so much more work to use a
tree than it is to use a linear list. Particularly prio_tree is
very light on its users, because - unlike with RB trees - you
don't have to code all the lookups.

It may actually be nice to have something like a set of
includable functions using some GET_INDEX macro also for RB
trees, to make the easy cases even easier to write.

> A disk isn't going to retire more than 100 requests/sec in practice, and
> the cost of an all-requests search is relatively small.

On admittedly not very impressive hardware (a 1.2 GHz Duron), I
see about 60-100 us processing time per request submission in a
random access test using kernel AIO, with elevators using mainly
RB trees, with nr_requests = 8192.

The 60 us are for my experimental elevator, the 100 us for
anticipatory, so most of that time really is spent in the
elevator.

So, a few ms per request don't seem too unlikely for a linear
search, combined with a larger-than-default queue. (It seems
that most people trying to optimize elevator performance are
using something in the nr_requests = 1000 range.)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
