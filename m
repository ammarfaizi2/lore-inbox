Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbWDTXwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbWDTXwI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 19:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbWDTXvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 19:51:13 -0400
Received: from mga07.intel.com ([143.182.124.22]:18308 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S932145AbWDTXvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 19:51:03 -0400
X-IronPort-AV: i="4.04,142,1144047600"; 
   d="scan'208"; a="25831830:sNHT1025407012"
X-IronPort-AV: i="4.04,142,1144047600"; 
   d="scan'208"; a="25813670:sNHT15062649"
TrustExchangeSourcedMail: True
X-IronPort-AV: i="4.04,142,1144047600"; 
   d="scan'208"; a="25813659:sNHT17672144"
Message-Id: <20060420232456.712271992@csdlinux-2.jf.intel.com>
Date: Thu, 20 Apr 2006 16:24:56 -0700
From: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
To: Anderw Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Keith Owens <kaos@americas.sgi.com>,
       Dean Nelson <dnc@americas.sgi.com>, Tony Luck <tony.luck@intel.com>,
       Anath Mavinakayanahalli <ananth@in.ibm.com>,
       Prasanna Panchamukhi <prasanna@in.ibm.com>,
       Dave M <davem@davemloft.net>, Andi Kleen <ak@suse.de>
Subject: [(take 2)patch 0/7] Notify page fault call chain
X-OriginalArrivalTime: 20 Apr 2006 23:50:58.0396 (UTC) FILETIME=[458789C0:01C664D5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently in the do_page_fault() code path, we call
notify_die(DIE_PAGE_FAULT, ...) to notify the page fault. 
Since notify_die() is highly overloaded, this page fault  
notification is currently being sent to all the components
registered   with  register_die_notification()  which  uses  the  same
die_chain to loop for all the registered components which is unnecessary.

In order to optimize the do_page_fault() code path, this critical page
fault notification is now moved to different call chain and 
the test results showed great improvements.

And the kprobes which is interested in this notifications, now registers
onto this new call chain only when it need to, i.e Kprobes now registers
for page fault notification only when their are an active probes and
unregisters from this page fault notification when no probes are active.

I have incorporated all the feedback given by Ananth and Keith and everyone,
and thanks for all the review feedback.

Andrew, please apply this patch to your mm tree and I would gladly fix
if their are any other issues.

thanks,
Anil Keshavamurthy

--
