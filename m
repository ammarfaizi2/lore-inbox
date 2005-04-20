Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbVDTRVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbVDTRVq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 13:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbVDTRTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 13:19:18 -0400
Received: from fmr17.intel.com ([134.134.136.16]:30945 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261743AbVDTRRu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 13:17:50 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [discuss] [Patch] X86_64 TASK_SIZE cleanup
Date: Thu, 21 Apr 2005 01:17:40 +0800
Message-ID: <894E37DECA393E4D9374E0ACBBE74270013E8B90@pdsmsx402.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [discuss] [Patch] X86_64 TASK_SIZE cleanup
Thread-Index: AcVD9eAOsKpZOGZ8TG+CRZo1yAFElAAPUiNwAGYEcNA=
From: "Zou, Nanhai" <nanhai.zou@intel.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <discuss@x86-64.org>, <linux-kernel@vger.kernel.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
X-OriginalArrivalTime: 20 Apr 2005 17:17:41.0274 (UTC) FILETIME=[DBC5B7A0:01C545CC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,
   What is your comment on this patch?
Here is another example bug this patch will fix.
The following piece of code will get a success mmap even if compiled
with -m32. 
   
   int *p;
   p = mmap((void *)(0xFFFFE000UL), 0x10000UL, PROT_READ|PROT_WRITE,
                MAP_FIXED|MAP_PRIVATE|MAP_ANON, 0, 0);

I believe there are other kind of corner case bugs around mm and fs. 
e.g in mremap and munmap.
Those bugs will be fixed by this patch. 

Zou Nan hai
> -----Original Message-----
> From: Zou, Nanhai
> Sent: Tuesday, April 19, 2005 12:37 AM
> To: 'Andi Kleen'
> Cc: discuss@x86-64.org; linux-kernel@vger.kernel.org; Siddha, Suresh B
> Subject: RE: [discuss] [Patch] X86_64 TASK_SIZE cleanup
> 
> 
> When a 32bit program is mapping a lot of hugepage vm_areas,
> hugetlb_get_unmapped_area may search beyond 4G, then the program will
get a
> SIGFAULT instead of an errno of ENOMEM.
> This patch will fix that.
> I believe there are other inconsistent cases in generic code like mm
and fs.
> 
> Zou Nan hai
> 
> > -----Original Message-----
> > From: Andi Kleen [mailto:ak@suse.de]
> > Sent: Monday, April 18, 2005 5:06 PM
> > To: Zou, Nanhai
> > Cc: discuss@x86-64.org; Andi Kleen; linux-kernel@vger.kernel.org;
Siddha,
> > Suresh B
> > Subject: Re: [discuss] [Patch] X86_64 TASK_SIZE cleanup
> >
> > On Sat, Apr 16, 2005 at 09:34:25AM +0800, Zou, Nanhai wrote:
> > >
> > > Hi,
> > >    This patch will clean up the X86_64 compatibility mode
TASK_SIZE
> > > define thus fix some bugs found in X86_64 compatibility mode
program.
> >
> > Fix what bugs exactly?  Please a detailed description.
> >
> > -Andi
