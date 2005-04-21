Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261496AbVDUQJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbVDUQJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 12:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbVDUQJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 12:09:58 -0400
Received: from fmr18.intel.com ([134.134.136.17]:50659 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261496AbVDUQJx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 12:09:53 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [discuss] [Patch] X86_64 TASK_SIZE cleanup - more comments
Date: Fri, 22 Apr 2005 00:09:47 +0800
Message-ID: <894E37DECA393E4D9374E0ACBBE74270013E8B96@pdsmsx402.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [discuss] [Patch] X86_64 TASK_SIZE cleanup - more comments
Thread-Index: AcVGaQEjTd1Wp+AEThekXkZ4m10c9QAH/03g
From: "Zou, Nanhai" <nanhai.zou@intel.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <discuss@x86-64.org>, <linux-kernel@vger.kernel.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
X-OriginalArrivalTime: 21 Apr 2005 16:09:47.0864 (UTC) FILETIME=[8A3E6D80:01C5468C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,
PPC64 IA64 and S390 use variable size TASK_SIZE for 32 bit and 64 bit
program.
I feel it is hard to maintain if we try to audit TASK_SIZE use
everywhere, because most of them are in generic code.

And maintaining those audit code in separate place is also a problem.
E.g. in current 32 bit emulation code
TASK_SIZE is defined as 0xfffffff in elf loading, but defined as
0xffffe000 in mmaping.

How did that earlier patch break applications?

Thanks
Zou Nan hai
> -----Original Message-----
> From: Andi Kleen [mailto:ak@suse.de]
> Sent: Thursday, April 21, 2005 7:54 PM
> To: Zou, Nanhai
> Cc: Andi Kleen; discuss@x86-64.org; linux-kernel@vger.kernel.org;
Siddha,
> Suresh B
> Subject: Re: [discuss] [Patch] X86_64 TASK_SIZE cleanup - more
comments
> 
> 
> Another comment:
> 
> In general I am not too happy about the variable size TASK_SIZE.
> There was a patch for this earlier, but it broke 32bit emulation
> completely. And I think it needs auditing of all uses of TASK_SIZE,
> because I suspect there are more bugs lurking in it.
> 
> The way hugetlb etc. mmap were supposed to be handled was to
> let the mmap succeed and then check in the mmap wrapper
> if any address is > 4GB and free it. Probably that code
> has some problems or got broken (I think it worked at least
> in 2.4, but there might have been regressions later)
> 
> -Andi
