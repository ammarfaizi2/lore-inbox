Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268260AbUIQB0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268260AbUIQB0Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 21:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268467AbUIQB0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 21:26:16 -0400
Received: from mailout.zma.compaq.com ([161.114.64.105]:24071 "EHLO
	zmamail05.zma.compaq.com") by vger.kernel.org with ESMTP
	id S268260AbUIQBZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 21:25:50 -0400
Message-ID: <414A3F37.9080804@hp.com>
Date: Thu, 16 Sep 2004 21:34:47 -0400
From: Robert Picco <Robert.Picco@hp.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-kernel@vger.kernel.org,
       Jesse Barnes <jbarnes@engr.sgi.com>, venkatesh.pallipadi@intel.com
Subject: Re: device driver for the SGI system clock, mmtimer
References: <200409161003.39258.bjorn.helgaas@hp.com> <Pine.LNX.4.58.0409160930300.6765@schroedinger.engr.sgi.com> <200409161054.51467.bjorn.helgaas@hp.com> <4149D655.5070904@hp.com> <Pine.LNX.4.58.0409161259030.7834@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.58.0409161259030.7834@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:

>On Thu, 16 Sep 2004, Robert Picco wrote:
>
>  
>
>>>Is there something specific that drivers/char/hpet.c expects that
>>>your hardware doesn't implement?
>>>      
>>>
>>Look at HPET revision history.  Specifically 0.98 01/20/2002
>>    * Product name changed: from Multimedia Timer to HPET (High
>>Precision Event Timer)
>>    
>>
>
>The HPET timer has a specific memory layout of registers that is mappable
>to user space. The mmtimer driver only allows the mapping of a single 64
>bit counter to use space. We have lots of applications at SGI
>that rely on mmtimer since mmtimer provides a locally accessible
>clock in an NUMA environment with hundreds of CPU. A hpet device would
>have to show up in the global address space and require cross node
>accesses in our NUMA environment that would make access to the timer
>slow. All CPU would content for access to a certain global memory address.
>
>The HPET hardware and the sgi mmtimer are totally different architectures
>that are not easily reconcilable.
>
>The software API to handle both is similar and we would like it to be as
>compatible as possible.
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
Ah.  Well this might be possible.  The HP HPET hardware is on each NUMA 
node. So cross node issues could be addressed. The bit counter isn't an 
open point for the HPET driver.  Only the HPET timers which march 
against the bit counter can be opened.  The current open logic in the 
driver hunts to find an available timer.  To coexist with mmtimer and 
just enabling the mmaping of the bit counter would require changing the 
driver API.  The other API issues are resolvable with little effort.  I 
think ;-)

Bob
