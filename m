Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261491AbVGCTEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbVGCTEe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 15:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbVGCTEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 15:04:34 -0400
Received: from cerebus.immunix.com ([198.145.28.33]:25066 "EHLO
	ermintrude.int.immunix.com") by vger.kernel.org with ESMTP
	id S261491AbVGCTEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 15:04:31 -0400
Date: Sun, 3 Jul 2005 12:00:07 -0700
From: Tony Jones <tonyj@suse.de>
To: Kurt Garloff <garloff@suse.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       James Morris <jmorris@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Steve Beattie <smb@wirex.com>
Subject: Re: [PATCH 3/3] Use conditional
Message-ID: <20050703190007.GA30292@immunix.com>
References: <20050703154405.GE11093@tpkurt.garloff.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050703154405.GE11093@tpkurt.garloff.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 03, 2005 at 05:44:05PM +0200, Kurt Garloff wrote:

Agree with James, pls resend to linux-security-module@wirex.com.

The topic of replacing dummy (with capability) was discussed there
last week, in the context of stacker, but a common solution for both
cases would be needed.

Also, I was going to ask where 4/5 and 5/5 were :-)

If you are claiming a perf increase it would be nice to get an idea
what these patches were even though you believe most of the gain was
in patch #3.

Thanks

> Hi,
> 
> this optimizes the case where no LSM is loaded and the (new) default 
> capablities is used. These are not called via indirect calls but 
> called as hardcoded calls and might thus be inlined; the price for
> this is a conditional -- benchmarks done by hp showed this to be
> beneficial (on ia64).
> 
> Enjoy,
> -- 
> Kurt Garloff, Director SUSE Labs, Novell Inc.

> From: Kurt Garloff <garloff@suse.de>
> Subject: Replace indirect calls by a branch
> References: SUSE40217, SUSE39439
> 
> In the LSM stub collection, rather do a branch than an indirect
> call. Many of the functions called do only return 0 or do nothing
> for the default (capability) case.
> This is a fast-path optimization; a branch is faster than an
> indirect call, even more so if correctly predicted.
> This shows a >3% perf. increase in netperf -t TCP_RR benchmark on IA64.
> (More exactly: The benchmark was taken with the next two patches
>  applied as well, but I attribute the main effect to this patch.)
> 
> This is patch 3/5 of the LSM overhaul.
