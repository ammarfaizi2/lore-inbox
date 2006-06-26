Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932333AbWFZL1D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbWFZL1D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 07:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbWFZL1D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 07:27:03 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:30304 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932333AbWFZL1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 07:27:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=mT/IOimmedjWEXdmF0YOuUSP2AkAYwsTa7ZNZ4RtJithesIiU5SbsPooU/o+oaD+2N+9TdltDfYJVCFd7B9phss+WUj/qkGV1Vng6p0nfFx+z/hFbxf7rWPB5qJVDQiHIHebTYJtqo0EZL9TqjymI6+VA0hYGks9NwIrcwrScRs=
Message-ID: <449FC592.8050409@innova-card.com>
Date: Mon, 26 Jun 2006 13:31:30 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Mel Gorman <mel@csn.ul.ie>
CC: Franck <vagabon.xyz@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-mm1
References: <20060621034857.35cfe36f.akpm@osdl.org> <449AB01A.5000608@innova-card.com> <Pine.LNX.4.64.0606221617420.5869@skynet.skynet.ie> <449ABC3E.5070609@innova-card.com> <Pine.LNX.4.64.0606221649070.5869@skynet.skynet.ie> <cda58cb80606221025y63906e81wbec9597b94069b6a@mail.gmail.com> <20060623102037.GA1973@skynet.ie> <449BDCF5.6040808@innova-card.com> <20060623134634.GA6071@skynet.ie> <449C036D.6060004@innova-card.com> <20060623151322.GA13130@skynet.ie> <449C0DF3.601@innova-card.com> <Pine.LNX.4.64.0606231728040.13746@skynet.skynet.ie> <449F9B4C.6000404@innova-card.com> <Pine.LNX.4.64.0606261011480.24431@skynet.skynet.ie>
In-Reply-To: <Pine.LNX.4.64.0606261011480.24431@skynet.skynet.ie>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
From: Franck Bui-Huu <fbh.work@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman wrote:
> 
> Architectures will not always have a known fixed start of physical
> memory. On IA64 at least, they initialise memory as if it starts at 0
> but on my one test machine, the beginning part is always a memory hole.

in that case ARCH_PFN_OFFSET is 0 which is the old behaviour, nothing
change...

> I've seen nothing to indicate that this hole will be the same size on
> all IA64 machines but I kinda doubt it. Also, arches that use
> init_bootmem() do not necessary use free_area_init().
> 

but in that case do they use ARCH_PFN_OFFSET != 0 ? if so that would be
very surprising. That would meand "I have a hole a the start of my mem,
I don't know at compile time where it starts, but I state that my physical
mem start at ARCH_PFN_OFFSET anyways"

>> If we don't change init_bootmem() to use ARCH_PFN_OFFSET, then the
>> kernel will initialise the start of memory to 0 which is boggus.
>> IOW,
>> we can't use this function without this change (except if your memory
>> start at 0 of course). And I think that init_bootmem() has been
>> implemented for systems which have only one node _whatever_ memory
>> start value...
>>
> 
> While you may be right, it'll only fix the problem for arches with
> ARCH_PFN_OFFSET and using init_bootmem (which is the case of MIPS I
> guess). But arches using init_bootmem_node or not using free_area_init()
> may still get kicked.
> 

Again in these cases, I doubt that they will setup ARCH_PFN_OFFSET...

		Franck
