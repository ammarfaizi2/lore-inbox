Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265609AbUFDFMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265609AbUFDFMb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 01:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265613AbUFDFMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 01:12:30 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:19405 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265609AbUFDFM3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 01:12:29 -0400
Date: Thu, 3 Jun 2004 22:18:54 -0700
From: Paul Jackson <pj@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, akpm@osdl.org,
       ak@muc.de, ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
       joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
       mikpe@csd.uu.se, Simon.Derr@bull.net, wli@holomorphy.com
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based
 implementation
Message-Id: <20040603221854.25d80f5a.pj@sgi.com>
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

There were a few places where arch-specific code had a cpumask_t type,
then took its address and operated on it as if it was a simple unsigned
long.   Where I was confident that I could correctly and efficiently
recode them using 'real' cpumask operations, I did so.  But in some
cases, I was not clear how to do this.  Grep for "cpus_addr()" uses to
find these cases.  The old cpumask implementation had similar macros,
including cpus_coerce() and cpus_promote(), for a similar purpose.

The "ideal" solution, in my view, would be to have someone with arch
specific experience in each affected arch code these uses of cpus_addr()
out, then remove cpus_addr() entirely.

Perhaps I should comment the cpus_addr() definition as 'deprecated'?

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
