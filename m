Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265618AbUFDFY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265618AbUFDFY6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 01:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265622AbUFDFY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 01:24:57 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:48888 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265618AbUFDFYz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 01:24:55 -0400
Date: Thu, 3 Jun 2004 22:30:05 -0700
From: Paul Jackson <pj@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, akpm@osdl.org,
       ak@muc.de, ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
       joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
       mikpe@csd.uu.se, Simon.Derr@bull.net, wli@holomorphy.com
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based
 implementation
Message-Id: <20040603223005.01bbab21.pj@sgi.com>
In-Reply-To: <40BFD839.7060101@yahoo.com.au>
References: <20040603094339.03ddfd42.pj@sgi.com>
	<20040603101010.4b15734a.pj@sgi.com>
	<1086313667.29381.897.camel@bach>
	<40BFD839.7060101@yahoo.com.au>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't see what you gain from having the cpumask type but having
> to get at its internals with the bitop functions.

The essential gain, in my view, of cpumask, is that it encapsulates
the value NR_CPUS.  cpumasks are bitmaps of length NR_CPUS.

Yes, there is an open issue of whether cpumasks are worth it.
I think enough code has taken to them that they are.

The getting at internals (via cpus_addr(), I'm guessing you mean)
was a workaround for some code that messed with cpumasks and simple
unsigned longs as if they were interoperable.  "cpus_addr" should
be marked deprecated, and its use coded out.  Its remaining uses
are in arch-specific areas where I lack the expertise and testing
environment to accomplish such.

I needed some legacy mechanism such as this, in order to avoid
having such existing uses bring the entire cpumask overhaul to
a screeching halt.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
