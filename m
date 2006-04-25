Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbWDYKPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWDYKPl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 06:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbWDYKPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 06:15:41 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:6542 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932178AbWDYKPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 06:15:40 -0400
Date: Tue, 25 Apr 2006 05:15:29 -0500
From: Robin Holt <holt@sgi.com>
To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Cc: Robin Holt <holt@sgi.com>, Anderw Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Keith Owens <kaos@americas.sgi.com>, Dean Nelson <dnc@americas.sgi.com>,
       Tony Luck <tony.luck@intel.com>,
       Anath Mavinakayanahalli <ananth@in.ibm.com>,
       Prasanna Panchamukhi <prasanna@in.ibm.com>,
       Dave M <davem@davemloft.net>, Andi Kleen <ak@suse.de>
Subject: Re: [(take 2)patch 0/7] Notify page fault call chain
Message-ID: <20060425101529.GC25891@lnx-holt.americas.sgi.com>
References: <20060420232456.712271992@csdlinux-2.jf.intel.com> <20060424192824.GA10893@lnx-holt.americas.sgi.com> <20060424230115.B19542@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060424230115.B19542@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2006 at 11:01:16PM -0700, Keshavamurthy Anil S wrote:
> On Mon, Apr 24, 2006 at 02:28:24PM -0500, Robin Holt wrote:
> > This set definitely improves things.  My timings from last week must
> > have been off.  I think I may have still had the notify_die() call in
> > the fault path.  This week, I see a 35 nSec slowdown between with/without
> > KRPOBES.  Last week, I thought they were roughly equivalent.
> The non-overloaded call chain notification with dynamic registeration/unregistration 
> is much better than earlier one. But if you still want to improve the 35 nSec
> slowdown, then the only other alternative is to eliminate the call chain and 
> try calling kprobe_exceptions_notify() directly with the kprobe_running() around it.
> i.e
> static inline int notify_page_fault(enum die_val val, const char *str,
>                         struct pt_regs *regs, long err, int trap, int sig)

If we do that, can we rename notify_page_fault to something with kprobes in it?
