Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263340AbUFFMJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263340AbUFFMJc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 08:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263370AbUFFMJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 08:09:32 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:30786 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263340AbUFFMJa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 08:09:30 -0400
Date: Sun, 6 Jun 2004 05:16:57 -0700
From: Paul Jackson <pj@sgi.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: wli@holomorphy.com, mikpe@csd.uu.se, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based
 implementation
Message-Id: <20040606051657.3c9b44d3.pj@sgi.com>
In-Reply-To: <1086487651.11454.19.camel@bach>
References: <16576.16748.771295.988065@alkaid.it.uu.se>
	<20040604093712.GU21007@holomorphy.com>
	<16576.17673.548349.36588@alkaid.it.uu.se>
	<20040604095929.GX21007@holomorphy.com>
	<16576.23059.490262.610771@alkaid.it.uu.se>
	<20040604112744.GZ21007@holomorphy.com>
	<20040604113252.GA21007@holomorphy.com>
	<20040604092316.3ab91e36.pj@sgi.com>
	<20040604162853.GB21007@holomorphy.com>
	<20040604104756.472fd542.pj@sgi.com>
	<20040604181233.GF21007@holomorphy.com>
	<1086487651.11454.19.camel@bach>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty wrote:
> Yes, NR_CPUS needs to get to userspace somehow sanely if we want to fix
> this in general.

Are you saying that NR_CPUS is needed, or just the number of longs in a
cpumask (sizeof (cpumask_t), essentially)?

I can see where the size is needed, in order to make the system calls to
set and get masks of arbitrary size.  Since these sizes are a multiple
of sizeof(long), at a minimum this means user code needs to know the
number of longs in a mask.  Though the number of bytes, as in
sizeof(cpumask_t), rather than of longs, is perhaps a less surprising
interface.

I can't see where the user code cares whether NR_CPUS is 47 or 48?

Am I missing something?

I am a firm believer in passing the minimum essential information across
major boundaries.  Passing too much creates maintaince problems, and
encourages misuse of information, resulting in bogus user code.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
