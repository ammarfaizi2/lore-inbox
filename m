Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266221AbUIIQ02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266221AbUIIQ02 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 12:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266218AbUIIQ02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 12:26:28 -0400
Received: from mail.tmr.com ([216.238.38.203]:36367 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S266221AbUIIQZv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 12:25:51 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: swapping and the value of /proc/sys/vm/swappiness
Date: Thu, 09 Sep 2004 12:26:11 -0400
Organization: TMR Associates, Inc
Message-ID: <chpvpj$3vs$1@gatekeeper.tmr.com>
References: <20040908235503.3f01523a.diegocg@teleline.es><20040908235503.3f01523a.diegocg@teleline.es> <50520000.1094682042@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1094746740 4092 192.168.12.100 (9 Sep 2004 16:19:00 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
In-Reply-To: <50520000.1094682042@flay>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
>>>I really don't see any point in pushing the self-tuning of the kernel out
>>>into userspace. What are you hoping to achieve?
>>
>>Well your own words explain it, I think. "it's all dependant on the workload",
>>which means that only the user knows what he is going to do with the machine
>>and that the kernel doesn't knows that, so the algoritms built in the kernel
>>may be "not perfect" in their auto-tuning job. The point would be to
>>be able to take decisions the kernel can't take because userspace would
>>know better how the system should behave, say stupids things like "I want
>>to have this set of tunables which make compile jobs 0.01% faster at 12:00
>>because at that time a cron job autocompiles cvs snapshots of some project,
>>and at 6:00 those jobs have already finished so at that time I want a set
>>of tunables optimized for my everyday desktop work which make everthing 0.01%
>>slower but the system feels a 5% more reponsive". (well, for that a shell script
>>is enought) Kernel however could try to adapt itself to those changes, and do
>>it well...I don't really know. This came to my mind when I was thinking about
>>irqbalance case, which was somewhat similar, I also remember a discussion
>>about a "ktuned" in the mailing lists...I guess it's a matter of coding it
>>and get some numbers :-/
> 
> 
> Oh, I see what you mean. I think we're much better off sticking the mechanism
> for autotuning stuff in the kernel - if we want to feed in policy from 
> userspace (which 99.9% of people will never do), it can be through such
> things as /proc/sys/vm/swapiness ... that could just fix them statically
> if people insisted on such things. 
> 
> Having the kernel do something sensible by default is what we aim for ...
> overrides still are possible if the sysadmin really thinks they're smarter ;-)

Don't need to be smarter, just to know more about program behaviour and 
desired system response than the o/s. Think of it as providing more 
information to the o/s and letting the o/s autotune with the additional 
information if that makes you feel better ;-)

The only tune I really want, and I patched it in 2.4.18 or so, is the 
ability to reserve some memory which will never be used for anything but 
program pages. Or some way to stop a program making a single pass 
through a large file (80GB) from pushing programs out of memory. I'm 
watching that now as I read the list, vmstat says si/so are about 800 
each, on a system which runs at zero otherwise.

I'm going to look at capabilities when I get that mythical free time, 
and see if I can let a few programs lock their ass in memory, having 
60-80% of RAM dedicated to once-read pages is silly.

Sorry for the rant, but this is the single most common problem I see 
with performance.


-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
