Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932829AbWFVHlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932829AbWFVHlD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 03:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932828AbWFVHlB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 03:41:01 -0400
Received: from mga01.intel.com ([192.55.52.88]:27461 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S932295AbWFVHlA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 03:41:00 -0400
X-IronPort-AV: i="4.06,164,1149490800"; 
   d="scan'208"; a="56655461:sNHT3843809242"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.17-mm1 - possible recursive locking detected
Date: Thu, 22 Jun 2006 03:40:36 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6CF0D02@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.17-mm1 - possible recursive locking detected
Thread-Index: AcaVuLhLKuGrbAtQTrqfWNXDBvRPQQAFSQXA
From: "Brown, Len" <len.brown@intel.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <michal.k.k.piotrowski@gmail.com>, <mingo@elte.hu>,
       <arjan@linux.intel.com>, <linux-kernel@vger.kernel.org>,
       <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>
X-OriginalArrivalTime: 22 Jun 2006 07:40:39.0968 (UTC) FILETIME=[28AAAA00:01C695CF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Nothing jumps out at me as incorrect above, so 
>> at this point it looks like a CONFIG_LOCKDEP artifact --
>> but lets ask the experts:-)
>
>Yes, lockdep uses the callsite of spin_lock_init() to detect 
>the "type" of
>a lock.
>
>But the ACPI obfuscation layers use the same spin_lock_init() site to
>initialise two not-the-same locks, so lockdep decides those 
>two locks are of the same "type" and gets confused.

interesting definition of "type".  I guess it works
in practice or others would be complaining...

>We had earlier decided to remove that ACPI code which kmallocs a single
>spinlock.  When that's done, lockdep will become unconfused.

Yes, that change is already on the way.
The key thing here is that our recent changes in
how the locks are _used_ is okay -- and I think it is.

thanks,
-Len
