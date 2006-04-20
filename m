Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbWDTEuR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbWDTEuR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 00:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbWDTEuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 00:50:16 -0400
Received: from mga06.intel.com ([134.134.136.21]:51096 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751271AbWDTEuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 00:50:14 -0400
X-IronPort-AV: i="4.04,137,1144047600"; 
   d="scan'208"; a="25316368:sNHT16896341"
X-IronPort-AV: i="4.04,137,1144047600"; 
   d="scan'208"; a="25316353:sNHT16996994"
TrustExchangeSourcedMail: True
X-IronPort-AV: i="4.04,137,1144047600"; 
   d="scan'208"; a="25316347:sNHT22785735"
Date: Wed, 19 Apr 2006 21:47:49 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       Anderw Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Keith Owens <kaos@sgi.com>, Dean Nelson <dcn@sgi.com>,
       Tony Luck <tony.luck@intel.com>,
       Ananth Mavinakayanahalli <ananth@in.ibm.com>,
       Prasanna Panchamukhi <prasanna@in.ibm.com>,
       Dave M <davem@davemloft.net>, Andi Kleen <ak@suse.de>,
       Robin Holt <holt@sgi.com>
Subject: Re: [(resend)patch 3/7] Notify page fault call chain for ia64
Message-ID: <20060419214748.B6150@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <20060419221948.015059242@csdlinux-2.jf.intel.com> <7375.1145499505@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <7375.1145499505@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Thu, Apr 20, 2006 at 12:18:25PM +1000
X-OriginalArrivalTime: 20 Apr 2006 04:50:12.0447 (UTC) FILETIME=[E8908EF0:01C66435]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2006 at 12:18:25PM +1000, Keith Owens wrote:
> Why is register_page_fault_notifier defined in traps.c?  Surely it
> should be in mm/fault.c, which is the only place that uses the chain.
Ah..that is because I blindly followed {register/unregister}_die_notifier()
implementation. It can moved to mm/faults.c and I will rework my patch.

> 
> > trap_init (void)
> > {
> >Index: linux-2.6.17-rc1-mm3/arch/ia64/mm/fault.c
> >===================================================================
> >--- linux-2.6.17-rc1-mm3.orig/arch/ia64/mm/fault.c
> >+++ linux-2.6.17-rc1-mm3/arch/ia64/mm/fault.c
> >@@ -84,7 +84,7 @@ ia64_do_page_fault (unsigned long addres
> > 	/*
> > 	 * This is to handle the kprobes on user space access instructions
> > 	 */
> >-	if (notify_die(DIE_PAGE_FAULT, "page fault", regs, code, TRAP_BRKPT,
> >+	if (notify_page_fault(DIE_PAGE_FAULT, "page fault", regs, code, TRAP_BRKPT,
> > 					SIGSEGV) == NOTIFY_STOP)
> > 		return;
> 
> Since this is a critical path, please remove all references to
> notify_page_fault() and its register functions when CONFIG_KPROBES=n.
Yes, I agree with you and thanks for your feedback.

-Anil
