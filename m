Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266821AbUJAWGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266821AbUJAWGO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 18:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266741AbUJAWEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 18:04:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:49282 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266663AbUJAV6L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 17:58:11 -0400
Date: Fri, 1 Oct 2004 14:57:47 -0700
Message-Id: <200410012157.i91LvlPj021414@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Christoph Lameter <clameter@sgi.com>
X-Fcc: ~/Mail/linus
Cc: Ulrich Drepper <drepper@redhat.com>, johnstul@us.ibm.com,
       Ulrich.Windl@rz.uni-regensburg.de, george@mvista.com,
       linux-kernel@vger.kernel.org, libc-alpha@sources.redhat.com
Subject: Re: [RFC] Posix compliant behavior of CLOCK_PROCESS/THREAD_CPUTIME_ID
In-Reply-To: Christoph Lameter's message of  Monday, 27 September 2004 13:58:12 -0700 <Pine.LNX.4.58.0409271344220.32308@schroedinger.engr.sgi.com>
X-Windows: don't get frustrated without it.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry I haven't replied sooner.  I don't think the facility offered by your
patch is enough by itself to be worth doing.  That information about a
process is already available to itself via getrusage/times, though those
don't offer a per-thread sample.  

I have been working on an alternate patch that implements more complete CPU
clock functionality.  This includes access to other threads' and process'
times, potentially finer-grained information (based on sched_clock), and
timers.  I will post this code when it's ready, hopefully soon.

As to supporting clock_settime, I think that is just plain not desireable.
I am not aware of any actual demand for it, and POSIX certainly does not
require that it be permitted.  It's certainly undesireable to let a process
reset its actual totals as reported by getrusage, process accounting, etc.;
I gather your later revisions have at least avoided that pitfall.  But I
don't really see the utility in letting applications use clock_settime on
their CPU clocks either.  They can just save the starting value at the time
they would use clock_settime to reset it to zero, and compute the delta later.



Thanks,
Roland
