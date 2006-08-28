Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbWH1Uqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWH1Uqf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 16:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbWH1Uqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 16:46:35 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:50585 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932079AbWH1Uqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 16:46:35 -0400
Date: Mon, 28 Aug 2006 21:46:11 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Paul E McKenney <paulmck@us.ibm.com>
Subject: Re: [PATCH 3/4] RCU: preemptible RCU implementation
Message-ID: <20060828204611.GB719@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dipankar Sarma <dipankar@in.ibm.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
	Paul E McKenney <paulmck@us.ibm.com>
References: <20060828160845.GB3325@in.ibm.com> <20060828161222.GE3325@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060828161222.GE3325@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2006 at 09:42:22PM +0530, Dipankar Sarma wrote:
> From: Paul McKenney <paulmck@us.ibm.com>
> 
> This patch implements a new version of RCU which allows its read-side
> critical sections to be preempted. It uses a set of counter pairs
> to keep track of the read-side critical sections and flips them
> when all tasks exit read-side critical section. The details
> of this implementation can be found in this paper -
> 
> http://www.rdrop.com/users/paulmck/RCU/OLSrtRCU.2006.08.11a.pdf
> 
> This patch was developed as a part of the -rt kernel
> development and meant to provide better latencies when
> read-side critical sections of RCU don't disable preemption.
> As a consequence of keeping track of RCU readers, the readers
> have a slight overhead (optimizations in the paper).
> This implementation co-exists with the "classic" RCU
> implementations and can be switched to at compiler.

NACK.  While a readers can sleep rcu version definitly has it's
we should make it all or nothing.  Either we always gurantee that
a rcu reader can sleep or never without external patches.  Having
this a config option is the ultimate defeat for any kind of bug
reproducabilility.

Please make the patch undconditional and see if it doesn't cause
any significant slowdowns in production-like scenaries and then
we can switch over to the readers can sleep variant unconditionally
at some point.

