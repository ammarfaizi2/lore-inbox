Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262728AbVAFFGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262728AbVAFFGp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 00:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262729AbVAFFGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 00:06:44 -0500
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:7083 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262728AbVAFFGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 00:06:39 -0500
Message-ID: <41DCC75A.2050800@yahoo.com.au>
Date: Thu, 06 Jan 2005 16:06:34 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Andrew Morton <akpm@osdl.org>, riel@redhat.com,
       marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][5/?] count writeback pages in nr_scanned
References: <20050105134457.03aca488.akpm@osdl.org> <20050105203217.GB17265@logos.cnet> <41DC7D86.8050609@yahoo.com.au> <Pine.LNX.4.61.0501052025450.11550@chimarrao.boston.redhat.com> <20050105173624.5c3189b9.akpm@osdl.org> <Pine.LNX.4.61.0501052240250.11550@chimarrao.boston.redhat.com> <41DCB577.9000205@yahoo.com.au> <20050105202611.65eb82cf.akpm@osdl.org> <41DCC014.80007@yahoo.com.au> <20050105204706.0781d672.akpm@osdl.org> <20050106045932.GN4597@dualathlon.random>
In-Reply-To: <20050106045932.GN4597@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> On Wed, Jan 05, 2005 at 08:47:06PM -0800, Andrew Morton wrote:
> 
>>That's my point.  blk_congestion_wait() will always sleep, regardless of
> 
> 
> Since I've no pending bugs at all with the mainline codebase I rate this
> just a theoretical issue: but even sleeping for a fixed amount of time
> is unreliable there, for example if the storage is very slow. That's why
> using io_schedule_timeout for that isn't going to be a fix.
> 
> The fix is very simple and it is to call wait_on_page_writeback on one
> of the pages under writeback. That guarantees some _writeback_ progress
> has been made before retrying. That way some random direct-io or a too
> short timeout, can't cause malfunction.
> 

Yeah I guess that isn't a bad idea.

Doesn't that have the theoretical problem of slowing down reclaim
of dirty pages backed by fast devices when you have slow devices
writing?

But presumably you'd usually have pdflush working away anyway.
