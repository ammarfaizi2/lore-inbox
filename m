Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269031AbUINFV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269031AbUINFV7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 01:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269147AbUINFV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 01:21:59 -0400
Received: from holomorphy.com ([207.189.100.168]:5009 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269031AbUINFV1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 01:21:27 -0400
Date: Mon, 13 Sep 2004 22:21:18 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: raybry@sgi.com, jbarnes@engr.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [profile] amortize atomic hit count increments
Message-ID: <20040914052118.GA9106@holomorphy.com>
References: <20040913015003.5406abae.akpm@osdl.org> <20040914044748.GZ9106@holomorphy.com> <20040913220521.03d0e539.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040913220521.03d0e539.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>> read_proc_profile()
>>  does not flush the per-cpu hashtables because flushing may cause
>>  timeslice overrun on the systems where prof_buffer cacheline bounces
>>  are so problematic as to livelock the timer interrupt.

On Mon, Sep 13, 2004 at 10:05:21PM -0700, Andrew Morton wrote:
> That's a bit of a problem, isn't it?  As we can accumulate an arbitrarily
> large number of hits within the hash table is it not possible that the
> /proc/profile results could be grossly inaccurate?
> If you had two front-ends per cpu to the profiling buffer then the CPU
> which is running the /proc/profile read could tell all the other CPUs to
> flip to their alternate buffer and can then perform accumulation at its
> leisure.

This is superior to no flushing; I'll implement that and send out an
incremental update (or if preferred, an update of this patch).


On Mon, Sep 13, 2004 at 10:05:21PM -0700, Andrew Morton wrote:
> How does oprofile get around this?  I guess in most modes the CPUs are not
> synchronised.
> One wonders how long we should keep flogging the /prof/profile profiling
> code.  What systems are seeing this livelock?

The original bits were merely a consolidation extracted from a since-
dropped feature patch and an unrelated feature patch from mingo and
arjanv; this is an unrelated fix for SGI's stability issue on larger
Altixen. I personally intend to do no further adjustments.


-- wli
