Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263790AbTEFPLT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 11:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263796AbTEFPLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 11:11:19 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:32226 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263790AbTEFPLP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 11:11:15 -0400
Date: Tue, 6 May 2003 20:55:55 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: "David S. Miller" <davem@redhat.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.69-mm1
Message-ID: <20030506152555.GC9875@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20030504231650.75881288.akpm@digeo.com> <20030505210151.GO8978@holomorphy.com> <20030506110907.GB9875@in.ibm.com> <1052222542.983.27.camel@rth.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052222542.983.27.camel@rth.ninka.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 06, 2003 at 05:02:22AM -0700, David S. Miller wrote:
> On Tue, 2003-05-06 at 04:09, Dipankar Sarma wrote:
> > That brings me to the point - with the fget-speedup patch, we should
> > probably change ->file_lock back to an rwlock again. We now take this
> > lock only when fd table is shared and under such situation the rwlock
> > should help. Andrew, it that ok ?
> 
> rwlocks believe it or not tend not to be superior over spinlocks,
> they actually promote cache line thrashing in the case they
> are actually being effective (>1 parallel reader)

Provided there isn't a very heavy contention among readers for the spin_lock.
There is no evidence that this happens with ->file_lock as
spin_lock, so I guess we are ok for now. We should probably watch out
for some multi-threaded programs (Java->posix-threads ?) on
large smp boxes though.

Thanks
Dipankar
