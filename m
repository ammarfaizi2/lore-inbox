Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263782AbRFISP6>; Sat, 9 Jun 2001 14:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264465AbRFISPt>; Sat, 9 Jun 2001 14:15:49 -0400
Received: from adsl-209-76-109-63.dsl.snfc21.pacbell.net ([209.76.109.63]:2432
	"EHLO adsl-209-76-109-63.dsl.snfc21.pacbell.net") by vger.kernel.org
	with ESMTP id <S264443AbRFISPe>; Sat, 9 Jun 2001 14:15:34 -0400
Date: Sat, 9 Jun 2001 11:13:46 -0700
From: Wayne Whitney <whitney@math.berkeley.edu>
Message-Id: <200106091813.f59IDkX00991@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
To: tomlins@cam.org, Keith Owens <kaos@ocs.com.au>, tlan@stud.ntnu.no
Cc: linux-kernel@vger.kernel.org, whitney@math.berkeley.edu
Subject: Re: missing symbol do_softirq in net moduels for pre-2
In-Reply-To: <01060913201900.01845@oscar>
In-Reply-To: <16799.992106264@ocs4.ocs-net> <16799.992106264@ocs4.ocs-net> <01060913201900.01845@oscar>
Reply-To: whitney@math.berkeley.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09 June 2001, Ed Tomlinson wrote:

>in the arch code for softirq we now have:
>
>+#define local_bh_enable()                                              \
>+do {                                                                   \
>+       unsigned int *ptr = &local_bh_count(smp_processor_id());        \
>+                                                                       \
>+       if (!--*ptr)                                                    \
>+               __asm__ __volatile__ (                                  \
>+                       "cmpl $0, -8(%0);"                              \
>+                       "jnz 2f;"                                       \
>+                       "1:;"                                           \
>+                                                                       \
>+                       ".section .text.lock,\"ax\";"                   \
>+                       "2: pushl %%eax; pushl %%ecx; pushl %%edx;"     \
>+                       "call do_softirq;"
>
>What has to happen to get assembly code to version the symbol?

I have verified that the versioning of the do_softirq symbol above is
the source of the problems in 2.4.6-pre2: I made two copies of the
local_bh_enable macro, one with the versioning hash explicitly
appended to the symbol, and chose between with #ifdef MODULE.
Everything works fine now.

Of course, this is ugly, ugly, ugly, so hopefully someone will answer
Ed's question as to the correct way of doing this.

Cheers, Wayne

