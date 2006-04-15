Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932478AbWDOKoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbWDOKoK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 06:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbWDOKoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 06:44:10 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:23252 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932478AbWDOKoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 06:44:09 -0400
Date: Sat, 15 Apr 2006 05:43:56 -0500
From: Robin Holt <holt@sgi.com>
To: Keith Owens <kaos@sgi.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       Dean Nelson <dcn@americas.sgi.com>
Subject: Re: Is notify_die being overloaded?
Message-ID: <20060415104355.GA7156@lnx-holt.americas.sgi.com>
References: <20060413194643.GC25701@lnx-holt.americas.sgi.com> <22910.1145081995@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22910.1145081995@ocs3.ocs.com.au>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 15, 2006 at 04:19:55PM +1000, Keith Owens wrote:
> Robin Holt (on Thu, 13 Apr 2006 14:46:44 -0500) wrote:
> >notify_die seems to be called to indicate the machine is going down as
> >well as there are trapped events for the process.
...
> The only real problem is the page fault handler event.  All the other
...
> 
> kprobes should be using its own notify chain to trap page faults, and
> the handler for that chain should be optimized away when
> CONFIG_KPROBES=n or there are no active probes.

I realize the page fault handler is the only performance critical event,
but don't all the debugging events _REALLY_ deserve a seperate call chain?
They are _completely_ seperate and isolated events.  One is a minor event
which a small number of other userland processes are concerned with.
The other is indicating the machine is about stop running and is only
relevant to critical system infrastructure.

When I get back from vacation on Tuesday, I will try to work up a patch
which introduces a notify_debug() call and its call chain.  Maybe that
will initiate more discussion.

Thanks,
Robin
