Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261487AbVEJBLf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261487AbVEJBLf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 21:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbVEJBLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 21:11:32 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:39610 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261488AbVEJBL3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 21:11:29 -0400
Date: Mon, 9 May 2005 18:11:43 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Joe Seigh <jseigh_02@xemaps.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RCU + SMR for preemptive kernel/user threads.
Message-ID: <20050510011143.GC1337@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <opsqivh7agehbc72@grunion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <opsqivh7agehbc72@grunion>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2005 at 03:09:33PM -0400, Joe Seigh wrote:

[ . . . ]

> *** The per cpu times are in jiffies rounded off from some higher  
> resolution value.
> This means that for n time counters, you may have to wait up to n jiffies  
> for
> at least one round up to occur.  It would be nicer to have the higher  
> resolution
> value or even better a per processor number of interrupts to allow more  
> flexibility
> and finer granularity in polling intervals.

You can use smp_call_function() to invoke a function on each of the
other CPUs.  The implementations of smp_call_function() use inter-processor
interrupts, which should suffice, but you can always make the called
function just execute a memory barrier.

							Thanx, Paul
