Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbTHTEfM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 00:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261701AbTHTEfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 00:35:12 -0400
Received: from holomorphy.com ([66.224.33.161]:10627 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261700AbTHTEfG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 00:35:06 -0400
Date: Tue, 19 Aug 2003 21:36:15 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: David Lang <david.lang@digitalinsight.com>,
       Eric St-Laurent <ericstl34@sympatico.ca>, linux-kernel@vger.kernel.org
Subject: Re: scheduler interactivity: timeslice calculation seem wrong
Message-ID: <20030820043615.GF4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Bill Davidsen <davidsen@tmr.com>,
	David Lang <david.lang@digitalinsight.com>,
	Eric St-Laurent <ericstl34@sympatico.ca>,
	linux-kernel@vger.kernel.org
References: <20030820004851.GD4306@holomorphy.com> <Pine.LNX.3.96.1030820000415.11300B-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1030820000415.11300B-100000@gatekeeper.tmr.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Aug 2003, William Lee Irwin III wrote:
>> This and/or mixed cpu speeds could make load balancing interesting on
>> SMP. I wonder who's tried. jejb?

On Wed, Aug 20, 2003 at 12:11:26AM -0400, Bill Davidsen wrote:
> Hum, I *guess* that if you are using some "mean time between dispatches"
> to tune time slice you could apply a CPU speed correction, but mixed speed
> SMP is too corner a case for me. I think if you were tuning time slice by
> mean time between dispatches (or similar) you could either apply a
> correction, set affinity low to keep jobs changing CPUs, or just ignore
> it.

Not corner case at all. It's very typical with incrementally upgradeable
hardware (it would be very nice if commodity hardware were so, as it's
very wasteful to have to throw out preexisting hardware just to upgrade).
Conceptually what has to be done is very simple: pressure on cpus needs
to be weighted by cpu speed. The question is about specifics, not concepts.

I've even seen a system "in the field" (basically operating in a server
capacity as opposed to being a kernel hacking vehicle) with cpu speeds
ranging from 180MHz to 900MHz, with about 3 or 4 points in between.


On Wed, Aug 20, 2003 at 12:11:26AM -0400, Bill Davidsen wrote:
> The thing I like about the idea is that if the CPU speed changes the MTBD
> will change and the timeslice will compensate. You could use median MTBD,
> or pick some percentile to tune for response or throughput.
> I thought I was just thinking out loud, but it does sound interesting to
> try, since it would not prevent using some priorities as well.

Conceptually this is simple, too: take some tuning method based on cpu
speed and periodically (or possibly in an event-driven fashion) re-tune.
Again, this question's about the specifics, not the concept.


-- wli
