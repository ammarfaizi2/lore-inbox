Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbWHYIbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbWHYIbJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 04:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbWHYIbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 04:31:09 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:21651 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S932179AbWHYIbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 04:31:08 -0400
Subject: Re: [RFC] maximum latency tracking infrastructure
From: Arjan van de Ven <arjan@linux.intel.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-kernel@vger.kernel.org,
       len.brown@intel.com
In-Reply-To: <44EEB425.8060707@yahoo.com.au>
References: <1156441295.3014.75.camel@laptopd505.fenrus.org>
	 <200608241408.03853.jbarnes@virtuousgeek.org>
	 <44EE1801.3060805@linux.intel.com> <44EE829C.10606@yahoo.com.au>
	 <44EEAD8D.6010801@linux.intel.com>  <44EEB425.8060707@yahoo.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 25 Aug 2006 10:30:44 +0200
Message-Id: <1156494644.3032.17.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-25 at 18:26 +1000, Nick Piggin wrote:
> Arjan van de Ven wrote:
> > Nick Piggin wrote:
> 
> >> Surely you would call set_acceptable_latency() *before* running such
> >> operation that requires the given latency? And that 
> >> set_acceptable_latency
> >> would block the caller until all CPUs are set to wake within this 
> >> latency.
> >>
> >> That would be the API semantics I would expect, anyway.
> > 
> > 
> > but that means it blocks, and thus can't be used in irq context
> 
> Is that a problem? I guess it could be, but you don't want to
> give a false sense of security either. Having an explicit _nosync
> version may make that clear?

well the api is already split between blocking and non-blocking so in
principle that's easy. The problem is that I suspect most users will use
the non-blocking variant.

Also the "what to do" can be treacherous; it'll need a callback list
simply because many places can be using the latency values, more than
just idle. (I can see pstate code for example also using it to limit
which ones to use, and not use the ones it takes to long to get out of)

I'll investigate what it'll take to get the callback in place; for the
C-state case it's not THAT critical (after all the cpu you are running
on when making this call is not in a deep C state.. :-)

