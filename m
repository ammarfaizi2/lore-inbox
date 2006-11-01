Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946956AbWKARk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946956AbWKARk2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 12:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946959AbWKARk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 12:40:28 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:31899 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1946956AbWKARk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 12:40:27 -0500
Message-ID: <4548DB0C.3050601@oracle.com>
Date: Wed, 01 Nov 2006 09:36:12 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Derek Fults <dfults@sgi.com>
CC: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Add get_range, allows a hyhpenated range to get_options
References: <1162398157.9524.490.camel@lnx-dfults.americas.sgi.com>	 <20061101085722.18430d23.randy.dunlap@oracle.com> <1162402145.9524.501.camel@lnx-dfults.americas.sgi.com>
In-Reply-To: <1162402145.9524.501.camel@lnx-dfults.americas.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Derek Fults wrote:
> On Wed, 2006-11-01 at 08:57 -0800, Randy Dunlap wrote:
>> On Wed, 01 Nov 2006 10:22:36 -0600 Derek Fults wrote:
>>
>>> This allows a hyphenated range of positive numbers in the string passed
>>> to command line helper function, get_options.    
>>> Currently the command line option "isolcpus=" takes as its argument a
>>> list of cpus.  
>>> Format: <cpu number>,...,<cpu number>
>>> This can get extremely long when isolating the majority of cpus on a
>>> large system.  Valid values of <cpu_number>  include all cpus, 0 to
>>> "number of CPUs in system - 1".
>>>
>>> Signed-off-by: Derek Fults <dfults@sgi.com>  
>>>
>>> Index: linux/lib/cmdline.c
>>> ===================================================================
>>> --- linux.orig/lib/cmdline.c	2006-09-19 22:42:06.000000000 -0500
>>> +++ linux/lib/cmdline.c	2006-11-01 10:16:09.988659834 -0600
>>> @@ -16,6 +16,21 @@
>>>  #include <linux/kernel.h>
>>>  #include <linux/string.h>
>>>  
>>> +/* If a hyphen was found in get_option, this will handle the 
>>> + * range of numbers given. 
>> Still have trailing whitespace in the patch (2 lines above).
>>
>> I think that this comment should explain that the M-N range
>> is handled by expanding it to an array of [M, M+1, ..., N].
>>
> How's this for a description?
> 
> /* If a hyphen was found in get_option, this will handle the
>  * range of numbers, M-N.  This will expand the range and insert
>  * the values[M, M+1, ..., N] into the ints array in get_options.
>  */

That text is good.  Please look at lib/cmdline.c and put this text
into the same comment-block format as the rest of the file.

How does get_range() handle errors, like input of
	64-60
or	64-N
or	64-
?

-- 
~Randy
