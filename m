Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265084AbTFMBfS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 21:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265093AbTFMBfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 21:35:18 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:56547 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S265084AbTFMBfN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 21:35:13 -0400
Subject: Re: [PATCH] New x86_64 time code for 2.5.70
From: john stultz <johnstul@us.ibm.com>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: Andi Kleen <ak@suse.de>, vojtech@suse.cz, discuss@x86-64.org,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1055452600.1043.14.camel@serpentine.internal.keyresearch.com>
References: <1055357432.17154.77.camel@serpentine.internal.keyresearch.com>
	 <20030611191815.GA30411@wotan.suse.de>
	 <1055361411.17154.83.camel@serpentine.internal.keyresearch.com>
	 <1055362249.17154.86.camel@serpentine.internal.keyresearch.com>
	 <1055366609.18643.63.camel@w-jstultz2.beaverton.ibm.com>
	 <1055367412.17154.100.camel@serpentine.internal.keyresearch.com>
	 <1055378035.18643.95.camel@w-jstultz2.beaverton.ibm.com>
	 <1055440030.1043.7.camel@serpentine.internal.keyresearch.com>
	 <1055446795.18644.148.camel@w-jstultz2.beaverton.ibm.com>
	 <1055452600.1043.14.camel@serpentine.internal.keyresearch.com>
Content-Type: text/plain
Organization: 
Message-Id: <1055468605.18644.156.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 12 Jun 2003 18:43:25 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-12 at 14:16, Bryan O'Sullivan wrote:
> On Thu, 2003-06-12 at 12:39, john stultz wrote:
> 
> > One little tweak, you're still subtracting tick_usec when calculating
> > offset.
> 
> Well spotted, thanks.

Caught another (last instance of tick_usec in time.c). This time in
settimeofday(). This fixes the ltp failure. 

thanks
-john


diff -Nru a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
--- a/arch/x86_64/kernel/time.c	Thu Jun 12 18:42:19 2003
+++ b/arch/x86_64/kernel/time.c	Thu Jun 12 18:42:19 2003
@@ -129,7 +129,7 @@
 	write_seqlock_irq(&xtime_lock);
 
 	tv->tv_usec -= do_gettimeoffset() +
-		(jiffies - wall_jiffies) * tick_usec;
+		(jiffies - wall_jiffies) * (USEC_PER_SEC/HZ);
 
 	while (tv->tv_usec < 0) {
 		tv->tv_usec += 1000000;




