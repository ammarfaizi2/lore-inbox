Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265689AbUFDJic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265689AbUFDJic (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 05:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265684AbUFDJib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 05:38:31 -0400
Received: from holomorphy.com ([207.189.100.168]:33444 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265697AbUFDJhZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 05:37:25 -0400
Date: Fri, 4 Jun 2004 02:37:12 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Paul Jackson <pj@sgi.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, akpm@osdl.org,
       ak@muc.de, ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
       joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
       Simon.Derr@bull.net
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based implementation
Message-ID: <20040604093712.GU21007@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Mikael Pettersson <mikpe@csd.uu.se>, Paul Jackson <pj@sgi.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>, rusty@rustcorp.com.au,
	linux-kernel@vger.kernel.org, akpm@osdl.org, ak@muc.de,
	ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
	joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
	Simon.Derr@bull.net
References: <20040603094339.03ddfd42.pj@sgi.com> <20040603101010.4b15734a.pj@sgi.com> <1086313667.29381.897.camel@bach> <40BFD839.7060101@yahoo.com.au> <20040603221854.25d80f5a.pj@sgi.com> <16576.16748.771295.988065@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16576.16748.771295.988065@alkaid.it.uu.se>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2004 at 11:31:24AM +0200, Mikael Pettersson wrote:
> Please don't. cpus_addr() is useful when you need to get a
> handle on the representation for non-cpumask_t operations.
> Case in point: the perfctr kernel extension needs to communicate
> a cpumask_t to user-space because of the asymmetric nature of
> HT P4s. Unfortunately, a simple copy_to_user() won't work because:
> a) the size depends on kernel .config, and
> b) the representation is defined in terms of sequences of ulong,
>    which breaks 32-bit applications on 64-bit kernels.
> So perfctr instead converts a cpumask_t to a sequence of uint,
> and copies both the number of uints and the uints themselves
> to user-space.
> Having to do this conversion with a for-each-CPU type loop would
> be slow and ugly, and would IMO show that the cpumask_t ADT had
> become an obstacle to the actual work that needs to be done.
> So please keep cpus_addr().

If the marshalling code presents different formats to userspace
depending on BITS_PER_LONG then it's buggy.


-- wli
