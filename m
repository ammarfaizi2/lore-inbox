Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932688AbVISWY5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932688AbVISWY5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 18:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932709AbVISWY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 18:24:56 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:25056 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932688AbVISWY4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 18:24:56 -0400
Date: Mon, 19 Sep 2005 15:24:22 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Thomas Gleixner <tglx@linutronix.de>
cc: linux-kernel@vger.kernel.org, mingo@elte.hu, akpm@osdl.org,
       george@mvista.com, johnstul@us.ibm.com, paulmck@us.ibm.com
Subject: Re: [ANNOUNCE] ktimers subsystem
In-Reply-To: <1127168232.24044.265.camel@tglx.tec.linutronix.de>
Message-ID: <Pine.LNX.4.62.0509191521400.27238@schroedinger.engr.sgi.com>
References: <20050919184834.1.patchmail@tglx.tec.linutronix.de> 
 <Pine.LNX.4.62.0509191500040.27238@schroedinger.engr.sgi.com>
 <1127168232.24044.265.camel@tglx.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Sep 2005, Thomas Gleixner wrote:

> Also the basic prerequisite for for high resolution timers is a fast and
> simple access to clock_monotonic rather than to a backward corrected
> clock_realtime representation. 

Yup that may be a reason to tolerate the add for realtime.

> We should rather ask glibc people why gettimeofday() / clock_getttime()
> is called inside the library code all over the place for non obvious
> reasons.

You can ask lots of application vendors the same question because its all 
over lots of user space code. The fact is that gettimeofday() / 
clock_gettime() efficiency is very critical to the performance of many 
applications on Linux. That is why the addtion of one add instruction may 
better be carefully considered. Many platforms can execute gettimeofday 
without having to enter the kernel.

