Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262814AbVEHFBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262814AbVEHFBo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 01:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262815AbVEHFBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 01:01:44 -0400
Received: from usbb-lacimss1.unisys.com ([192.63.108.51]:36363 "EHLO
	usbb-lacimss1.unisys.com") by vger.kernel.org with ESMTP
	id S262814AbVEHFBl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 01:01:41 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 1/1] Do not enforce unique IO_APIC_ID for Xeon processors in EM64T mode (x86_64)
Date: Sun, 8 May 2005 00:01:22 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04B50@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 1/1] Do not enforce unique IO_APIC_ID for Xeon processors in EM64T mode (x86_64)
Thread-Index: AcVThvmihjwxjc8CQOagmVxJyhbJxgAAQ+uw
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <akpm@osdl.org>, <zwane@arm.linux.org.uk>, <len.brown@intel.com>,
       <venkatesh.pallipadi@intel.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 08 May 2005 05:01:23.0114 (UTC) FILETIME=[FAF8F8A0:01C5538A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > This patch disables unique IO_APIC_ID check for xAPIC 
> systems running in EM64T mode. Xeon-based ES7000s panic 
> failing this unnecessary check. I added IOAPIC_ID_CHECK 
> config option and turned it off for Intel processors. Also 
> added the boot option that overrides default and turnes this 
> check on/off in case it is needed for some reason. Hope this 
> is acceptable way to fix the problem.
> 
> I think we can turn it off for all x86-64 systems. Near all 
> EM64T systems have xAPIC. AMD processors don't need it 
> neither. That would only leave the new IBM summit2 chipset, 
> but I suppose they also don't need this (James please 
> complain if I am wrong) 
> So can you please do a new patch that just removes this code?

Sure, I will remove the io_apic_get_unique_id() then. Perhaps, it will
be easy to put it back in if someone implements a chipset that needs it.

> More tricky will be to do the equivalent patch on i386 
> because they still need to support the pre XAPICs and have to 
> detect this case.
> I suppose an heuristic like
> if (cpu is P6 or earlier and from Intel)
> 	enable
> else
> 	disable
> would be good enough.	
>

Andi, I submitted the patch for i386 a little while ago
http://www.ussg.iu.edu/hypermail/linux/kernel/0505.0/0195.html (I sent
it to you also, but just noticed that it was not your usual email
address - where did I get if from? have no idea...) Genapic in i386 has
a NO_IOAPIC_CHECK flag that is defined in every subarch, so it was easy
to fix the problem by making use of it in ACPI boot path just as it was
used in MP path.
Thanks,
--Natalie
