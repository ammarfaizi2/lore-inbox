Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274883AbTHKWrj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 18:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274955AbTHKWrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 18:47:39 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:37267 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S274883AbTHKWrf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 18:47:35 -0400
Date: Mon, 11 Aug 2003 15:50:29 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.0-test3-mm1
Message-ID: <884580000.1060642229@flay>
In-Reply-To: <20030811221628.GR1715@holomorphy.com>
References: <20030811113943.47e5fd85.akpm@osdl.org> <873510000.1060633024@flay> <20030811221628.GR1715@holomorphy.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Aug 11, 2003 at 01:17:04PM -0700, Martin J. Bligh wrote:
>> Buggered if I know what Letext is doing there ???
>>       6577     3.9% total
>>       1157     0.0% Letext
>>        937     0.0% direct_strnlen_user
>>        748   440.0% filp_close
>>        722    21.2% __copy_from_user_ll
>>        610     2.6% page_remove_rmap
>>        492   487.1% file_ra_state_init
>>        452    12.4% find_get_page
>>        405     7.6% __copy_to_user_ll
>>        402    28.6% schedule
>>        386     0.0% kpmd_ctor
>>        348     4.4% __d_lookup
>>        310    16.6% atomic_dec_and_lock
>>        300   174.4% may_open
> 
> You can figure out what it is by reading addresses directly out of
> /proc/profile that would correspond to it (i.e. modifying readprofile)
> and correlating it with an area of text in a disassembled kernel.

Was more interested in which patch screwed up the profiling really ...
I suspect someone knows already ;-)
 
> kpmd_ctor() is unusual; how many runs does this profile represent?
> Does it represent the first run? Ideally, all your kernel pmd's should
> be cached. If it's not the first run, then logged slab cache statistics
> would be interesting to determine whether this is still the case even
> while effective cacheing is going on or whether slab cache reaping is
> blowing these things away (i.e. either ineffective cacheing is happening
> or for some reason cacheing them isn't good enough).

It's the average of 5 runs, after an initial warmup run which is discarded.

> Of course, it would probably be better to deal with first-order effects
> first. On that note, how many profile hits total? How many runs is this
> summed together from? Which run is this (numerically in the order you
> ran them) if the profiles are from only one run?

See above.

M.

