Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbUEJTJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbUEJTJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 15:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbUEJTJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 15:09:27 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:30422 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261244AbUEJTJY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 15:09:24 -0400
Date: Tue, 11 May 2004 00:04:11 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
       arjanv@redhat.com, helgehaf@aitel.hist.no, linux-kernel@vger.kernel.org
Subject: Re: dentry bloat.
Message-ID: <20040510183411.GA4813@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040508171027.6e469f70.akpm@osdl.org> <Pine.LNX.4.58.0405081947290.1592@ppc970.osdl.org> <20040508201215.24f0d239.davem@redhat.com> <Pine.LNX.4.58.0405082039510.1592@ppc970.osdl.org> <20040509210312.GL5414@waste.org> <409F3CEE.8060102@aitel.hist.no> <1084177928.4925.13.camel@laptop.fenrus.com> <20040510024658.53cb0b80.akpm@osdl.org> <20040510145403.GL28459@waste.org> <20040510162645.GA1646@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040510162645.GA1646@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2004 at 09:26:45AM -0700, Paul E. McKenney wrote:
> On Mon, May 10, 2004 at 09:54:04AM -0500, Matt Mackall wrote:
> > Ok, I can spin something up. I'll start with a generic no-RCU-on-UP
> > and then we can think about the small SMP case a bit later.
> 
> Hello, Matt,
> 
> You may wish to start with the dcache portion of Dipankar's earlier patch:
> 
> http://sourceforge.net/mailarchive/forum.php?thread_id=3644163&forum_id=730
> 
> It does not remove the extra rcu_head from the dentry, but does the
> rest of the work.

Matt and I had discussed this privately sometime ago and I will
send him somewhat cleaned up patches that introduces call_rcu_direct()
which, in UP kernel, invokes the callback directly. The corresponding
read-side critical section will have to protect itself with
rcu_read_lock_bh() or rcu_read_lock_irq() if an update can happen
from softirq or irq context.

Thanks
Dipankar
