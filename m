Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262687AbVAFDuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbVAFDuZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 22:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262711AbVAFDuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 22:50:25 -0500
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:41630 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262687AbVAFDuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 22:50:19 -0500
Message-ID: <41DCB577.9000205@yahoo.com.au>
Date: Thu, 06 Jan 2005 14:50:15 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][5/?] count writeback pages in nr_scanned
References: <Pine.LNX.4.61.0501031224400.25392@chimarrao.boston.redhat.com> <20050105020859.3192a298.akpm@osdl.org> <20050105180651.GD4597@dualathlon.random> <Pine.LNX.4.61.0501051350150.22969@chimarrao.boston.redhat.com> <20050105174934.GC15739@logos.cnet> <20050105134457.03aca488.akpm@osdl.org> <20050105203217.GB17265@logos.cnet> <41DC7D86.8050609@yahoo.com.au> <Pine.LNX.4.61.0501052025450.11550@chimarrao.boston.redhat.com> <20050105173624.5c3189b9.akpm@osdl.org> <Pine.LNX.4.61.0501052240250.11550@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.61.0501052240250.11550@chimarrao.boston.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> On Wed, 5 Jan 2005, Andrew Morton wrote:
> 
>> Rik van Riel <riel@redhat.com> wrote:
> 
> 
>>> The recent OOM kill problem has been happening:
>>> 1) with cache pressure on lowmem only, due to a block device write
>>> 2) with no block congestion at all
>>> 3) with pretty much all pageable lowmme pages in writeback state
>>
>>
>> You must have a wild number of requests configured in the queue.  Is 
>> this CFQ?
> 
> 
> Yes, it is with CFQ.  Around 650MB of lowmem is in writeback
> stage, which is over 99% of the active and inactive lowmem
> pages...
> 
>> I've done testing with "all of memory under writeback" before and it 
>> went OK.  It's certainly a design objective to handle this well.  But 
>> that testing was before we broke it.
> 
> 
> I suspect something might still be broken.  It may take a few
> days of continuous testing to trigger the bug, though ...
> 

It is possible to be those blk_congestion_wait paths, because
the queue simply won't be congested. So doing io_schedule_timeout
might help.

I wonder if reducing the size of the write queue in CFQ would help
too? IIRC, it only really wants a huge read queue.
