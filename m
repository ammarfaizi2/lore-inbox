Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268249AbUJVWlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268249AbUJVWlO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 18:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268248AbUJVWkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 18:40:40 -0400
Received: from gate.crashing.org ([63.228.1.57]:1723 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268260AbUJVWiH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 18:38:07 -0400
Subject: Re: [PATCH] pmac_cpufreq msleep cleanup/fixes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>
In-Reply-To: <200410221906.i9MJ63Ai022889@hera.kernel.org>
References: <200410221906.i9MJ63Ai022889@hera.kernel.org>
Content-Type: text/plain
Message-Id: <1098484616.6028.80.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 23 Oct 2004 08:36:56 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-23 at 04:11, Linux Kernel Mailing List wrote:
> ChangeSet 1.2015, 2004/10/22 11:11:36-07:00, nacc@us.ibm.com
> 
> 	[PATCH] pmac_cpufreq msleep cleanup/fixes
> 	
> 	Uses msleep() instead of schedule_timeout() to guarantee the task delays
> 	as expected.  Two of the changes are reworks of previous msleep() calls
> 	which unnecessarily added a jiffy to the parameter.
> 	
> 	Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> 	Signed-off-by: Linus Torvalds <torvalds@osdl.org>

Please revert that change until we have made absolutely sure that msleep(1)
on a HZ=1000 machine will actually sleep at least 1ms, this is really not
clear since it will end up doing schedule_timeout(1) which, afaik, will
only guarantee to sleep up to the next jiffie, which can be a lot shorter
than the actual duration of a jiffie.

Ben.


