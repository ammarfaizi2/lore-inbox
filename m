Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262642AbULPIOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262642AbULPIOu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 03:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262641AbULPIOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 03:14:50 -0500
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:59811 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262638AbULPIOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 03:14:46 -0500
Message-ID: <41C143F4.20806@yahoo.com.au>
Date: Thu, 16 Dec 2004 19:14:44 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: lista4@comhem.se
CC: mr@ramendik.ru, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc3: kswapd eats CPU on start of memory-eating task
References: <14380712.1103150975468.JavaMail.tomcat@pne-ps3-sn1> <41C14161.7020300@yahoo.com.au>
In-Reply-To: <41C14161.7020300@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Voluspa wrote:
> 
>> Earlier today I wrote:
>>
>>
>>> I find no problem when blender is the sole (large) application, but 
>>> when a
>>> distributed computing client is running in the background the reported 
>>
>>
>> problems
>>
>>> surface. I use http://folding.stanford.edu for protein folding. It runs
>>> with a default of nice 19 and sucks up every free CPU cycle. I've never
>>> seen it interfere with anything prior to this swap issue - been running
>>> it since 2000.
>>
>>
>>
>> More testing done to find the breaking point. Running the folding 
>> client and blender:
>>
>> 2.6.8.1-bk2 is the last kernel without _any_ swapping problem (no 
>> screen freezes etc)
>> |
>> | 2.6.9-rc1 and three -bk forward have oopses and loss of keyboard in 
>> X. Can't test them.
>> |
>> 2.6.9-rc1-bk4 is the first functional kernel where the freezes show up.
>>
>> So it is a real regression.
>>
> 
> Can you turn on magic sysrq in the kernel hacking menu, and press
> alt+sysrq+m a few times while kswapd is using lots of memory, please?
> 
> Then run `dmesg -s 1000000 > dmesg.out`, and send the dmesg over,
> please?
> 

By the way, I think the only relevant VM patches that went in between
2.6.8 and 2.6.9-rc2 are the following:

<nickpiggin@yahoo.com.au>
	[PATCH] vm: writeout watermark tuning

<nickpiggin@yahoo.com.au>
	[PATCH] vm: alloc_pages watermark fixes
	
<akpm@osdl.org>
	[PATCH] alloc_pages priority tuning

The first one shouldn't do much, and the last two should definitely
be improving things rather than anything else, because they cause
kswapd to properly start freeing in the background rather than force
the app to do the memory freeing itself.

This did expose a couple of bugs in kswapd, which were since fixed,
but are not in the 2.6.9-rc1-bk4 kernel.

So please, do the sysrq+m traces with a 2.6.10-rc3 kernel. Thanks.
