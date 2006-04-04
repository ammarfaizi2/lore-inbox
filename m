Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751316AbWDES1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbWDES1E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 14:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbWDES1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 14:27:04 -0400
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:21942 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751316AbWDES1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 14:27:01 -0400
Message-ID: <4432C8E6.6010301@tmr.com>
Date: Tue, 04 Apr 2006 15:28:38 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9a1) Gecko/20060330 SeaMonkey/1.5a
MIME-Version: 1.0
To: Roger Heflin <rheflin@atipa.com>
CC: "'linux mailing-list'" <linux-kernel@vger.kernel.org>
Subject: Re: RSS Limit implementation issue
References: <442AEB3A.9030503@tmr.com> <EXCHG2003g3Sv0YKpDS000000d0@EXCHG2003.microtech-ks.com>
In-Reply-To: <EXCHG2003g3Sv0YKpDS000000d0@EXCHG2003.microtech-ks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Heflin wrote:
>  
> 
>> A process has no control over its RSS size, only its virtual 
>> size. I'm not sure you're clear on that, or just not saying 
>> it clearly. Therefore the same process, say a largish perl 
>> run, may be 175mB in vsize, and during the day have rss of 
>> perhaps half that. At night, with next to no load on the 
>> machine, the rss is 175mB because there is a bunch of free 
>> memory available.
>>
>> If you want to make rss a hard limit the result should be 
>> swapping, not failure to run. I'm not sure the limit in that 
>> form is a good idea, and before someone reminds me, I do 
>> remember liking it better a few years ago.
> 
> working_set_size limits sucked on VMS.  The OS would limit a process to
> its working set size and casue the entire machine to swap
> even though there was adequate free memory.   I believe they
> had a normalworkingset size variable, and a maxworkingsetsize
> one indicated how much ram you could get on a memory limited 
> system, the other indicated the most it would ever let you get even if
> there was plenty of free ram.   The maxworkingsetsize caused
> a lot of issues, as the default appeared to be defined for
> much smaller systems that we were using at the time, and so
> were much too low, and cause unnecessary swapping.  Part of the
> issue would be that the admin would need to know what he was
> doing to use the feature, and most don't.
> 
> The argument from the admins at the time was that this limited
> the damage to other processes by preventing certain processes
> from getting too much memory, they ignored the fact that
> anything swapping (even only the one process) unnecessarly 
> *KILLED* performance for the entire machine, since swapping
> is rather expensive on the os.

After thinking about this, I have the opinion that if an RSS limit is 
working it would be a hard limit. The alternative is a process which 
gets large and then when memory pressure increases the oversize process 
either causes a lot of swapping or worse yet ties up a lot of memory if 
swap rate is limited.

There are many ways to tune Linux badly, adding one more will not add 
much to the pain if the default is off. The values available to a normal 
users might be limited to prevent the most obvious bad choices. Or a 
corresponding option could be provided to take corrective action for a 
process with RSS set (to any value) and swap rate high.

