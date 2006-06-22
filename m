Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751845AbWFVR0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751845AbWFVR0A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 13:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751846AbWFVR0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 13:26:00 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:62454 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751845AbWFVRZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 13:25:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cSQSky0nPL/YxFI3pZk5yI3x7OnTt5L3vQGlj3EVkwdgiWK0tfQ5p5TyFGnP9GXDq7pQoUHpVRfMoENTsfGVdke+ZQau7zkihrMyKjxOQApDU+hJktld4ydbSMZtjmDkX1oiBQU+/cbDGuubahLgRqc/z2A7VcncKsu6Y50hg30=
Message-ID: <cda58cb80606221025y63906e81wbec9597b94069b6a@mail.gmail.com>
Date: Thu, 22 Jun 2006 19:25:57 +0200
From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
To: "Mel Gorman" <mel@csn.ul.ie>
Subject: Re: 2.6.17-mm1
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0606221649070.5869@skynet.skynet.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060621034857.35cfe36f.akpm@osdl.org>
	 <449AB01A.5000608@innova-card.com>
	 <Pine.LNX.4.64.0606221617420.5869@skynet.skynet.ie>
	 <449ABC3E.5070609@innova-card.com>
	 <Pine.LNX.4.64.0606221649070.5869@skynet.skynet.ie>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/6/22, Mel Gorman <mel@csn.ul.ie>:
> On Thu, 22 Jun 2006, Franck Bui-Huu wrote:
>
> > Mel Gorman wrote:
> >> On Thu, 22 Jun 2006, Franck Bui-Huu wrote:
> >>>
> >>> Should ARCH_PFN_OFFSET macro be used instead in order to make pfn/page
> >>> convertions work when node 0 start offset do not start at 0 ?
> >>>
> >>
> >> What happens if you have ARCH_PFN_OFFSET as
> >>
> >> #define ARCH_PFN_OFFSET (0UL)
> >>
> >> ?
> >
> > It's the default value (see memory_model.h). It means that pfn start
> > for node 0 is 0, therefore your physical memory address starts at 0.
> >
>
> I know, but what I'm getting at is that ARCH_PFN_OFFSET may be unnecessary
> with flatmem-relax-requirement-for-memory-to-start-at-pfn-0.patch applied.

yes it seems so. But ARCH_PFN_OFFSET has been used before your patch
has been sent. So your patch seems to be incomplete...

> ARCH_PFN_OFFSET is used as
>
> #define page_to_pfn(page)       ((unsigned long)((page) - mem_map) + \
>                                   ARCH_PFN_OFFSET)
>
> because it knew that the map may not start at PFN 0. With
> flatmem-relax-requirement-for-memory-to-start-at-pfn-0.patch, the map will
> start at PFN 0 even if physical memory does not start until later.
>

well your approach's trick is on the mem_map address whereas
ARCH_PFN_OFFSET's one is on the computation of the index. Your
solution may result in smaller kernel (when ARCH_PFN_OFFSET != 0)
because in your case page/pfn conversion is simpler.

Maybe in your patch instead of doing:

        map -= pgdat->node_start_pfn;

you could do:

        map -= ARCH_OFFSET_PFN;

-- 
               Franck
