Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274839AbTHKWPY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 18:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274857AbTHKWPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 18:15:24 -0400
Received: from holomorphy.com ([66.224.33.161]:23723 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S274839AbTHKWPU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 18:15:20 -0400
Date: Mon, 11 Aug 2003 15:16:28 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.0-test3-mm1
Message-ID: <20030811221628.GR1715@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20030811113943.47e5fd85.akpm@osdl.org> <873510000.1060633024@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873510000.1060633024@flay>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 01:17:04PM -0700, Martin J. Bligh wrote:
> Buggered if I know what Letext is doing there ???
>       6577     3.9% total
>       1157     0.0% Letext
>        937     0.0% direct_strnlen_user
>        748   440.0% filp_close
>        722    21.2% __copy_from_user_ll
>        610     2.6% page_remove_rmap
>        492   487.1% file_ra_state_init
>        452    12.4% find_get_page
>        405     7.6% __copy_to_user_ll
>        402    28.6% schedule
>        386     0.0% kpmd_ctor
>        348     4.4% __d_lookup
>        310    16.6% atomic_dec_and_lock
>        300   174.4% may_open

You can figure out what it is by reading addresses directly out of
/proc/profile that would correspond to it (i.e. modifying readprofile)
and correlating it with an area of text in a disassembled kernel.

kpmd_ctor() is unusual; how many runs does this profile represent?
Does it represent the first run? Ideally, all your kernel pmd's should
be cached. If it's not the first run, then logged slab cache statistics
would be interesting to determine whether this is still the case even
while effective cacheing is going on or whether slab cache reaping is
blowing these things away (i.e. either ineffective cacheing is happening
or for some reason cacheing them isn't good enough).

Of course, it would probably be better to deal with first-order effects
first. On that note, how many profile hits total? How many runs is this
summed together from? Which run is this (numerically in the order you
ran them) if the profiles are from only one run?


-- wli
