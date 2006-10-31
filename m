Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423029AbWJaJ3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423029AbWJaJ3b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 04:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422773AbWJaJ3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 04:29:31 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:59960 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1423029AbWJaJ3a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 04:29:30 -0500
Message-ID: <45471679.90103@openvz.org>
Date: Tue, 31 Oct 2006 12:25:13 +0300
From: Pavel Emelianov <xemul@openvz.org>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: balbir@in.ibm.com
CC: Pavel Emelianov <xemul@openvz.org>, vatsa@in.ibm.com, dev@openvz.org,
       sekharan@us.ibm.com, ckrm-tech@lists.sourceforge.net,
       haveblue@us.ibm.com, linux-kernel@vger.kernel.org, pj@sgi.com,
       matthltc@us.ibm.com, dipankar@in.ibm.com, rohitseth@google.com,
       menage@google.com, linux-mm@kvack.org,
       Vaidyanathan S <svaidy@in.ibm.com>
Subject: Re: [ckrm-tech] RFC: Memory Controller
References: <20061030103356.GA16833@in.ibm.com> <4545D51A.1060808@in.ibm.com> <4546212B.4010603@openvz.org> <454638D2.7050306@in.ibm.com> <45463F70.1010303@in.ibm.com> <45470FEE.6040605@openvz.org> <45471510.4070407@in.ibm.com>
In-Reply-To: <45471510.4070407@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh wrote:
> Pavel Emelianov wrote:
>> [snip]
>>
>>>> But in general I agree, these are the three important resources for
>>>> accounting and control
>>> I missed out to mention, I hope you were including the page cache in
>>> your definition of reclaimable memory.
>> As far as page cache is concerned my opinion is the following.
>> (If I misunderstood you, please correct me.)
>>
>> Page cache is designed to keep in memory as much pages as
>> possible to optimize performance. If we start limiting the page
>> cache usage we cut the performance. What is to be controlled is
>> _used_ resources (touched pages, opened file descriptors, mapped
>> areas, etc), but not the cached ones. I see nothing bad if the
>> page that belongs to a file, but is not used by ANY task in BC,
>> stays in memory. I think this is normal. If kernel wants it may
>> push this page out easily it won't event need to try_to_unmap()
>> it. So cached pages must not be accounted.
>>
> 
> The idea behind limiting the page cache is this
> 
> 1. Lets say one container fills up the page cache.
> 2. The other containers will not be able to allocate memory (even
> though they are within their limits) without the overhead of having
> to flush the page cache and freeing up occupied cache. The kernel
> will have to pageout() the dirty pages in the page cache.
> 
> Since it is easy to push the page out (as you said), it should be
> easy to impose a limit on the page cache usage of a container.

If a group is limited with memory _consumption_ it won't fill
the page cache...

>> I've also noticed that you've [snip]-ed on one of my questions.
>>
>>  > How would you allocate memory on NUMA in advance?
>>
>> Please, clarify this.
> 
> I am not quite sure I understand the question. Could you please rephrase
> it and highlight some of the difficulty?

I'd like to provide a guarantee for a newly created group. According
to your idea I have to preallocate some pages in advance. OK. How to
select a NUMA node to allocate them from?
