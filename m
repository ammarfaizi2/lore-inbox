Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbTIYCTT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 22:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbTIYCTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 22:19:19 -0400
Received: from avocet.mail.pas.earthlink.net ([207.217.120.50]:37849 "EHLO
	avocet.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S261656AbTIYCTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 22:19:17 -0400
Date: Wed, 24 Sep 2003 22:22:18 -0400
To: linux-kernel@vger.kernel.org
Cc: solt@dns.toxicfilms.tv
Subject: Re: Minimizing the Kernel
Message-ID: <20030925022218.GA20302@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmm, has anyone tried -Os with gcc3+ ?
> Maybe that'd be good for size optimization?

2.6.0-test3 compiled with gcc-3.3.1 and redhat 7.2's
gcc-2.96-112.  gcc-3.3.1 saves about 275k text (10%).
-Os is more effective on gcc-3.3.1 than 2.96.
These were all built with the same .config.

size vmlinux-*
   text    data     bss     dec     hex filename
2120419  449928  131748 2702095  293b0f vmlinux-3.3.1-Os
2124890  449928  131748 2706566  294c86 vmlinux-3.3.1-Os-falign=2
2334482  457304  125952 2917738  2c856a vmlinux-2.96-112-Os
2405382  449960  131748 2987090  2d9452 vmlinux-3.3.1
2408343  457332  125952 2991627  2da60b vmlinux-2.96-112

Most frequently saved instruction with gcc-3.3.1 -Os is nop.

This was on x86.  The -falign=2 version had -falign-functions=2
-falign-jumps=2 -falign-labels=2 -falign-loops=2.  I believe the
default with -Os is no alignment (i.e. -falign-*=0).

I benchmarked those compilers/options on a K6/2.  You could wade
through http://home.earthlink.net/~rwhron/kernel/bigbox.html
to see all the results.  

Quick summary:
gcc-3.3.1 -Os -falign=2 was best for most LMbench tests.  
For other benchmarks that wasn't always true.  K6/2 has small
L1 cache (32+32K)  L2 cache is 1M, but not much faster than RAM
on my box.

These generalizations can be made:
1) gcc-3.3.1 -Os kernel code is about 10% smaller than gcc-2.96 -Os.
2) Actual memory savings is not 10%, because dynamic structure
   sizes don't change.
3) gcc-3.3.1 takes significantly longer to compile source.

YMMV

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

