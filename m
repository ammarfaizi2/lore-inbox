Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268303AbUH3TMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268303AbUH3TMN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 15:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268467AbUH3TMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 15:12:12 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:58763 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268303AbUH3TL4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 15:11:56 -0400
Subject: Re: SMP Panic caused by [PATCH] sched: consolidate sched domains
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1093799808.10990.22.camel@mulgrave>
References: <1093786747.1708.8.camel@mulgrave>
	 <200408290948.06473.jbarnes@engr.sgi.com>
	 <1093798704.10973.15.camel@mulgrave>
	 <200408291007.50553.jbarnes@engr.sgi.com>
	 <1093799808.10990.22.camel@mulgrave>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1093893078.10143.2.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 30 Aug 2004 12:11:19 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-29 at 10:16, James Bottomley wrote:
> On Sun, 2004-08-29 at 13:07, Jesse Barnes wrote:
> > I've up and downed a few CPUs on an Altix, and it seems to work ok, but that's 
> > a pretty basic test.  How about this?
> 
> Well, like I told Bill.  It's not a priori correct because now you're
> altering runtime behaviour.
> 
> It may, in fact, work because if the runtime users have an additional
> restriction to online cpus, but that's not a given ... have you audited
> the code for this?
> 
> James

Yeah, I don't think that patch will work so well, unless we're very
careful to mask the return values of node_to_cpumask() and
pcibus_to_cpumask() against cpu_online_map where appropriate.  There are
certainly callers of these function who are expecting a map containing
online cpus.

-Matt

