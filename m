Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293181AbSCWOEM>; Sat, 23 Mar 2002 09:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293182AbSCWOEB>; Sat, 23 Mar 2002 09:04:01 -0500
Received: from pc3-camc5-0-cust13.cam.cable.ntl.com ([80.4.125.13]:2017 "EHLO
	fenrus.demon.nl") by vger.kernel.org with ESMTP id <S293181AbSCWODz>;
	Sat, 23 Mar 2002 09:03:55 -0500
Date: Sat, 23 Mar 2002 14:01:31 GMT
Message-Id: <200203231401.g2NE1VU05526@fenrus.demon.nl>
From: arjan@fenrus.demon.nl
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: Patch to split kmalloc in sd.c in 2.4.18+
In-Reply-To: <3C9C80AA.1080800@evision-ventures.com>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.9-31 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3C9C80AA.1080800@evision-ventures.com> you wrote:
> Pete Zaitcev wrote:
>> Hello:
>> 
>> One problem I see when trying to use a box with 128 SCSI disks
>> is that sd_mod sometimes refuses to load. Earlier kernels simply
>> oopsed when it happened, but that is fixed in 2.4.18. The root
>> of the evil is the enormous array sd[] that sd_init allocates.
>> Alan suggested to split the allocation, which is what I did.
>> 
>> Arjan said that it may be easier to use vmalloc, and sure it is.
>> However, I heard that vmalloc space is not too big, so it may
>> make sense to conserve it (especially on non-x86 32-bitters).
> 
> kmalloc is spare - the vmalloc space is *HUUUUUGE*.

64Mb (effective usable size) is HUGE. sure. but you share it
with all other vmalloc users. I agree with Pete that kmalloc is the
superior solution; I mentioned vmalloc to him before because that would
have been the minimal fix; Pete decided to fix it for real... 
(also vmalloc is also rather slow for hotpaths due to tlb effects)
