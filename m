Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbWDUBG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbWDUBG3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 21:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbWDUBG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 21:06:29 -0400
Received: from mga06.intel.com ([134.134.136.21]:4517 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S932197AbWDUBG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 21:06:28 -0400
X-IronPort-AV: i="4.04,142,1144047600"; 
   d="scan'208"; a="25838081:sNHT55715506"
X-IronPort-AV: i="4.04,142,1144047600"; 
   d="scan'208"; a="25838065:sNHT48685882"
TrustExchangeSourcedMail: True
X-IronPort-AV: i="4.04,142,1144047600"; 
   d="scan'208"; a="26657353:sNHT63270781"
Date: Thu, 20 Apr 2006 18:03:58 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Keith Owens <kaos@sgi.com>
Cc: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>,
       Anderw Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Dean Nelson <dcn@sgi.com>, Tony Luck <tony.luck@intel.com>,
       Anath Mavinakayanahalli <ananth@in.ibm.com>,
       Prasanna Panchamukhi <prasanna@in.ibm.com>,
       Dave M <davem@davemloft.net>, Andi Kleen <ak@suse.de>
Subject: Re: [(take 2)patch 6/7] Kprobes registers for notify page fault
Message-ID: <20060420180357.A12662@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <20060420173846.B12536@unix-os.sc.intel.com> <19743.1145580809@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <19743.1145580809@ocs3.ocs.com.au>; from kaos@sgi.com on Fri, Apr 21, 2006 at 10:53:29AM +1000
X-OriginalArrivalTime: 21 Apr 2006 01:06:26.0091 (UTC) FILETIME=[D03EF7B0:01C664DF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2006 at 10:53:29AM +1000, Keith Owens wrote:
> Keshavamurthy Anil S (on Thu, 20 Apr 2006 17:38:47 -0700) wrote:
> >On Fri, Apr 21, 2006 at 10:14:04AM +1000, Keith Owens wrote:
> >> Anil S Keshavamurthy (on Thu, 20 Apr 2006 16:25:02 -0700) wrote:
> >> >---
> >> >@@ -654,6 +659,9 @@ static int __init init_kprobes(void)
> >> > 	if (!err)
> >> > 		err = register_die_notifier(&kprobe_exceptions_nb);
> >> > 
> >> >+	if (!err)
> >> >+		err = register_page_fault_notifier(&kprobe_page_fault_nb);
> >> >+
> >> > 	return err;
> >> > }
> >> > 
> >> 
> >> The rest of the patches look OK, but this one does not.  init_kprobes()
> >> registers the main kprobe exception handler, not the page fault
> >> handler.
> >I am registering for register_page_fault_notifier() and as you can see
> >I am not deleting the old register_die_notifier() which is also required
> >for getting notified on int3/break and single-step traps. 
> >So no issues here.
> 
> Patch 7 conditionally registers a page fault handler, plus an
> unregister when there are no user space probes.  Why does patch 6
> unconditionally register a page fault handler?
Patch 7 is the improvement of patch 6, so in other words the patch
7 removes the patch 6's unconditional registration and adds
conditional registration support. 

-Anil
