Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbWDUAlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWDUAlQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 20:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbWDUAlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 20:41:16 -0400
Received: from mga05.intel.com ([192.55.52.89]:38691 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S932183AbWDUAlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 20:41:14 -0400
X-IronPort-AV: i="4.04,142,1144047600"; 
   d="scan'208"; a="26649004:sNHT37707152"
X-IronPort-AV: i="4.04,142,1144047600"; 
   d="scan'208"; a="25849368:sNHT18315416"
TrustExchangeSourcedMail: True
X-IronPort-AV: i="4.04,142,1144047600"; 
   d="scan'208"; a="25849361:sNHT17285107"
Date: Thu, 20 Apr 2006 17:38:47 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Keith Owens <kaos@sgi.com>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       Anderw Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Dean Nelson <dcn@sgi.com>, Tony Luck <tony.luck@intel.com>,
       Anath Mavinakayanahalli <ananth@in.ibm.com>,
       Prasanna Panchamukhi <prasanna@in.ibm.com>,
       Dave M <davem@davemloft.net>, Andi Kleen <ak@suse.de>
Subject: Re: [(take 2)patch 6/7] Kprobes registers for notify page fault
Message-ID: <20060420173846.B12536@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <20060420233912.410449785@csdlinux-2.jf.intel.com> <18550.1145578444@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <18550.1145578444@ocs3.ocs.com.au>; from kaos@sgi.com on Fri, Apr 21, 2006 at 10:14:04AM +1000
X-OriginalArrivalTime: 21 Apr 2006 00:41:13.0158 (UTC) FILETIME=[4A77B660:01C664DC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2006 at 10:14:04AM +1000, Keith Owens wrote:
> Anil S Keshavamurthy (on Thu, 20 Apr 2006 16:25:02 -0700) wrote:
> >---
> >@@ -654,6 +659,9 @@ static int __init init_kprobes(void)
> > 	if (!err)
> > 		err = register_die_notifier(&kprobe_exceptions_nb);
> > 
> >+	if (!err)
> >+		err = register_page_fault_notifier(&kprobe_page_fault_nb);
> >+
> > 	return err;
> > }
> > 
> 
> The rest of the patches look OK, but this one does not.  init_kprobes()
> registers the main kprobe exception handler, not the page fault
> handler.
I am registering for register_page_fault_notifier() and as you can see
I am not deleting the old register_die_notifier() which is also required
for getting notified on int3/break and single-step traps. 
So no issues here.

> 
> Now that there is a dedicated page fault handler, instead of being a
> subcase of notify_die(), it might be better to delete DIE_PAGE_FAULT
> completely.  That can be done in this patch set or in some follow on
> patches.
It can be done as a follow up (cleanup patch) and if you see the whole
whole DIE_XXXX is grossly missnamed. I did not want to address two many
things in one patch.

thanks,
-Anil Keshavamurthy
