Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265155AbUFDJdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265155AbUFDJdM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 05:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265678AbUFDJdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 05:33:11 -0400
Received: from aun.it.uu.se ([130.238.12.36]:65499 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S265155AbUFDJdC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 05:33:02 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16576.16748.771295.988065@alkaid.it.uu.se>
Date: Fri, 4 Jun 2004 11:31:24 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Paul Jackson <pj@sgi.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org, akpm@osdl.org, ak@muc.de,
       ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
       joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
       mikpe@csd.uu.se, Simon.Derr@bull.net, wli@holomorphy.com
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based
 implementation
In-Reply-To: <20040603221854.25d80f5a.pj@sgi.com>
References: <20040603094339.03ddfd42.pj@sgi.com>
	<20040603101010.4b15734a.pj@sgi.com>
	<1086313667.29381.897.camel@bach>
	<40BFD839.7060101@yahoo.com.au>
	<20040603221854.25d80f5a.pj@sgi.com>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson writes:
 > Perhaps I should comment the cpus_addr() definition as 'deprecated'?

Please don't. cpus_addr() is useful when you need to get a
handle on the representation for non-cpumask_t operations.

Case in point: the perfctr kernel extension needs to communicate
a cpumask_t to user-space because of the asymmetric nature of
HT P4s. Unfortunately, a simple copy_to_user() won't work because:
a) the size depends on kernel .config, and
b) the representation is defined in terms of sequences of ulong,
   which breaks 32-bit applications on 64-bit kernels.
So perfctr instead converts a cpumask_t to a sequence of uint,
and copies both the number of uints and the uints themselves
to user-space.

Having to do this conversion with a for-each-CPU type loop would
be slow and ugly, and would IMO show that the cpumask_t ADT had
become an obstacle to the actual work that needs to be done.

So please keep cpus_addr().

/Mikael
