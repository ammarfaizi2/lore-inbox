Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261630AbVCGFlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261630AbVCGFlG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 00:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261632AbVCGFlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 00:41:06 -0500
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:29521 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261630AbVCGFlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 00:41:04 -0500
Message-ID: <422BE96E.9040006@yahoo.com.au>
Date: Mon, 07 Mar 2005 16:41:02 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: Ben Greear <greearb@candelatech.com>,
       Christian Schmid <webmaster@rapidforum.com>,
       linux-kernel@vger.kernel.org
Subject: Re: BUG: Slowdown on 3000 socket-machines tracked down
References: <4229E805.3050105@rapidforum.com> <422BAAC6.6040705@candelatech.com> <422BB548.1020906@rapidforum.com> <422BC303.9060907@candelatech.com> <422BE33D.5080904@yahoo.com.au> <20050307053032.GA30052@alpha.home.local>
In-Reply-To: <20050307053032.GA30052@alpha.home.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> On Mon, Mar 07, 2005 at 04:14:37PM +1100, Nick Piggin wrote:
>  
> 
>>I think you would have better luck in reproducing this problem if you
>>did the full sendfile thing.
>>
>>I think it is becoming disk bound due to page reclaim problems, which
>>is causing the slowdown.
>>
>>In that case, writing the network only test would help to confirm the
>>problem is not a networking one - so not useless by any means.
> 
> 
> Not necessarily, Nick. I have written an HTTP testing tool which matches
> the description of Ben's : non-blocking, single-threaded, no disk I/O,
> etc... It works flawlessly under 2.4, and gives me random numbers in 2.6,

No you're right, I'm not 100% sure, so I'm definitely not saying
Ben's test will be useless. Just that if it is not too hard to
make one with sendfile, I think he should.

If he makes a network-only version and cannot reproduce the problems,
that *doesn't* mean it is *not* a network problem. However if he
reproduces the problem with a full sendfile version and not the network
only one, then that is a better indicator... but I'm rambling.

> especially if I start some CPU activity on the system, I can get pauses
> of up to 13 seconds without this tool doing anything !!! At first I
> believed it was because of the scheduler, but it might also be related
> to what is described here since I had somewhat the same setup (gigE, 1500,
> thousands of sockets). I never had enough time to investigate more, so I
> went back to 2.4.
> 

I have heard other complaints about this, and they are definitely
related to the scheduler (not saying yours is, but it is very possible).

