Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbWDSV1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbWDSV1a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 17:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbWDSV1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 17:27:30 -0400
Received: from mga05.intel.com ([192.55.52.89]:57684 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751163AbWDSV13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 17:27:29 -0400
X-IronPort-AV: i="4.04,136,1144047600"; 
   d="scan'208"; a="25961009:sNHT45444399"
X-IronPort-AV: i="4.04,136,1144047600"; 
   d="scan'208"; a="25960998:sNHT49266469"
TrustExchangeSourcedMail: True
X-IronPort-AV: i="4.04,136,1144047600"; 
   d="scan'208"; a="25960996:sNHT53506320"
Date: Wed, 19 Apr 2006 14:25:09 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Andi Kleen <ak@suse.de>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       Anderw Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Keith Owens <kaos@americas.sgi.com>, Dean Nelson <dnc@americas.sgi.com>,
       Tony Luck <tony.luck@intel.com>,
       Ananth Mavinakayanahalli <ananth@in.ibm.com>,
       Prasanna Panchamukhi <prasanna@in.ibm.com>,
       Dave M <davem@davemloft.net>
Subject: Re: [patch 2/6] Notify page fault call chain for x86_64
Message-ID: <20060419142508.A3957@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <20060419190059.452500615@csdlinux-2.jf.intel.com> <20060419190134.862282078@csdlinux-2.jf.intel.com> <200604192307.03772.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200604192307.03772.ak@suse.de>; from ak@suse.de on Wed, Apr 19, 2006 at 11:07:03PM +0200
X-OriginalArrivalTime: 19 Apr 2006 21:27:27.0377 (UTC) FILETIME=[0E8C9010:01C663F8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2006 at 11:07:03PM +0200, Andi Kleen wrote:
> On Wednesday 19 April 2006 21:01, Anil S Keshavamurthy wrote:
> 
> You seem to be missing a description/rationale here.
Sorry about that, I had the description in [patch 0/6] and looks like 
I missed you cc'ing in that patch. Any way I am copying it again here.

   "Currently    in    the    do_page_fault()    code    path,   we   call
   notify_die(DIE_PAGE_FAULT, ...) to notify the page fault. The only 
   interested components for this page fault notifications  are  Kprobes  
   and/or  kdb. Since notify_die() is highly overloaded, this  page  fault  
   notification  is  currently  being  sent  to  other components
   registered   with  register_die_notification()  which  uses  the  same
   die_chain to loop for all the registered components.

   In order to optimize the do_page_fault() code path, this critical page
   fault notification is now moved to different call chain and the 
   test results showed great improvements.

   Patches for i386, x86_64, ia64, powerpc and sparc64 follows this mail."

This patch introduces the exclusive {register/unregister}_page_fault_notifier()
for use by Kprobes and kdb.


-Anil
