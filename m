Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbWDQL3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWDQL3t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 07:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbWDQL3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 07:29:49 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:19155 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750765AbWDQL3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 07:29:49 -0400
Date: Mon, 17 Apr 2006 06:25:52 -0500
From: Robin Holt <holt@sgi.com>
To: Robin Holt <holt@sgi.com>
Cc: Keith Owens <kaos@sgi.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       Dean Nelson <dcn@sgi.com>
Subject: Re: Is notify_die being overloaded?
Message-ID: <20060417112552.GB4929@lnx-holt.americas.sgi.com>
References: <20060415104355.GA7156@lnx-holt.americas.sgi.com> <2059.1145260330@ocs3.ocs.com.au> <20060417105143.GA4929@lnx-holt.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060417105143.GA4929@lnx-holt.americas.sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2006 at 05:51:44AM -0500, Robin Holt wrote:
> On Mon, Apr 17, 2006 at 05:52:10PM +1000, Keith Owens wrote:
> > Robin Holt (on Sat, 15 Apr 2006 05:43:56 -0500) wrote:
...
> > Unfortunately the ebents are ambiguous.  On IA64 BUG() maps to break 0,
> > but break 0 is also used for debugging[*].  Which makes it awkward to
> > differentiate between a kernel error and a debug event, we have to
> > first ask the debuggers if the event if for them then, if the debuggers
> > do not want the event, drop into the die_if_kernel event.
> 
> I think this still would argue for a notify_debugger() sort of callout
> which would read something like:

I finally think I understand your point.  You are saying that kdb would
have to register for the notify_debugger() chain and would therefore
get in the way of handle_page_fault().  What about changing notify_die()
callout in handle_page_fault() into a notify_page_fault().  That actually
feels a lot better now that you got me to think about it.

Thanks,
Robin
