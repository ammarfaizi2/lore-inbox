Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266926AbSKURnq>; Thu, 21 Nov 2002 12:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266927AbSKURnq>; Thu, 21 Nov 2002 12:43:46 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:50840 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266926AbSKURnp>;
	Thu, 21 Nov 2002 12:43:45 -0500
Date: Thu, 21 Nov 2002 09:44:39 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
cc: David Zaffiro <davzaffiro@netscape.net>
Subject: Re: Compiling x86 with and without frame pointer
Message-ID: <224900000.1037900678@flay>
In-Reply-To: <19005.1037854033@kao2.melbourne.sgi.com>
References: <19005.1037854033@kao2.melbourne.sgi.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The conventional wisdom is that compiling x86 without frame pointer
> results in smaller code.  It turns out to be the opposite, compiling
> with frame pointers results in a smaller kernel.  gcc version 3.2
> 20020822 (Red Hat Linux Rawhide 3.2-4).

I looked at 2.5.47 (with a splattering of performance patches) using 
gcc 2.95.4 (Debian Woody), on a 16-way NUMA-Q, and did some kernel
compile testing. The times to do the tests were almost identical
(within error noise), but the kernel was indeed smaller

   text    data     bss     dec     hex filename
1873293  396231  459388 2728912  29a3d0 2.5.47-mjb1/vmlinux
1427355  396875  455356 2279586  22c8a2 2.5.47-mjb1-frameptr/vmlinux

Wow ... that's quite some difference ;-)

> I use -momit-leaf-frame-pointer for optimization in some own 
> projects, instead of the "-fomit-frame-pointer". For me, this 
> results in better codesize/speed compared to both "-fomit-frame-pointer" 
> or no option at all. Actually gcc-2.95 seems to support this feature 
> as well, but it never made it into the 2.95 docs...

I tried this, but it seemed to be the same as -fomit-frame-pointer
(on 2.95 at least).

Given that omitting the -fomit-frame-pointer makes a smaller kernel,
that's easier to debug, I'd say this is a good thing to do unless someone
can get *negative* benchmark results. 

M.

