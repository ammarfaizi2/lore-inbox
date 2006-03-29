Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750874AbWC3U1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbWC3U1i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 15:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbWC3U1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 15:27:38 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:45591 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1750846AbWC3U1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 15:27:37 -0500
Message-ID: <442AEB3A.9030503@tmr.com>
Date: Wed, 29 Mar 2006 15:16:58 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Ram Gupta <ram.gupta5@gmail.com>
CC: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: RSS Limit implementation issue
References: <728201270602091310r67a3f2dcq4788199f26a69528@mail.gmail.com>	 <1139526447.6692.7.camel@localhost.localdomain> <728201270603230855l11faeb6ah33ee88568843068f@mail.gmail.com>
In-Reply-To: <728201270603230855l11faeb6ah33ee88568843068f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ram Gupta wrote:
> On 2/9/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> On Iau, 2006-02-09 at 15:10 -0600, Ram Gupta wrote:
>>> I am working to implement enforcing RSS limits of a process. I am
>>> planning to make a check for rss limit when setting up pte. If the
>>> limit is crossed I see couple of  different ways of handling .
>>>
>>> 1. Kill the process . In this case there is no swapping problem.
>> Not good as the process isn't responsible for the RSS size so it would
>> be rather random.
>>
> 
> I doubt I am missing some point here. I dont understand why the
> process isn't responsible for RSS size. This limit is process specific
> & the count of rss increases when the process maps some page in its
> page table.

A process has no control over its RSS size, only its virtual size. I'm 
not sure you're clear on that, or just not saying it clearly. Therefore 
the same process, say a largish perl run, may be 175mB in vsize, and 
during the day have rss of perhaps half that. At night, with next to no 
load on the machine, the rss is 175mB because there is a bunch of free 
memory available.

If you want to make rss a hard limit the result should be swapping, not 
failure to run. I'm not sure the limit in that form is a good idea, and 
before someone reminds me, I do remember liking it better a few years ago.

If you can come up with a better way to adjust rss to get better overall 
greater throughput while being fair to all processes, go to it. But in 
general these things are a tradeoff, like swappiness, you tune until the 
volume of complaints reaches a minimum.

You could do tuning to get minimum page faults overall, or assure a 
minumum size, or... I think there's room for improvement, particularly 
for servers, but a hard limit doesn't seem to be it.

Didn't Rik do something in this area back in 2.4 and decide there 
weren't many fish in that pond?

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

