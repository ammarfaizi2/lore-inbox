Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbVGVIO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbVGVIO1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 04:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262067AbVGVIO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 04:14:26 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:31505 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262062AbVGVIOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 04:14:22 -0400
Date: Fri, 22 Jul 2005 10:14:17 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch 2.6.13-rc3a] i386: inline restore_fpu
Message-ID: <20050722081417.GJ3160@stusta.de>
References: <200507212309_MC3-1-A534-95EF@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507212309_MC3-1-A534-95EF@compuserve.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2005 at 11:06:22PM -0400, Chuck Ebbert wrote:
> 
>   This patch makes restore_fpu() an inline.  When L1/L2 cache are saturated
> it makes a measurable difference.
> 
>   Results from profiling Volanomark follow.  Sample rate was 2000 samples/sec
> (HZ = 250, profile multiplier = 8) on a dual-processor Pentium II Xeon.
> 
> 
> Before:
> 
>  10680 restore_fpu                              333.7500
>   8351 device_not_available                     203.6829
>   3823 math_state_restore                        59.7344
>  -----
>  22854
> 
> 
> After:
> 
>  12534 math_state_restore                       130.5625
>   8354 device_not_available                     203.7561
>  -----
>  20888
> 
> 
> Patch is "obviously correct" and cuts 9% of the overhead.  Please apply.
>...

If this patch makes a difference, could you do me a favour and check 
whether replacing the current cpu_has_fxsr #define in
include/asm-i386/cpufeature.h with

  #define cpu_has_fxsr           1

on top of your patch brings an additional improvement?

> Chuck

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

