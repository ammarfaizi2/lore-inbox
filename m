Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbVIGQIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbVIGQIr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 12:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbVIGQIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 12:08:47 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:41477 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751211AbVIGQIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 12:08:47 -0400
Message-ID: <431F11FF.2000704@tmr.com>
Date: Wed, 07 Sep 2005 12:14:55 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: vatsa@in.ibm.com
CC: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, ck list <ck@vds.kolivas.org>, rmk+lkml@arm.linux.org.uk
Subject: Re: [PATCH 1/3] dynticks - implement no idle hz for x86
References: <20050831165843.GA4974@in.ibm.com> <200509031801.09069.kernel@kolivas.org> <20050903090650.B26998@flint.arm.linux.org.uk> <200509031814.49666.kernel@kolivas.org> <20050904201054.GA4495@us.ibm.com> <20050904212616.B11265@flint.arm.linux.org.uk> <20050905053225.GA4294@in.ibm.com> <20050905054813.GC25856@us.ibm.com> <20050905063229.GB4294@in.ibm.com>
In-Reply-To: <20050905063229.GB4294@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri wrote:
> On Sun, Sep 04, 2005 at 10:48:13PM -0700, Nishanth Aravamudan wrote:
> 
>>Admittedly, I don't think SMP ARM has been around all that long? Maybe
>>the existing code just has not been extended.
> 
> 
> Yeah, maybe ARM never cared for SMP. But we do care :)
> 
> 
>>I'm not sure on this. It's going to be NULL for other architectures, or
>>end up being called by the reprogram() call for the last CPU to go idle,
>>right (presuming there isn't a separate TOD source, like in x86). I
>>think it is better to be in the reprogram() interface.
> 
> 
> Non-x86 could have it set to NULL, in which case it doesn't get called.
> (I know the current code does not take care of this situation).
> But having an explicit 'all_cpus_idle' interface may be good, since 
> Tony talked of idling some devices when all CPUs are idle. So it
> probably has non-x86/PIT uses too.

If this is intended to reduce power, and it originally came from that 
root, then this is the time to put in a hook for transitions to<=>from 
the all-idle state. Various arch may have things other than the PIT 
which should (or at least can) be stopped, and which need to be restarted.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
