Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbWEZIza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbWEZIza (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 04:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbWEZIza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 04:55:30 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:17350 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751195AbWEZIz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 04:55:29 -0400
Message-ID: <4476C27A.7040707@garzik.org>
Date: Fri, 26 May 2006 04:55:22 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: discuss@x86-64.org, Muli Ben-Yehuda <mulix@mulix.org>,
       Jon Mason <jdmason@us.ibm.com>, Muli Ben-Yehuda <muli@il.ibm.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [discuss] Re: [PATCH 2/4] x86-64: Calgary IOMMU - move valid_dma_direction
 into the callers
References: <20060525033550.GD7720@us.ibm.com> <20060525094236.GB22495@granada.merseine.nu> <44757FD3.3070805@garzik.org> <200605260957.02163.ak@suse.de>
In-Reply-To: <200605260957.02163.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Thursday 25 May 2006 11:58, Jeff Garzik wrote:
>> Muli Ben-Yehuda wrote:
>>> On Thu, May 25, 2006 at 12:35:07AM -0400, Jeff Garzik wrote:
>>>> Jon Mason wrote:
>>>>> >From Andi Kleen's comments on the original Calgary patch, move
>>>>> valid_dma_direction into the calling functions.
>>>>>
>>>>> Signed-off-by: Muli Ben-Yehuda <muli@il.ibm.com>
>>>>> Signed-off-by: Jon Mason <jdmason@us.ibm.com>
>>>> Even though BUG_ON() includes unlikely(), this introduces additional 
>>>> tests in very hot paths.
>>> Are they really very hot? I mean if you're calling the DMA API, you're
>>> about to frob the hardware or have already frobbed it - does this
>>> check really matter?
>> When you are adding a check that will _never_ be hit in production, to 
>> the _hottest_ paths in the kernel, you can be assured it matters...
> 
> pci_dma_* shouldn't be that hot. Or at least IO usually has so much
> overhead that some more bugging shouldn't matter.

I respectfully disagree with that logic.  If its a key hot path -- which 
it is, every modern network or disk I/O runs through these paths -- then 
it deserves at least _some_ consideration before adding more CPU cycles.


> On the other hand if the problem of passing wrong parameters here
> isn't common I would be ok with dropping them.

As the author noted, it was only used in early platform bring-up.  And 
simply reviewing the patch... it is clear that screwing up the 
parameters would cause massive, noticeable problems immediately -- such 
as on EM64T with swiotlb.

	Jeff


