Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751053AbWDSTNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbWDSTNe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 15:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbWDSTNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 15:13:34 -0400
Received: from mga06.intel.com ([134.134.136.21]:22134 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751026AbWDSTNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 15:13:33 -0400
X-IronPort-AV: i="4.04,136,1144047600"; 
   d="scan'208"; a="25113884:sNHT51453885"
X-IronPort-AV: i="4.04,136,1144047600"; 
   d="scan'208"; a="25113852:sNHT33989459"
TrustExchangeSourcedMail: True
X-IronPort-AV: i="4.04,136,1144047600"; 
   d="scan'208"; a="25113845:sNHT33310263"
Message-Id: <20060419190059.452500615@csdlinux-2.jf.intel.com>
Date: Wed, 19 Apr 2006 12:00:59 -0700
From: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
To: Anderw Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Keith Owens <kaos@americas.sgi.com>,
       Dean Nelson <dnc@americas.sgi.com>, Tony Luck <tony.luck@intel.com>,
       Ananth Mavinakayanahalli <ananth@in.ibm.com>,
       Prasanna Panchamukhi <prasanna@in.ibm.com>,
       Dave M <davem@davemloft.net>
Subject: [patch 0/6] Notify page fault call chain
X-OriginalArrivalTime: 19 Apr 2006 19:10:22.0493 (UTC) FILETIME=[E822DCD0:01C663E4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Currently in the do_page_fault() code path, we call notify_die(DIE_PAGE_FAULT, ...)
to notify the page fault. The only interested components for this page fault
notifications are Kprobes and/or kdb. Since notify_die() is highly overloaded,
this page fault notification is currently being sent to other components
registered with register_die_notification() which uses the same die_chain to loop
for all the registered components.

In order to optimize the do_page_fault() code path, this critical page fault notification
is now moved to different call chain and the test results showed great improvements.

Patches for i386, x86_64, ia64, powerpc and sparc64 follows this mail.

Please apply.

Thanks,
Anil Keshavamurthy

--
