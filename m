Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262109AbUD1Uiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbUD1Uiw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 16:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbUD1Uim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 16:38:42 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:19651 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262050AbUD1UhO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 16:37:14 -0400
Subject: Re: Low bogomips on IBM x445 (kernel 2.6.5)
From: john stultz <johnstul@us.ibm.com>
To: Christoph Pohl <christoph.pohl@inf.tu-dresden.de>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <408E3D74.2090301@inf.tu-dresden.de>
References: <408E3D74.2090301@inf.tu-dresden.de>
Content-Type: text/plain
Message-Id: <1083184612.9664.15.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 28 Apr 2004 13:36:53 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-04-27 at 04:01, Christoph Pohl wrote:
> I'm currently configuring an IBM x445 box with 4 Xeon CPUs (3GHz) and 
> hyperthreading enabled. Everything seems to work fine since kernel 2.6.5 
> but I keep wondering about the *very low* Bogomips numbers. Here is what 
> I see in /proc/cpuinfo:
> 
> cpu MHz         : 2996.175
[snip]
> bogomips        : 193.53

This is expected. Since the IBM x440/x445 are NUMA systems, we cannot
use the TSC (cpu cycle counter) as a time source. Instead we use an off
chip performance counter which runs at 100Mhz. This then translates to a
bogoMIPS value of ~200. 


> I came accross two bugs that looked very similar. However, they were 
> filed agains 2.4.x and should have been fixed for 2.6.x:
> 
> http://www.ussg.iu.edu/hypermail/linux/kernel/0311.0/0329.html
> 
> http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=115061

These posts are about an old bug in 2.4 that was related to the
performance counter time source on the x44x systems. However in those
cases, bogoMIPS would be mis-calculated to ~3, which caused problems.
This issue does not affect 2.6 or recent 2.4 kernels.

thanks
-john



