Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbUDJBVp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 21:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbUDJBVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 21:21:45 -0400
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:57251 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S261753AbUDJBVo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 21:21:44 -0400
Date: Fri, 9 Apr 2004 18:21:16 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       Hugh Dickins <hugh@veritas.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       parisc-linux@parisc-linux.org
Subject: Re: [parisc-linux] rmap: parisc __flush_dcache_page
Message-ID: <20040410012115.GA1285@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <1081439244.2165.236.camel@mulgrave> <20040408161610.GF31667@dualathlon.random> <1081441791.2105.295.camel@mulgrave> <20040408171017.GJ31667@dualathlon.random> <1081446226.2105.402.camel@mulgrave> <20040408175158.GK31667@dualathlon.random> <1081447654.1885.430.camel@mulgrave> <20040408181838.GN31667@dualathlon.random> <1081448897.2105.465.camel@mulgrave> <20040408184245.GO31667@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040408184245.GO31667@dualathlon.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2004 at 08:42:45PM +0200, Andrea Arcangeli wrote:
> But I've an fairly optimal solution for you, you should make it a
> read_write spinlock, with the readers not disabling interrupts, and the
> writer disabling interrupts, the writer of the prio-tree will not take a
> timeslice, the readers instead will take a timeslice, but since they're
> readers and you've only to read in the flush_dcache_page irq context,
> you don't need to disable irqs for the readers.  I don't have better
> solutions than this one at the moment (yeah there's the rcu reading of
> the prio-tree but I'd leave it for later...)

FWIW, agreed.  Past attempts at RCU-based tree algorithms have been
a bit on the complex side.  While I believe that simpler versions are
possible, RCU-based trees should be approached with caution and with
long lead times.

						Thanx, Paul
