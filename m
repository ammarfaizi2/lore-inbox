Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263593AbTH0QCi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 12:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263553AbTH0QAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 12:00:36 -0400
Received: from holomorphy.com ([66.224.33.161]:33208 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263530AbTH0QA2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 12:00:28 -0400
Date: Wed, 27 Aug 2003 09:01:33 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Larry McVoy <lm@work.bitmover.com>,
       Peter Chubb <peterc@gelato.unsw.edu.au>, akpm@digeo.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0-test4 -- add context switch counters
Message-ID: <20030827160133.GD4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Larry McVoy <lm@work.bitmover.com>,
	Peter Chubb <peterc@gelato.unsw.edu.au>, akpm@digeo.com,
	linux-kernel@vger.kernel.org
References: <16204.520.61149.961640@wombat.disy.cse.unsw.edu.au> <20030827065435.GV4306@holomorphy.com> <20030827155246.GA23609@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030827155246.GA23609@work.bitmover.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 27, 2003 at 08:52:46AM -0700, Larry McVoy wrote:
> I normally hate ifdefs but this might be a good place to use a bunch of 
> macros and make them conditional on config_stats or something.  Updating
> counters is going to add to the size of the data cache footprint and it
> would be nice, for those people working on embedded low speed processors,
> if they could config this out.  I personally would leave it in, I like
> this stats.  I just know that the path to slowness is paved one cache
> miss at a time.

I've profiled this and know the memory stats don't do any harm; the
rest I'd have to see profiled. AFAICT all the damage is done after
ticking mm->rss in the various pagetable copying/blitting operations,
and once we've taken that hit (in mainline!) the other counters are
noise-level. The integral counters are another story; I've not seen
those in action.


-- wli
