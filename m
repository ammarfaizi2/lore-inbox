Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262498AbSIZLiO>; Thu, 26 Sep 2002 07:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262501AbSIZLiO>; Thu, 26 Sep 2002 07:38:14 -0400
Received: from [203.117.131.12] ([203.117.131.12]:20952 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S262498AbSIZLiM>; Thu, 26 Sep 2002 07:38:12 -0400
Message-ID: <3D92F2D9.3050308@metaparadigm.com>
Date: Thu, 26 Sep 2002 19:43:21 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre10aa4 OOPS in ext3 (get_hash_table, unmap_underlying_metadata)
References: <3D92A1D0.5000203@metaparadigm.com> <3D92B6F3.1428A76A@digeo.com> <3D92BDC8.8080603@metaparadigm.com> <3D92BF0C.DBDDFA38@digeo.com> <20020926111234.GC11333@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/26/02 19:12, Andrea Arcangeli wrote:
> On Thu, Sep 26, 2002 at 01:02:20AM -0700, Andrew Morton wrote:
> 
>>Michael Clark wrote:
>>
>>>On 09/26/02 15:27, Andrew Morton wrote:
>>>
>>>>Michael Clark wrote:
>>>>
>>>>
>>>>>Hiya,
>>>>>
>>>>>Been having frequent (every 4-8 days) oopses with 2.4.19pre10aa4 on
>>>>>a moderately loaded server (100 users - 0.4 load avg).
>>>>>
>>>>>The server is a Intel STL2 with dual P3, 1GB RAM, Intel Pro1000T
>>>>>and Qlogic 2300 Fibre channel HBA.
>>>>>
>>>>>We are running qla2300, e1000 and lvm modules unmodified as present in
>>>>>2.4.19pre10aa4. We also have quotas enabled on 1 of the ext3 fs.
>>>>>
>>>>
>>>>
>>>>It's not familiar, sorry.
>>>
>>>Maybe I should try XFS? I've heard of people running this for
>>>80+ days and no downtime. I really would like to get past 8 days.
>>
>>Well that would be one way of eliminating variables, and that's
>>the only way to narrow this down.   Looks like something somewhere
>>(software or hardware) has corrupted some memory.
> 
> 
> yep. This is the hardest kind of bugs to fix, since the oops (or a lkcd
> crash dump) would be almost totally useless in these cases. I'm quite
> relaxed about the core, I would look into either scsi driver or e1000
> first.

I'm pretty sure it's not e1000 as we just switched to it from
GA621's using the ns82830 driver - still had the same lookups
with a completely different eth driver (although at that stage
we were loosing the oopses).

I'm still dubious about the qlogic driver although v4.45 had
stood up to a 2 week cerberus and bonnie run with the 2.4.18pre2aa2
kernel, although this kernel also would panic every 8-10 days
under fileserver load.

Possibly an LVM interaction with the qlogic driver. Maybe i
should stick with fixed partition sizes and drop the LVM.

Due to corrupted bufferheads in the oops, it is most likely some
interaction between ext3,LVM and qlogic ???

afpd (Netatalk)
   |
ext3 with quotas
   |
LVM
   |
qlogic2300 6.0.1b1

> While I got good reports about qla drivers, I'm not sure how many people
> is testing the e1000 in pre10aa4, that's an old driver, 4.2.x, the new
> one in mainline 2.4.20 is 4.3.15. So I would suggest first of all to
> upgrade the e1000 driver, just in case (I will shortly upload a new -aa
> with all pending stuff included, but the latest one against 20pre5
> is just in sync with mainline in terms of e1000).

Okay. Hmmm, still not sure what my best next step for elimination,
still my personal hunch is LVM, ext3 or this mix. I'm sorta thinking
XFS with no LVM at the moment (or maybe I should just remove the LVM
as a first step). Trouble is it takes a week or so for the problem to
show up.

Would you suggest i tried 2.4.20pre5aa2 with its qlogic 6.1b1 (I notice
b5 is the latest) and no LVM?

>>The problem is that even if you _do_ fix the problem by switching
>>something out, the cause could lie elsewhere.

Cheers,
~mc

