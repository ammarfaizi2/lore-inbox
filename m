Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272849AbTG3Lzj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 07:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272853AbTG3Lzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 07:55:39 -0400
Received: from mail.aex.nl ([212.153.234.107]:9220 "HELO mail.aex.nl")
	by vger.kernel.org with SMTP id S272849AbTG3LzY (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 07:55:24 -0400
Message-ID: <3F27B1AB.4080200@euronext.nl>
Date: Wed, 30 Jul 2003 13:53:15 +0200
From: Jan Evert van Grootheest <j.grootheest@euronext.nl>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.3.1) Gecko/20030425
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: John Bradford <john@grabjohn.com>, Linux-Kernel@vger.kernel.org,
       Riley@Williams.Name
Subject: Re: [2.6 patch] let broken drivers depend on BROKEN{,ON_SMP}
References: <200307301129.h6UBTtBD001245@81-2-122-30.bradfords.org.uk> <20030730113724.GA19356@fs.tum.de>
In-Reply-To: <20030730113724.GA19356@fs.tum.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

I've been pondering this a bit. Perhaps you're trying to put a status on 
drivers and other things at the wrong place.
In a bit more abstract way, the status (experimental, antique, broken or 
whatever status you like) of a driver is not (should not be) related to 
build dependencies. I think.

Perhaps something different is needed to maintain this status?

Obviously, it is necessary to display this status in the kernel config 
tools. And probably the user should be able to filter certain statuses 
(like: I don't want to see drivers that do not compile).

just my thoughts.

-- Jan Evert

PS: this is my opinion, not necessarily that of (atos)euronext.

Adrian Bunk wrote:
> On Wed, Jul 30, 2003 at 12:29:55PM +0100, John Bradford wrote:
> 
>>>>> * Driver does not work, and is thus disabled. If it is not
>>>>>   fixed in the near future, it will be considered to be
>>>>>   OBSOLETE as well.
>>>>>
>>>>>		CONFIG_BROKEN
>>>>
>>>>Please do _NOT_ do this - there is a far more important and worthwhile
>>>>reason to have a CONFIG_BROKEN than to simply save the few minutes of
>>>>inconvenience that including a non-compiling option in a kernel build
>>>>causes.
>>>>
>>>>Imagine the situation where a driver such as a SCSI driver builds
>>>>successfully, but it silently corrupts data under certain, (possibly
>>>>rare), circumstances.
>>>>
>>>>In that case, it's important to warn people that it's broken, because
>>>>it's not necessarily obvious, and could case significant data loss.
>>>>If something doesn't compile, it already gives you an error message.
>>>>The only problem is a few minutes of wasted time.
>>>
>>>You forget one important thing:
>>>If a _user_ of a stable kernel notices "it doesn't even compile" this 
>>>gives a very bad impression of the quality of the Linux kernel.
>>
>>I don't agree.  The stock kernel is a work in progress, and things get
>>broken from time to time as a normal part of development.  Experienced
>>users will realise that, and I wouldn't encourage inexperienced users
>>to compile their own kernel from the stock trees anyway, because they
>>could easily miss bugfixes, including data corruption and security
>>ones, simply because they assume that they are in the mainline
>>kernel.
> 
> 
> Whether you like it or not:
> 
> Many non-kernel-hackers compile their own kernels.
> 
> 
> Even if you wouldn't encourage them, there are enough situations where 
> they can't choose:
> 
> It occurs often that a fix or support for some hardware is only in the
> latest -pre or in the -ac tree.
> 
> 
> You say "things get broken from time to time as a normal part of 
> development". Ideally this should never happen in a stable series. We 
> don't live in an ideal world, but we should try to be as close as 
> possible to this goal.
> 
> 
> 
>>Compiling your own kernel from the stock kernel trees is still
>>something that should be considered for experienced users only.
>>
>>Besides, what's worse?  Possible data corruption or a bad impression?
> 
> 
> Possible data corruption is worse, but completely disabling this driver 
> is even better.
> 
> 
>>>>> * Driver works on uniprocessor but not on SMP and is thus
>>>>>   disabled when compiling for SMP. It is assumed that the
>>>>>   driver will be fixed for SMP if relevant.
>>>>>
>>>>>		CONFIG_BROKEN_ON_SMP
>>>>
>>>>Please _don't_ do this either.  It implies that if
>>>>CONFIG_BROKEN_ON_SMP isn't set, then it's SMP safe - a lot of drivers
>>>>will NOT have been tested on SMP, so it's a bad thing to assume that
>>>>is the case.
>>>>...
>>>
>>>My patch adds BROKEN_ON_SMP only to drivers that don't compile, but if a 
>>>driver causes e.g. data corruption on SMP I don't see a reason against 
>>>letting it depend on BROKEN_ON_SMP.
>>
>>The name BROKEN_ON_SMP implies that if you don't set it, what's left
>>is known to work on SMP.  In a lot of cases, it'll actually be
>>untested on SMP.
> 
> 
> Say which other drivers are completely broken on SMP without a fix 
> available or in the near future and it's easy to add a BROKEN_ON_SMP.
> 
> As long as noone reports such a bug I assume a driver works.
> 
> 
>>John.
> 
> 
> cu
> Adrian
> 

