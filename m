Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261248AbVCAFeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVCAFeU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 00:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbVCAFeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 00:34:20 -0500
Received: from wasp.net.au ([203.190.192.17]:37276 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S261244AbVCAFeN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 00:34:13 -0500
Message-ID: <4223FEC9.8070306@wasp.net.au>
Date: Tue, 01 Mar 2005 09:34:01 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050115)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: lkml <linux-kernel@vger.kernel.org>,
       RAID Linux <linux-raid@vger.kernel.org>
Subject: Re: Raid-6 hang on write.
References: <421DE9A9.4090902@wasp.net.au>	<421F4629.5080309@wasp.net.au> <16930.45319.682534.351648@cse.unsw.edu.au>
In-Reply-To: <16930.45319.682534.351648@cse.unsw.edu.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> On Friday February 25, brad@wasp.net.au wrote:
> 
>>Turning on debugging in raid6main.c and md.c make it much harder to hit. So I'm assuming something 
>>timing related.
>>
>>raid6d --> md_check_recovery --> generic_make_request --> make_request --> get_active_stripe
> 
> 
> Yes, there is a real problem here.  I see if I can figure out the best
> way to remedy it...
> However I think you reported this problem against a non "-mm" kernel,
> and the path from md_check_recovery to generic_make_requests only
> exists in "-mm".
> 
> Could you please confirm if there is a problem with
>     2.6.11-rc4-bk4->bk10

There is (was). I have three kernels I was testing against. 2.6.11-rc4-bk4, 2.6.11-rc4-bk10 and 
2.6.11-rc4-mm1. I moved onto 2.6.11-rc4-mm1 for my main debugging (inserting lots of printks and 
generally doing stuff that was going to crash). I hope to reproduce the faults against the vanilla 
2.6.11-rc4 kernels and I'm now testing with 2.6.11-rc5-bk2.

As per the original bug report, 2.6.11-rc4-bk(4/10) locked in [<c0268574>] 
get_active_stripe+0x224/0x260. Although unlike -mm1 I'm not sure of the sequence of events that 
caused it and it's not anywhere as easy to hit. I am willing to investigate as time allows however.

Testing 2.6.11-rc5-bk2 and it of course is flatly refusing to misbehave. I'll keep beating on it for 
a couple of days and after writing 3TB with 2.6.11-rc5-bk2, I'll go back to the older kernels and 
try and reproduce the failure there. It *did* lockup 4 times in a row in get_active_stripe on the 
older non -mm kernels.

Regards,
Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
