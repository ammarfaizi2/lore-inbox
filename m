Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030388AbWEKRlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030388AbWEKRlK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 13:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030392AbWEKRlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 13:41:10 -0400
Received: from mga07.intel.com ([143.182.124.22]:4150 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1030388AbWEKRlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 13:41:09 -0400
TrustInternalSourcedMail: True
X-ExchangeTrusted: True
X-IronPort-AV: i="4.05,116,1146466800"; 
   d="scan'208"; a="35003541:sNHT127585402"
Date: Thu, 11 May 2006 10:40:30 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Nathan Lynch <ntl@pobox.com>
Cc: Ashok Raj <ashok.raj@intel.com>, Andrew Morton <akpm@osdl.org>,
       Shaohua Li <shaohua.li@intel.com>, linux-kernel@vger.kernel.org,
       zwane@linuxpower.ca, vatsa@in.ibm.com
Subject: Re: [PATCH 0/10] bulk cpu removal support
Message-ID: <20060511104030.A15782@unix-os.sc.intel.com>
References: <1147067137.2760.77.camel@sli10-desk.sh.intel.com> <20060510230606.076271b2.akpm@osdl.org> <20060511095308.A15483@unix-os.sc.intel.com> <20060511171920.GB10833@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060511171920.GB10833@localdomain>; from ntl@pobox.com on Thu, May 11, 2006 at 12:19:20PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2006 at 12:19:20PM -0500, Nathan Lynch wrote:
> 
> But offlining all the cpus in a node is already something that just
> works.  If the user is all that concerned about not thrashing the
> tasks running on that node, they would have a workload manager that
> migrates the tasks off the node before shooting down cpus.  Similar
> argument applies to interrupt affinity.
> 
> I really haven't seen a compelling argument for why this is needed,
> just a bunch of handwaving so far, sorry.

Hand waving? Dont think that was intensional though.. i think we are trying
to address a real problem, if there is a reasonable alternate already
that we are not aware of, no problemo...


1. Regarding process migration, someone needs to make sure they run
something like a taskset away from all the cpus that are planned to be
removed upfront. This needs to be done on all processes on the system.

[nick, is there an easier way to do this in today's sched infrastructure or
otherwise]

2. For interrrupt migration, today when we take a cpu offline, we pick 
a random online cpu today. So if you have a cpu going offline, and the 
next logical cpu is also part of the same package, or node, we have
no smarts today to keep migration away from those "to be offlined" cpus.

If we have a solution to these already, or a simpler alternative, we are
open to those... and iam getting help on large system validation.. it might
not be easy right away, but its comming.

Cheers,
ashok


-- 
Cheers,
Ashok Raj
- Open Source Technology Center
