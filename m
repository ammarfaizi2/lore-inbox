Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422702AbWJLOTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422702AbWJLOTJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 10:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422688AbWJLOTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 10:19:09 -0400
Received: from dingu.igconcepts.com ([208.23.225.7]:43467 "EHLO
	dingu.igconcepts.com") by vger.kernel.org with ESMTP
	id S1422702AbWJLOTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 10:19:07 -0400
Date: Thu, 12 Oct 2006 09:19:03 -0500
From: Michael Harris <googlegroups@mgharris.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Michael Harris <googlegroups@mgharris.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18: Kernel BUG at mm/rmap.c:522
Message-ID: <20061012141903.GA6593@dingu.igconcepts.com>
References: <20061011160740.GA6868@dingu.igconcepts.com> <452DF9D2.6020306@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452DF9D2.6020306@yahoo.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Michael Harris wrote:
> >Hi, I can readily reproduce this with 2.6.18 doing 4 simultanous kernel 
> >compiles on two disks to load test a P4 3.2 HT with 2GB. I have SMP and 
> >SMT scheduling enabled, and the 4GB memory option. Here is output with 
> >CONFIG_DEBUG_VM enabled followed by another crash before CONFIG_DEBUG_VM 
> >was enabled.
> 
> >Oct 11 04:53:35 hen kernel: swap_free: Unused swap offset entry 00004000
> >Oct 11 04:53:35 hen kernel: Eeek! page_mapcount(page) went negative! (-1)
> >Oct 11 04:53:35 hen kernel:   page->flags = c0080014
> >Oct 11 04:53:35 hen kernel:   page->count = 0
> >Oct 11 04:53:35 hen kernel:   page->mapping = 00000000
> 
> Hmm, this is a new one. The page is free and not reserved, wheras we are
> used to seeing them reserved here.
> 
> >Oct 11 04:54:31 hen kernel: Bad page state in process 'tripwire'
> >Oct 11 04:54:31 hen kernel: page:c1b5cd80 flags:0xc0000014 
> >mapping:00000000 mapcount:-1 count:0
> 
> >Another crash from a day earlier before enabling DEBUG_VM
> >Oct 10 05:19:43 hen kernel: VM: killing process cc1
> >Oct 10 05:19:43 hen kernel: swap_free: Unused swap offset entry 00002000
> >Oct 10 05:19:56 hen kernel: swap_free: Unused swap offset entry 00000400
> 
> These unused swap offset entry messages seem to indicate extensive memory
> corruption in your page tables. Probably bad RAM, or system overheating
> when you load it up :(
> 
> Can you run a good memory tester like memtest86+ overnight?


Hi, I think this is the case, a stick of ram gone bad. It had worked 
testing under 2.4 but coincidentally failed about the time I upgraded
to 2.6. memtest86 uncovered it at once. Sorry for the trouble and thanks
for the help.
Mike

