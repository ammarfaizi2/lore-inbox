Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751400AbWBKK7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbWBKK7F (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 05:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbWBKK7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 05:59:04 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:39903 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751392AbWBKK7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 05:59:03 -0500
Message-ID: <43EDC35B.5060106@jp.fujitsu.com>
Date: Sat, 11 Feb 2006 19:58:35 +0900
From: Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Yasunori Goto <y-goto@jp.fujitsu.com>
CC: Dave Hansen <haveblue@us.ibm.com>, "Luck, Tony" <tony.luck@intel.com>,
       Andi Kleen <ak@suse.de>,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       linux-ia64@vger.kernel.org,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       x86-64 Discuss <discuss@x86-64.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>
Subject: Re: [Lhms-devel] [RFC/PATCH: 002/010] Memory hotplug for new nodes
 with pgdat allocation. (Wait table and zonelists initalization)
References: <20060210223841.C532.Y-GOTO@jp.fujitsu.com> <1139589128.9209.80.camel@localhost.localdomain> <20060211125941.D35C.Y-GOTO@jp.fujitsu.com>
In-Reply-To: <20060211125941.D35C.Y-GOTO@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yasunori Goto wrote:
> 
>> On Fri, 2006-02-10 at 23:20 +0900, Yasunori Goto wrote:
>>>  static __meminit
>>>  void zone_wait_table_init(struct zone *zone, unsigned long
>>> zone_size_pages)
>>>  {
>>> -       int i;
>>> +       int i, hotadd = (system_state == SYSTEM_RUNNING);
>>>         struct pglist_data *pgdat = zone->zone_pgdat;
>>> +       unsigned long allocsize;
>>>  
>>>         /*
>>>          * The per-page waitqueue mechanism uses hashed waitqueues
>>>          * per zone.
>>>          */
>>> +       if (hotadd && (zone_size_pages == PAGES_PER_SECTION))
>>> +               zone_size_pages = PAGES_PER_SECTION << 2; 
>> I don't think I understand this calculation.  You online only 4 sections
>> worth of pages?
> 
> Ummmmm.
> I realized that I've forgotten many things about this patch
> due to long time keeping in storage. 
> At least here looks strange indeed.
> I need shake my brain to recall it. :-(

Ah, I'm not sure but it was because I didn't have a patch for zone's waittable resizing,
and resizing it looked impossible. Above code was just a quick hack for the case a zone
is initialized with only 1 section.
How large it should be ? or Resizing it, is necessary to be discussed.

-- Kame


