Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265441AbTIDSXv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 14:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265442AbTIDSXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 14:23:51 -0400
Received: from fmr09.intel.com ([192.52.57.35]:17127 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S265441AbTIDSXo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 14:23:44 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [PATCH] linux-2.6.0-test4_cyclone-hpet-fix_A0
Date: Thu, 4 Sep 2003 11:23:39 -0700
Message-ID: <C8C38546F90ABF408A5961FC01FDBF1902C7D23D@fmsmsx405.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] linux-2.6.0-test4_cyclone-hpet-fix_A0
Thread-Index: AcNzDmmNt8ZB7lE8SMmSY0r7cUkKOwAAOoUw
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "john stultz" <johnstul@us.ibm.com>
Cc: "Andrew Morton" <akpm@osdl.org>, "lkml" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Sep 2003 18:23:40.0179 (UTC) FILETIME=[AA172E30:01C37311]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: john stultz [mailto:johnstul@us.ibm.com] 
> Sent: Thursday, September 04, 2003 10:54 AM
> To: Pallipadi, Venkatesh
> Cc: Andrew Morton; lkml
> Subject: RE: [PATCH] linux-2.6.0-test4_cyclone-hpet-fix_A0
> 
> 
> On Thu, 2003-09-04 at 10:21, Pallipadi, Venkatesh wrote:
> 
> > How about the attached patch (against mm4), that moves all 
> > calibrate tsc functions into a common file, avoiding the 
> duplication. 
> > This time I could successfully compile cyclone timer too 
> :). However,
> 
> Looks better, any reason calibrate_tsc and calibrate_tsc_hpet can't be
> unified (it looks like the same basic code just talking to different
> hardware)? I was planning on giving that a shot later today.


The best solution will be to unify calibrate_tsc and calibrate_tsc_hpet.
Only issue is, we need to switch between pit based mach_count* routines
and HPET based ones at runtime. As we want to use pit, even when HPET is

configured in and is not available in the hardware. So, "mach_timer.h" 
mechanism may not work as is. 


> 
> > I had to do an unrelated one line change in fixmap (last chunk in 
> > the patch) to compile for summit.
> 
> Is this just an -mm only thing (2.5 has _X86_CYCLONE_TIMER 
> everywhere)?

Yes. This seems to be mm4 only issue, coming from 4G-4G 
patch and cyclone-fixmap-fix.patch


Thanks,
-Venkatesh
