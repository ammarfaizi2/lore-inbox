Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263810AbTEFPdT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 11:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263817AbTEFPdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 11:33:19 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:24742 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263810AbTEFPdQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 11:33:16 -0400
Date: Tue, 6 May 2003 21:17:55 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: "David S. Miller" <davem@redhat.com>
Cc: wli@holomorphy.com, akpm@digeo.com, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.69-mm1
Message-ID: <20030506154755.GD9875@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20030506110907.GB9875@in.ibm.com> <1052222542.983.27.camel@rth.ninka.net> <20030506152555.GC9875@in.ibm.com> <20030506.072051.45141886.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030506.072051.45141886.davem@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 06, 2003 at 07:20:51AM -0700, David S. Miller wrote:
>    From: Dipankar Sarma <dipankar@in.ibm.com>
>    
>    Provided there isn't a very heavy contention among readers for the
>    spin_lock.
> 
> Even if there are thousands of readers trying to get the lock
> at the same time, unless your hold time is significant these
> readers will merely thrash the cache getting the rwlock_t.
> And then thrash it again to release the rwlock_t.

And now ISTR that this is indeed the case, atleast going by
what we saw with "chat" microbenchmarks (fwiw :)).
Hold times weren't very high and most of the performance penalty
came from bouncing of the rwlock cacheline, which prompted us to
write a RCU-based patch for lockfree lookup from fd table.

Thanks
Dipankar
