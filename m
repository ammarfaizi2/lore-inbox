Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751030AbWDSWbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030AbWDSWbo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 18:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWDSWbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 18:31:44 -0400
Received: from mga05.intel.com ([192.55.52.89]:54347 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751030AbWDSWbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 18:31:44 -0400
X-IronPort-AV: i="4.04,137,1144047600"; 
   d="scan'208"; a="25987163:sNHT40501069"
X-IronPort-AV: i="4.04,137,1144047600"; 
   d="scan'208"; a="25223858:sNHT51366427"
TrustExchangeSourcedMail: True
X-IronPort-AV: i="4.04,137,1144047600"; 
   d="scan'208"; a="25223853:sNHT41948424"
Message-Id: <20060419221419.382297865@csdlinux-2.jf.intel.com>
Date: Wed, 19 Apr 2006 15:14:19 -0700
From: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
To: Anderw Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Keith Owens <kaos@americas.sgi.com>,
       Dean Nelson <dnc@americas.sgi.com>, Tony Luck <tony.luck@intel.com>,
       Ananth Mavinakayanahalli <ananth@in.ibm.com>,
       Prasanna Panchamukhi <prasanna@in.ibm.com>,
       Dave M <davem@davemloft.net>, Andi Kleen <ak@suse.de>,
       Robin Holt <holt@sgi.com>
Subject: [(resend)patch 0/7] Notify page fault call chain 
X-OriginalArrivalTime: 19 Apr 2006 22:31:41.0795 (UTC) FILETIME=[07F61330:01C66401]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Currently in the do_page_fault() code path, we call
notify_die(DIE_PAGE_FAULT, ...) to notify the page fault. 
The only interested components for this page fault 
notifications  are  Kprobes  and/or  kdb. Since 
notify_die() is highly overloaded, this  page  fault  
notification  is  currently  being  sent  to  other
components registered with register_die_notifier()  
which  uses  the  same die_chain to loop for all 
the registered components.

In order to optimize the do_page_fault() code path, 
this critical page fault notification is now moved 
to different call chain and the test results conducted
by Robin Holt showed great improvements.

Patches for i386, x86_64, ia64, powerpc and sparc64 follows this mail.

Please apply.

Thanks,
Anil Keshavamurthy

--
