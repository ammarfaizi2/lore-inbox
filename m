Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbTKZMPI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 07:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbTKZMPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 07:15:08 -0500
Received: from natsmtp01.rzone.de ([81.169.145.166]:5112 "EHLO
	natsmtp01.rzone.de") by vger.kernel.org with ESMTP id S261309AbTKZMPC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 07:15:02 -0500
Message-ID: <3FC4993E.1010000@softhome.net>
Date: Wed, 26 Nov 2003 13:14:54 +0100
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Rik van Riel <riel@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.2/2.4/2.6 VMs: do malloc() ever return NULL?
References: <VQJL.62Q.11@gated-at.bofh.it> <VR3c.6Ns.21@gated-at.bofh.it> <3FC480BF.9060301@softhome.net> <20031126103957.GK8039@holomorphy.com>
In-Reply-To: <20031126103957.GK8039@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> Rik van Riel wrote:
> 
>>>Strict non-overcommit mode.  You can allocate as much
>>>non-file-backed virtual memory as will fit in swap,
>>>plus /proc/sys/vm/overcommit_percentage worth of memory.
> 
> 
> On Wed, Nov 26, 2003 at 11:30:23AM +0100, Ihar 'Philips' Filipau wrote:
> 
>>  [ s/overcommit_percentage/overcommit_ratio/ ]
>>  Thanks! On 2.6 it works as expected. Test with two concurrent memory 
>>allocations took some time, but both apps stops exactly when memory was 
>>depleted. Great.
>>  Did rmap has something todo with this?
>>  As I see from implementation of do_mmap_pgoff() - it changed from 2.4 
>>to 2.6 - but there are a lot of common things.
>>  If I will do dumb back port of this check to 2.4 - do you think it 
>>will work? 2.4->2.6 memory accounting changed?
>>  I didn't found this check in your rmap patches for 2.4.22. (btw 
>>thanks for keeping them up-to-date).
> 
> 
> In principle, non-overcommit shouldn't be dependent on rmap, as it
> largely consists of keeping track of the sum of MAP_PRIVATE virtual
> mappings' sizes and refusing them when they exceed RAM + swap.
> 

   That's the point of my question. I know a few about MM in Linux. As I 
understand memory accounting is most complicated: 1st how to account 
kernel allocatable memory, 2nd how to reliably calculate already 
allocated memory. (1st looks like not present even in 2.6, 2nd not 
present in 2.4.)

   As I understood, default overcommit_ratio=90% is made especially to 
protect kernel from running out of memory. And 2.6 does offset available 
memory by 3% for all non-root allocation checks.

   But I cannot find any similar accounting stuff in 2.4...
   Hard to draw parallels.

   Will appreciate any advice.

-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--                                                           _ _ _
  Because the kernel depends on it existing. "init"          |_|*|_|
  literally _is_ special from a kernel standpoint,           |_|_|*|
  because its' the "reaper of zombies" (and, may I add,      |*|*|*|
  that would be a great name for a rock band).
                                 -- Linus Torvalds

