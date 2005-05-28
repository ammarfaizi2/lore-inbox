Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261519AbVE1DTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbVE1DTG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 23:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbVE1DTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 23:19:06 -0400
Received: from www.rapidforum.com ([80.237.244.2]:39397 "HELO rapidforum.com")
	by vger.kernel.org with SMTP id S261519AbVE1DSw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 23:18:52 -0400
Message-ID: <4297E2DD.1040807@rapidforum.com>
Date: Sat, 28 May 2005 05:17:49 +0200
From: Christian Schmid <webmaster@rapidforum.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050414
X-Accept-Language: de, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Ben Greear <greearb@candelatech.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: BUG: Slowdown on 3000 socket-machines tracked down
References: <4229E805.3050105@rapidforum.com>	 <422BAAC6.6040705@candelatech.com>	<422BB548.1020906@rapidforum.com>	 <422BC303.9060907@candelatech.com>	<422BE33D.5080904@yahoo.com.au>	 <422C1D57.9040708@candelatech.com>	<422C1EC0.8050106@yahoo.com.au>	 <422D468C.7060900@candelatech.com>	<422DD5A3.7060202@rapidforum.com>	 <422F8A8A.8010606@candelatech.com>	<422F8C58.4000809@rapidforum.com>	 <422F9259.2010003@candelatech.com>	<422F93CE.3060403@rapidforum.com>	 <20050309211730.24b4fc93.akpm@osdl.org> <4231B95B.6020209@rapidforum.com>	 <4231ED18.2050804@candelatech.com>  <4231F112.60403@rapidforum.com>	 <1110775215.5131.17.camel@npiggin-nld.site> <423518C7.10207@rapidforum.com> <1110776689.5131.37.camel@npiggin-nld.site>
In-Reply-To: <1110776689.5131.37.camel@npiggin-nld.site>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I want to give the newest report for the vm-lock problem. It seems the problem is getting less 
critical in every new release. I am currently using 2.6.12-rc5. The problem with the massive vm-lock 
appears as always when 3500 sockets are reached as reported in earlier mails. The problem suddenly 
disappears when I set lowmem_reserve_ratio to "1 1" AND min_free_kbytes to 1024000. It only starts 
to appear again when reaching around 7000 sockets. -rc3 for example slowed down at 4500 sockets again.

I am very sure its a vm-lock because for example reading /proc/sys/vm/lowmem_reserve_ratio needs no 
time with < 3500 sockets. While testing with 7000 sockets, I had to wait 20-30 seconds until the 
"file" was opened.

Any suggestions? Dual Xeon 3,6 GHz with 8 GB Ram.

Nick Piggin wrote:
> On Mon, 2005-03-14 at 05:53 +0100, Christian Schmid wrote:
> 
> 
>>>The other thing that worries me is your need for lower_zone_protection.
>>>I think this may be due to unbalanced highmem vs lowmem reclaim. It
>>>would be interesting to know if those patches I sent you improve this.
>>>They certainly improve reclaim balancing for me... but again I guess
>>>you'll be reluctant to do much experimentation :\
>>
>>I have tested your patch and unfortunately on 2.6.11 it didnt change anything :( I reported this 
>>before, or do you mean something else? I am of course willing to test patches as I do not want to 
>>stick with 2.6.10 forever.
> 
> 
> Well I hope that scheduler developments in progress will put future
> kernels at least on par with 2.6.10 again (and hopefully better).
> 
> Yes you did report that my patch didn't help 2.6.11, but could those
> results have been influenced by the suboptimal HT scheduling? If so,
> I was interested in the results with HT turned off.
> 
> Nick
> 
> 
> Find local movie times and trailers on Yahoo! Movies.
> http://au.movies.yahoo.com
> 
> 
