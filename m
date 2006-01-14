Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751380AbWANFDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbWANFDa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 00:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbWANFDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 00:03:30 -0500
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:4197 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751380AbWANFDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 00:03:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=4H+lEE6LXxK1YnRSWOPETFpC05hsSqNCzAdGgJzZD6QJKVJoFm4XsMA8QLrFb2SjQVjdrHoC3dbo3etbdLPuMbbuamcLXx8c68ZGbMqQAxItPB82S45CLYB39Y7BjSU374nN31rna2+r9AhF+glnoHf0R0MuYONnnlywTl4Ra+M=  ;
Message-ID: <43C8861E.5070203@yahoo.com.au>
Date: Sat, 14 Jan 2006 16:03:26 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Williams <pwil3058@bigpond.net.au>
CC: Martin Bligh <mbligh@google.com>, Andy Whitcroft <apw@shadowen.org>,
       Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: -mm seems significanty slower than mainline on kernbench
References: <43C45BDC.1050402@google.com> <43C4A3E9.1040301@google.com> <43C4F8EE.50208@bigpond.net.au> <200601120129.16315.kernel@kolivas.org> <43C58117.9080706@bigpond.net.au> <43C5A8C6.1040305@bigpond.net.au> <43C6A24E.9080901@google.com> <43C6B60E.2000003@bigpond.net.au> <43C6D636.8000105@bigpond.net.au> <43C75178.80809@bigpond.net.au> <43C7D4D1.10200@shadowen.org> <43C7E96D.7000003@shadowen.org> <43C81073.1040805@google.com> <43C84496.6060506@bigpond.net.au>
In-Reply-To: <43C84496.6060506@bigpond.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Martin Bligh wrote:
> 
>> Andy Whitcroft wrote:
>>
>>> Andy Whitcroft wrote:
>>>
>>>> Peter Williams wrote:
>>>>
>>>>
>>>>
>>>>> Attached is a new patch to fix the excessive idle problem.  This patch
>>>>> takes a new approach to the problem as it was becoming obvious that
>>>>> trying to alter the load balancing code to cope with biased load was
>>>>> harder than it seemed.
>>>>
>>>>
>>>>
>>>>
>>>> Ok.  Tried testing different-approach-to-smp-nice-problem against the
>>>> transition release 2.6.14-rc2-mm1 but it doesn't apply.  Am testing
>>>> against 2.6.15-mm3 right now.  Will let you know.
>>>
>>>
>>>
>>>
>>> Doesn't appear to help if I am analysing the graphs right.  Martin?
>>
>>
>>
>> Nope. still broken.
> 
> 
> Interesting.  The only real difference between this and Con's original 
> patch is the stuff that he did in source_load() and target_load() to 
> nobble the bias when nr_running is 1 or less.  With this new model it 
> should be possible to do something similar in those functions but I'll 
> hold off doing anything until a comparison against 2.6.15-mm3 with the 
> patch removed is available (as there are other scheduler changes in -mm3).
> 

Ideally, balancing should be completely unaffected when all tasks are
of priority 0 which is what I thought yours did, and why I think the
current system is not great.

I'll probably end up taking a look at it one day, if it doesn't get fixed.
I think your patch is pretty close but I didn't quite look close enough to
work out what's going wrong.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
