Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932514AbWBIO1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514AbWBIO1X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 09:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbWBIO1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 09:27:22 -0500
Received: from fmr22.intel.com ([143.183.121.14]:18898 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S932514AbWBIO1V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 09:27:21 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Lhms-devel] Re: [RFC:PATCH(003/003)] Memory add to onlined node. (ver. 2) (For x86_64)
Date: Thu, 9 Feb 2006 06:27:04 -0800
Message-ID: <D36CE1FCEFD3524B81CA12C6FE5BCAB00C59CC5D@fmsmsx406.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Lhms-devel] Re: [RFC:PATCH(003/003)] Memory add to onlined node. (ver. 2) (For x86_64)
Thread-Index: AcYtXn1wDb1WJjiFTsuWx4UKDI4x+AAJPQQQ
From: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
To: "Yasunori Goto" <y-goto@jp.fujitsu.com>, "Andi Kleen" <ak@suse.de>,
       "keith" <kmannth@us.ibm.com>
Cc: "Brown, Len" <len.brown@intel.com>, "S, Naveen B" <naveen.b.s@intel.com>,
       "Bjorn Helgaas" <bjorn.helgaas@hp.com>,
       "Linux Kernel ML" <linux-kernel@vger.kernel.org>,
       "ACPI-ML" <linux-acpi@vger.kernel.org>,
       "x86-64 Discuss" <discuss@x86-64.org>,
       "Linux Hotplug Memory Support" <lhms-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 09 Feb 2006 14:27:07.0028 (UTC) FILETIME=[E78BF540:01C62D84]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yasunori Goto <> wrote:
> BTW, I have 2 question about x86_64's memory hot-add.
> 
> Q1)
>>  int add_memory(u64 start, u64 size)
>>  {
>> -	struct pglist_data *pgdat = NODE_DATA(0);
>> -	struct zone *zone = pgdat->node_zones + MAX_NR_ZONES-2;
> 
> Current code adds memory to ZONE_NORMAL like this.
> But, ZONE_DMA32 is available on 2.6.15. So, I'm afraid there are
> 2 types trouble.
> 
>   a) When new memory is added to < 4GB, this should be added to
>      Zone_DMA32.
>      Are there any real machine which allow to add memory under
>      4GB?

The Intel machine that supports this will not hot-add memory in
the physical address space below 4GB, even if you only have 1GB
before hot-adding.  There are too many restrictions and gotchas
involved in the lower 4GB.  Keith has the only other machine that
I'm aware of and I would guess that machine has similar restrictions.
Keith?  

>   b) If machine boots up with under 4GB memory, and new memory
>      is added to over 4GB, then kernel might panic due to Zone
>      Normal's initialization is imcomplete.

I do recall a problem like that a while back where the free lists
weren't initialized properly before hot-adding.  It was fixed
when I submitted the hot-add patches, but I haven't looked in the 
past two weeks or so. 

> Q2)
>   Are there any real machine which can add memory with NUMA feature?
>   Or will be there?
>   In my patch, I assume that DSDT is defined well for NUMA by
>   firmware. (Container device, Memory device...).

I don't currently know of one that is available, but I would 
venture a guess that we would use ACPI to notify the OS, via
the DSDT or perhaps an SSDT.   

matt
