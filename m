Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030196AbWFZNoy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030196AbWFZNoy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 09:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030198AbWFZNox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 09:44:53 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:60878 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030200AbWFZNow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 09:44:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=LQZnxiTxE0gFH6zpzbeDZ4bXaRxo2wzeSdNwjCjE+U3HHq0oP8TM8hNIyXTArOTNVDKZRpCnDWaZZni7NzpTRZHkuSWqu3yHOR4inYJSZlk0ZAk6RNtX6s14fGKffKRlS4X0n8fMHxB0xV9XDLL4IT6vqGeSS6n2jiC6W+lN0mc=
Message-ID: <449FE5E0.3050603@innova-card.com>
Date: Mon, 26 Jun 2006 15:49:20 +0200
Reply-To: "vagabon >> Franck" <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Mel Gorman <mel@csn.ul.ie>
CC: Franck <vagabon.xyz@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-mm1
References: <20060621034857.35cfe36f.akpm@osdl.org> <449AB01A.5000608@innova-card.com> <Pine.LNX.4.64.0606221617420.5869@skynet.skynet.ie> <449ABC3E.5070609@innova-card.com> <Pine.LNX.4.64.0606221649070.5869@skynet.skynet.ie> <cda58cb80606221025y63906e81wbec9597b94069b6a@mail.gmail.com> <20060623102037.GA1973@skynet.ie> <449BDCF5.6040808@innova-card.com> <20060623134634.GA6071@skynet.ie> <449C036D.6060004@innova-card.com> <20060623151322.GA13130@skynet.ie> <449C0DF3.601@innova-card.com> <Pine.LNX.4.64.0606231728040.13746@skynet.skynet.ie> <449F9B4C.6000404@innova-card.com> <Pine.LNX.4.64.0606261011480.24431@skynet.skynet.ie> <449FC592.8050409@innova-card.com> <Pine.LNX.4.64.0606261409140.24431@skynet.skynet.ie>
In-Reply-To: <Pine.LNX.4.64.0606261409140.24431@skynet.skynet.ie>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Franck Bui-Huu <fbh.work@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman wrote:
> On Mon, 26 Jun 2006, Franck Bui-Huu wrote:
> 
>> Mel Gorman wrote:
> 
>>>>> Not all arches will use init_bootmem(). Arm for example uses
>>>>> init_bootmem_node(). ARCH_PFN_OFFSET is only meant to affect mem_map,
>>>>>
>>>> well, I don't agree here. ARCH_PFN_OFFSET is used to save the first
>>>> page number that has physical memory. I don't see why we couldn't
>>>> useit to correctly initialise the memory system...
>>>
>>> Architectures will not always have a known fixed start of physical
>>> memory. On IA64 at least, they initialise memory as if it starts at 0
>>> but on my one test machine, the beginning part is always a memory hole.
>>
>> in that case ARCH_PFN_OFFSET is 0 which is the old behaviour, nothing
>> change...
>>
> 
> The change is that ARCH_PFN_OFFSET has a slightly different meaning when
> you alter those two initialisation functions. Currently it is used to
> offset memmap from NODE_DATA(0)->node_start_pfn. By changing
> free_area_init() and init_bootmem(), it changes to altering the value of
> NODE_DATA(0)->node_start_pfn but only when memory is initialised in a
> particular way. 

well I don't see your point there. Is ARCH_PFN_OFFSET != 0 supposed to work
with free_area_init() and init_bootmem() ? If so, there is a bug since
NODE_DATA(0)->node_start_pfn is not setup correctly...

> I think we should just fix the problem at hand now for which two simple
> patches have been posted and consider making further changes to
> free_area_init() and init_bootmem() as a separate issue.
> 

I agree this is a separate issue. We should resolve it in a different thread.
Mind to start a new one that involve people who can shed some light here ?

Thanks

		Franck
