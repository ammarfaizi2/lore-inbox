Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbVKWPvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbVKWPvG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 10:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbVKWPvC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 10:51:02 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:36259 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751153AbVKWPu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 10:50:56 -0500
Message-ID: <43838FFB.9060809@tmr.com>
Date: Tue, 22 Nov 2005 16:39:07 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Clements <paul.clements@steeleye.com>
CC: Lars Roland <lroland@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux RAID M/L <linux-raid@vger.kernel.org>
Subject: Re: Poor Software RAID-0 performance with 2.6.14.2
References: <4ad99e050511211231o97d5d7fw59b44527dc25dcea@mail.gmail.com> <438354B4.10604@tmr.com> <43836214.4010200@steeleye.com>
In-Reply-To: <43836214.4010200@steeleye.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Clements wrote:
> Bill Davidsen wrote:
> 
>> One of the advantages of mirroring is that if there is heavy read load 
>> when one drive is busy there is another copy of the data on the other 
>> drive(s). But doing 1MB reads on the mirrored device did not show that 
>> the kernel took advantage of this in any way. In fact, it looks as if 
>> all the reads are going to the first device, even with multiple 
>> processes running. Does the md code now set "write-mostly" by default 
>> and only go to the redundant drives if the first fails?
> 
> 
> No, it doesn't use write-mostly by default. The way raid1 read balancing 
> works (in recent kernels) is this:
> 
> - sequential reads continue to go to the first disk
> 
> - for non-sequential reads, the code tries to pick the disk whose head 
> is "closest" to the sector that needs to be read
> 
> So even if the reads aren't exactly sequential, you probably still end 
> up reading from the first disk most of the time. I imagine with a more 
> random read pattern you'd see the second disk getting used.

Thanks for the clarification. I think the current method is best for 
most cases, I have to think about how large a file you would need to 
have any saving in transfer time given that you have to consider the 
slowest seek, drives doing other things on a busy system, etc.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

