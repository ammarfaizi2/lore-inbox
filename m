Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261849AbVAYHX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261849AbVAYHX5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 02:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbVAYHX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 02:23:57 -0500
Received: from fmr15.intel.com ([192.55.52.69]:14055 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S261850AbVAYHXg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 02:23:36 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: possible CPU bug and request for Intel contacts
Date: Mon, 24 Jan 2005 23:22:30 -0800
Message-ID: <01EF044AAEE12F4BAAD955CB7506494302E61BA0@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: possible CPU bug and request for Intel contacts
Thread-Index: AcUB+arzWjtji9XBQsKzc1L1OQZ9jQAq6Tmw
From: "Seth, Rohit" <rohit.seth@intel.com>
To: "Kirill Korotaev" <dev@sw.ru>
Cc: "Linus Torvalds" <torvalds@osdl.org>, "Ingo Molnar" <mingo@elte.hu>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       "Andrey Savochkin" <saw@sawoct.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 25 Jan 2005 07:22:36.0846 (UTC) FILETIME=[A5299CE0:01C502AE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <mailto:dev@sw.ru> wrote on Monday, January 24, 2005
1:51 AM:

> Hello Rohit,
> 
>> Thanks for sending the detailed information. Based on our experiments
>> and analysis, we believe at this point that this is a known E80 issue
>> mentioned in the PIII spec update at this location
>> (http://www.intel.com/design/pentiumiii/specupdt/24445351.pdf)
> 
>> Could you please try one of the suggested work arounds for this
>> issue. 
> Yes, double cr3 reload and cpuid helps us. But rdtsc doesn't.
> 

I will have to get back to you about rdtsc.


> BTW, can you explain why making pages non-global is the cure? Is it
>   safe workaround for this bug?

There is a boundary condition that can have non-global pages containing
the CR3 load to also hit this issue on affected PIII.  Though for this
to happen, mov to cr3 has to be the very last instruction on a page.
And the page following that page (containing CR3 load) has to have
different mapping between user and kernel spaces.

> Double cr3 reload looks a bit unsafe to me, since interrupts or NMI
> can 
> occur between the reloads and probably reuse stale iTLB mappings...

Interruptions will ensure that stale mapping don't exist in ITLB fill
buffer.  So, you are okay with double CR3 laods.

Thanks, rohit

