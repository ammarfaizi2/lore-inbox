Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbWKAWvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWKAWvg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 17:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWKAWvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 17:51:36 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:24154 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1750807AbWKAWvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 17:51:35 -0500
Message-ID: <454923F7.8070202@oracle.com>
Date: Wed, 01 Nov 2006 14:47:19 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Derek Fults <dfults@sgi.com>
CC: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Updated, add get_range, allows a hyhpenated range to
 get_options
References: <1162410596.9524.544.camel@lnx-dfults.americas.sgi.com>	 <4548FAFC.5000409@oracle.com>	 <1162412656.9524.556.camel@lnx-dfults.americas.sgi.com>	 <454902CC.4040700@oracle.com> <1162414262.9524.573.camel@lnx-dfults.americas.sgi.com>
In-Reply-To: <1162414262.9524.573.camel@lnx-dfults.americas.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Derek Fults wrote:
> On Wed, 2006-11-01 at 12:25 -0800, Randy Dunlap wrote:
>> Derek Fults wrote:
>>> On Wed, 2006-11-01 at 11:52 -0800, Randy Dunlap wrote:
>>>> Derek Fults wrote:
>>>>> This allows a hyphenated range of positive numbers M-N, in the string
>>>>> passed to command line helper function, get_options.  This will expand
>>>>> the range and insert the values[M, M+1, ..., N] into the ints array in
>>>>> get_options.
>>>>>
>>>>> Currently the command line option "isolcpus=" takes as its argument a
>>>>> list of cpus.  
>>>>> Format: <cpu number>,...,<cpu number>
>>>>> This can get extremely long when isolating the majority of cpus on a
>>>>> large system.  Valid values of <cpu_number>  include all cpus, 0 to
>>>>> "number of CPUs in system - 1".
>>>>>
>>>>>
>>>>> Signed-off-by: Derek Fults <dfults@sgi.com>  
>>>>>
>>>>> Index: linux/lib/cmdline.c
>>>>> ===================================================================
>>>>> --- linux.orig/lib/cmdline.c	2006-09-19 22:42:06.000000000 -0500
>>>>> +++ linux/lib/cmdline.c	2006-11-01 12:36:20.059166727 -0600
>>>>> @@ -16,6 +16,23 @@
>>>>>  #include <linux/kernel.h>
>>>>>  #include <linux/string.h>
>>>>>  
>>>>> +/**
>>>>> + *	If a hyphen was found in get_option, this will handle the
>>>>> + *	range of numbers, M-N.  This will expand the range and insert
>>>>> + *	the values[M, M+1, ..., N] into the ints array in get_options.
>>>>> + */
>>>> Derek,
>>>> Thanks for persisting thru this.  It's all fine for me except the
>>>> comment block above.  If a comment block begins with "/**", then
>>>> it's supposed to be in kernel-doc format (see
>>>> Documentation/kernel-doc-nano-HOWTO.txt), with function name &
>>>> parameters (if applicable).  However, that mostly needs to be done
>>>> for non-static functions, so probably just change /** to /*
>>>> and leave the rest of the comment block as is.
>>>> My other comment-block comment was also about kernel long-comment
>>>> style, which is
>>>> /*
>>>>  * begin
>>>>  * more
>>>>  * end
>>>>  */
>>>> so now you have achieved that also, so thanks again.
>>> I fixed both comments to match that format.  Thanks for all the help and
>>> your patience.
>>> I'm posting the new patch in this replay.  Is that an acceptable
>>> practice, or does one normally post all fixes to a patch in a new
>>> message?
>> It happens both ways, but since this is mostly new code/feature,
>> I suggest that you repost it and also cc: akpm@osdl.org on it.
>>
>> And it still needs a user.  Will you be converting isolcpus=
>> to use this functionality?
>> It likely won't be merged until it has a user.
>>
> Isolcpus will be using this code, but it does not need to be converted
> in the kernel.  Isolated_cpu_setup() gets its string from the command
> line and then makes the call to get_options with that string.  There is

Ack that.

> a reference to the format of isolcpus= in kernel-parameters.txt, that
> could reflect this enhancement.
> Instead of:
> Format: <cpu number>,...,<cpu number>
> 
> change to:
> Format <cpu number>,...,<cpu number>-<cpu number>
> <cpu number>-<cpu number> must be a positive range in ascending order. 

Can you make that change too, please?

-- 
~Randy
