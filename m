Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272444AbTHEFBo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 01:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272445AbTHEFBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 01:01:44 -0400
Received: from holomorphy.com ([66.224.33.161]:2690 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S272444AbTHEFBn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 01:01:43 -0400
Date: Mon, 4 Aug 2003 22:02:50 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Valdis.Kletnieks@vt.edu
Cc: Nick Piggin <piggin@cyberone.com.au>, Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] O11int for interactivity
Message-ID: <20030805050250.GP32488@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Valdis.Kletnieks@vt.edu, Nick Piggin <piggin@cyberone.com.au>,
	Con Kolivas <kernel@kolivas.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <200308042106.51676.m.c.p@wolk-project.de> <20030804195335.GK32488@holomorphy.com> <3F2F00B0.9050804@cyberone.com.au> <20030805024103.GM32488@holomorphy.com> <3F2F1F80.7060207@cyberone.com.au> <20030805031341.GN32488@holomorphy.com> <3F2F231C.3030901@cyberone.com.au> <20030805033119.GO32488@holomorphy.com> <3F2F26BA.3060904@cyberone.com.au> <200308050454.h754sBqM004950@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308050454.h754sBqM004950@turing-police.cc.vt.edu>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Aug 2003 13:38:34 +1000, Nick Piggin said:
>> Of course some minimum read _latency_ would be required: this
>> could actually be done easily with strace come to think of it.
>> Maybe some xmms mapped memory is being swapped out? But that
>> would be more of a VM problem.

On Tue, Aug 05, 2003 at 12:54:10AM -0400, Valdis.Kletnieks@vt.edu wrote:
> I was seeing some CPU-related pauses, but once Con's work got to O7 or so,
> those disappeared.   I'm *quite* convinced that the remaining glitches
> are VM related, mostly because every glitch seems to be associated with
> an increase in the 'pswpout' field in /proc/vmstat (yes, I tested
> with stuff like "for (;;)  do cat /proc/vmstat; sleep 1 done;".

Could I get logs of the stuff?


On Tue, Aug 05, 2003 at 12:54:10AM -0400, Valdis.Kletnieks@vt.edu wrote:
> The *odd* part is that the pgpgin, pgpgout, and pswpin numbers do
> *NOT* seem to be correlated.  High I/O loads from read/write don't
> seem to cause a problem - untarring the Linux distro won't do it,
> running badblocks won't do it. But if somebody has to swap out, all
> hell breaks loose...

Is the swapfile/partition on the same disk as the music? Is the disk IDE?


On Tue, Aug 05, 2003 at 12:54:10AM -0400, Valdis.Kletnieks@vt.edu wrote:
> Hmm.. looking at mm/page_io.c, it seems swap_writepage() calls
> get_swap_bio with GFP_NOIO, while readdpage() uses GFP_KERNEL. I
> wonder if that GFP_NOIO is causing ugliness - that's really
> __GFP_WAIT, and the comments in bio_alloc() are pretty clear that it
> can block.  And remember we're not getting into this code unless
> we're already under memory pressure....
> (And if somebody tells me how to instrument a -test2-mm4 kernel so I
> can tell if I'm on crack or not, I'll happily do so....)

Well, sleepometer is around, but probably needs merging.


-- wli
