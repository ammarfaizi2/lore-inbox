Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264481AbTDPQSG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 12:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264484AbTDPQSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 12:18:06 -0400
Received: from smtp.inet.fi ([192.89.123.192]:37838 "EHLO smtp.inet.fi")
	by vger.kernel.org with ESMTP id S264481AbTDPQSE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 12:18:04 -0400
From: Kimmo Sundqvist <rabbit80@mbnet.fi>
Organization: Unorganized
Date: Wed, 16 Apr 2003 16:29:42 +0300
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Disposition: inline
To: linux-kernel@vger.kernel.org
Subject: [2.4.20 deb ck4 ck6] Load testing, lotsa segfaults
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200304161629.42148.rabbit80@mbnet.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I have a 1GB RAM, and have tried running multiple copies of cpuburn 1.4's 
burnBX.  This is an Abit VP6 motherboard with VIA chipset, but burnBX 
stresses it more than the recommended burnMMX.  I can see that by 
overclocking RAM, because then burnBX gives more errors than burnMMX.  I 
currently have the memory set so that I can run 14 burnBX processes for 10 
hours without RAM-dependent problems.

To consume lots of memory I use the P option with burnBX.  That is 64MB for 
each burnBX process.  I am trying out several different kernels to locate the 
problem(s).  This is a Pentium III 933MHz dual CPU machine.  Debian 3.0r1 
with XFree86 4.2.1-3, KDE 3.11 or Enlightenment 0.16.5, libc6 2.2.5-14.2, all 
partitions are ReiserFS noatime, notail.

With Debian's 2.4.20 kernel configured with SMP I've been unable to get any 
segfault problems to appear.  Same when done with KDE, Enlightenment and 
console only.  Therefore I am quite positive this is not a hardware, XFree, 
KDE or Enlightenment problem.

With 2.4.20-ck6, configured with compressed cache, compressed swap, NO 
pre-empt and NO SMP, everything goes fine as long as physical memory is not 
used up.  As soon as first sign of swapping should happen, one burnBX 
segfaults.  Soon, after trying to run burnBX many times again, having it 
always segfault immediately, it also makes kswapd zombie/defunct.  Other 12 
or 13 burnBX keep running.  Some time passes, and other processes start 
segfaulting randomly.

kernel: EIP:    0010:[_lzo1x_1_do_compress+640/864]    Not tainted
Call Trace:    [lzo1x_1_compress+45/180] [lzo_wrapper_compress+39/60] 
[compress+31/116] [compress_page+156/632] [compress_clean_page+31/36] 
[shrink_cache+880/1092] [shrink_caches+47/60] [try_to_free_pages_zone+88/216] 
[kswapd_balance_pgdat+74/152] [kswapd_balance+26/48] [kswapd+153/188] 
[kernel_thread+40/56]
(So, with this kernel it looks like it's a compressed cache problem)

With 2.4.20-ck4 and 2.4.20-ck6 with SMP and pre-empt, but NO compressed 
anything, I can run 14 or 15 burnBX processes for a while.  Then all 
processes one by one randomly segfault or stop functioning, and finally I can 
only switch between virtual consoles and do nothing else.  Sometimes the 
machine keeps swapping (this with ck6) and sometimes it does nothing (this 
the last time I tried with ck4, and HPT370 required cold boot afterwards).

When things (processes) segfault (or just disappear and cease to exist) under 
ck4 and ck6, kern.log or syslog have nothing about it.

I could try vanilla 2.4.20 without ck patches, 2.5.67 if I get it to compile, 
and any of the above with mem=512M to avoid possible highmem problems (all 
have 4GB highmem and highmem IO configured).  No use in trying out different 
compressed cache configurations, since ck4 and ck6 have problems with and 
without it.

CONFIG_HIGHMEM4G=y, CONFIG_HIGHMEM=y and CONFIG_HIGHIO=y

I think that a kernel should be able to pass this test to be considered 
stable.  I'll try 2.4.20 unpatched next.  And since this is my first post 
here, tell me if I'm dead wrong about the list's purpose.

-Kimmo Sundqvist
