Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbWDRXFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbWDRXFy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 19:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWDRXFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 19:05:54 -0400
Received: from mga06.intel.com ([134.134.136.21]:14359 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750793AbWDRXFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 19:05:53 -0400
X-IronPort-AV: i="4.04,131,1144047600"; 
   d="scan'208"; a="24682565:sNHT49362236"
X-IronPort-AV: i="4.04,131,1144047600"; 
   d="scan'208"; a="24682559:sNHT54584810"
TrustExchangeSourcedMail: True
X-IronPort-AV: i="4.04,131,1144047600"; 
   d="scan'208"; a="25459515:sNHT61761231"
Date: Tue, 18 Apr 2006 16:03:31 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Robin Holt <holt@sgi.com>
Cc: Keith Owens <kaos@americas.sgi.com>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       prasanna@in.ibm.com, ananth@in.ibm.com, davem@davemloft.net,
       tony.luck@intel.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: ia64_do_page_fault shows 19.4% slowdown from notify_die.
Message-ID: <20060418160331.A29518@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <20060417112552.GB4929@lnx-holt.americas.sgi.com> <9758.1145319832@ocs3.ocs.com.au> <20060418221623.GB22514@lnx-holt.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060418221623.GB22514@lnx-holt.americas.sgi.com>; from holt@sgi.com on Tue, Apr 18, 2006 at 05:16:23PM -0500
X-OriginalArrivalTime: 18 Apr 2006 23:05:50.0942 (UTC) FILETIME=[A2EF57E0:01C6633C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2006 at 05:16:23PM -0500, Robin Holt wrote:
> On Tue, Apr 18, 2006 at 10:23:52AM +1000, Keith Owens wrote:
> > I thought that is what I said in my original response, "kprobes should
> 
> I was a little dense and had forgotten that KDB would still need to
> register as a debugger.
> 
> 
> Some micro-benchmarking has shown this to be very painful.  The average
> of 128 iterations with 4194304 faults per iteration using the attached
> micro-benchmark showed the following:
> 
> 499 nSec/fault ia64_do_page_fault notify_die commented out.
> 501 nSec/fault ia64_do_page_fault with nobody registered.
> 533 nSec/fault notify_die in and just kprobes.
> 596 nSec/fault notify_die in and kdb, kprobes, mca, and xpc loaded.
> 
> The 596 nSec/fault is a 19.4% slowdown.  This is an upcoming OSD beta
> kernel.  It will be representative of what our typical customer will
> have loaded.
> 
> Is this enough justification for breaking notify_die into
> notify_page_fault for the fault path?

Yes sir, I am convinced 100%.

> 
> 
> > that chain should be optimized away when CONFIG_KPROBES=n or there are
> > no active probes".
> 
> Having the notify_page_fault() without anybody registered was only a
> 0.4% slowdown.  I am not sure that justifies the optimize away, but I
> would certainly not object.
> 
> I think the second and third numbers also indicate strongly that kprobes
> should only be registering the notify_page_fault when it actually is
> monitoring for a memory access.  I know so little about how kprobes works,
> I will stop right there.  Is there anybody who is willing to take that
> task or explain why it is impossible?

I will take it up and submit a path soon.
Thanks for your analysis.

-Anil
