Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbUBUADO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 19:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbUBUACw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 19:02:52 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:8185 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261441AbUBUACD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 19:02:03 -0500
Message-ID: <403553B2.9080208@mvista.com>
Date: Thu, 19 Feb 2004 16:24:18 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "La Monte H.P. Yarroll" <piggy@timesys.com>, pavel@ucw.cz,
       linux-kernel@vger.kernel.org, amitkale@emsyssoft.com
Subject: Re: kgdb support in vanilla 2.6.2
References: <20040204230133.GA8702@elf.ucw.cz>	<20040204152137.500e8319.akpm@osdl.org>	<402182B8.7030900@timesys.com> <20040204155452.49c1eba8.akpm@osdl.org>
In-Reply-To: <20040204155452.49c1eba8.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
~
>>>
>>>I wouldn't support inclusion of i386 kgdb until it has had a lot of
>>>cleanup, possible de-featuritisification and some thought has been applied
>>>to splitting it into arch and generic bits.  It's quite a lot of work.
>>> 
>>>
>>
>>Amit has started at least the third activity--he has split much of kgdb
>>into arch and generic bits.
> 
> 
> Yes.
> 
> 
>>Could you elaborate a little on the first two?
>>
>>What major kinds of cleanup are we talking about?  Style issues?
> 
> 
> Coding style compliance, reduction of ifdefs, etc.  Reduction of patch
> footprint.  There are a few features in the patch in -mm which I am not
> aware of anyone having used.
> 
> 
>>What features (or classes of features) do you find excessive?  Would
>>it be sufficient to add a few config items to control subfeatures
>>of kgdb?
>>
> 
> 
> People have added timestamping infrastructure, stack overflow testing and
> inbuilt assertion frameworks to various gdb stubs at various times.  We
> need to take a look at such things and really convice ourselves that
> they're worthwhile.  Personally, I'd only be interested in the basic stub.
> 
Well, I have NEVER had a stack overflow, but then it is only a few lines. 
Likewise the assertions I think can go in favor of BUG and friends.

The timestamping I added at a time when the alternative that was suggested was 
LTT, which, at the time did not even come close to touching what I needed to do. 
  The timestamp code is designed to catch things that can only be observed when 
running close to real speed.  Especially on SMP systems, relative arrival times 
at spinlocks and friends can be very useful.  Would there be less objection if 
we removed the configure option for it ;)

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

