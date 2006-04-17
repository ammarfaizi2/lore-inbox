Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbWDQKx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWDQKx4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 06:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbWDQKx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 06:53:56 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:52432 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750757AbWDQKx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 06:53:56 -0400
Date: Mon, 17 Apr 2006 05:51:44 -0500
From: Robin Holt <holt@sgi.com>
To: Keith Owens <kaos@sgi.com>
Cc: Robin Holt <holt@sgi.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       Dean Nelson <dcn@sgi.com>
Subject: Re: Is notify_die being overloaded?
Message-ID: <20060417105143.GA4929@lnx-holt.americas.sgi.com>
References: <20060415104355.GA7156@lnx-holt.americas.sgi.com> <2059.1145260330@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2059.1145260330@ocs3.ocs.com.au>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2006 at 05:52:10PM +1000, Keith Owens wrote:
> Robin Holt (on Sat, 15 Apr 2006 05:43:56 -0500) wrote:
> >On Sat, Apr 15, 2006 at 04:19:55PM +1000, Keith Owens wrote:
> >> Robin Holt (on Thu, 13 Apr 2006 14:46:44 -0500) wrote:
> >> >notify_die seems to be called to indicate the machine is going down as
> >> >well as there are trapped events for the process.
> >...
> >> The only real problem is the page fault handler event.  All the other
> >...
> >> 
> >> kprobes should be using its own notify chain to trap page faults, and
> >> the handler for that chain should be optimized away when
> >> CONFIG_KPROBES=n or there are no active probes.
> >
> >I realize the page fault handler is the only performance critical event,
> >but don't all the debugging events _REALLY_ deserve a seperate call chain?
> >They are _completely_ seperate and isolated events.  One is a minor event
> >which a small number of other userland processes are concerned with.
> >The other is indicating the machine is about stop running and is only
> >relevant to critical system infrastructure.
> 
> Unfortunately the ebents are ambiguous.  On IA64 BUG() maps to break 0,
> but break 0 is also used for debugging[*].  Which makes it awkward to
> differentiate between a kernel error and a debug event, we have to
> first ask the debuggers if the event if for them then, if the debuggers
> do not want the event, drop into the die_if_kernel event.

I think this still would argue for a notify_debugger() sort of callout
which would read something like:

	if (notify_debugger(...) == NOTIFY_STOP)
		return;
	die_if_kernel(...)

Makes more sense than a notify_die() in there.  Am I missing something?

Thanks,
Robin
