Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261758AbUAIOow (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 09:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbUAIOow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 09:44:52 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:13762 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S261758AbUAIOov (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 09:44:51 -0500
Date: Fri, 9 Jan 2004 06:46:19 -0800
From: Paul Jackson <pj@sgi.com>
To: Paul Mackerras <paulus@samba.org>
Cc: akpm@osdl.org, joe.korty@ccur.com, linux-kernel@vger.kernel.org
Subject: Re: seperator error in __mask_snprintf_len
Message-Id: <20040109064619.35c487ec.pj@sgi.com>
In-Reply-To: <16381.57040.576175.977969@cargo.ozlabs.ibm.com>
References: <20040107165607.GA11483@rudolph.ccur.com>
	<20040107113207.3aab64f5.akpm@osdl.org>
	<20040108051111.4ae36b58.pj@sgi.com>
	<16381.57040.576175.977969@cargo.ozlabs.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul M wrote:
> Hmmm, well, that comment is a bit misleading.  Bitmasks on ppc64 (and
> other bigendian 64-bit architectures such as sparc64) are stored as an
> array of unsigned longs, i.e. 64-bit values.

Ok - thank you for educating me on this.

So the byte order for 64 bit big endian cpumasks is:

  7 6 5 4 3 2 1 0 15 14 13 12 11 10 9 8 23 22 ...

rather than the little endian byte order of:

  0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 ...

I suspect that you are right, that I need a macro to pick the 'other'
half of a long, as you suggested:

  #define BITMAP_WORD(p, n)	(((u32 *)(p))[(n) ^ 1])

This would be defined in the include/asm-sparc64/cpumask.h and
include/asm-ppc64/cpumask.h files, with a no-op default in the
include/asm-generic/cpumask.h file for other architectures that
don't need it.  It would be used in lib/mask.c when printing
and scanning cpumasks.

I'm technically on vacation this week - If it doesn't cause anyone
heartburn, I likely won't get this patch out until mid next week.
If that hurts, squawk, and I'll work harder ;).

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
