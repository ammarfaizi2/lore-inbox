Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265802AbUFOSJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265802AbUFOSJg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 14:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265804AbUFOSJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 14:09:36 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:32282 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265802AbUFOSJ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 14:09:28 -0400
Date: Tue, 15 Jun 2004 11:18:16 -0700
From: Paul Jackson <pj@sgi.com>
To: Andi Kleen <ak@muc.de>
Cc: manfred@colorfullife.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, ak@muc.de, anton@samba.org
Subject: Re: NUMA API observations
Message-Id: <20040615111816.0d397f90.pj@sgi.com>
In-Reply-To: <20040615110320.GD50463@colin2.muc.de>
References: <40CE824D.9020300@colorfullife.com>
	<20040615110320.GD50463@colin2.muc.de>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi wrote:
> But it doesn't really help because
> applications have to work with older kernels.

It doesn't help right away.  But one can eventually phase out cruft.
Provide the new, deprecate the old, then perhaps in 2.7/2.8 kernels,
discontinue the old.

Such renewal work is valuable to the long term health of Linux.

I can't do it - I wouldn't want Andrew dreading my submissions anymore
than he already does, and William's questions as to just how I was
explaining to my employer the value of my labors would be increasingly
unanswerable. <grin>

> cpumask_t is more an kernel internal implementation detail
> and should not really be exposed to user space, so 
> it's better not to do the sysctl neither.

Bingo.

When you find yourself in a hole, stop digging.

I'd go a step further - even as an internal kernel detail, it was poorly
chosen, as evidenced by the amount of commentary it takes the big-endian
64 bit machines, in the files include/asm-ppc64/bitops.h and
include/asm-s390/bitops.h, to explain the bitmap data type.

Perhaps a byte array, rather than an unsigned long array, would be
better.

And the brain damage is also on the other side of the kernel-user
boundary.  Don't get me started on the botch that glibc made of this.

This is a nice case study in the propagation properties of suboptimal
design choices, and in the unintended consequences flowing from the
choices of basic data structures.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
