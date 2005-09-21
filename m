Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751469AbVIVKca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbVIVKca (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 06:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbVIVKcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 06:32:09 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:60585 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751468AbVIVKcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 06:32:05 -0400
Date: Wed, 21 Sep 2005 21:24:44 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, akpm@osdl.org, george@mvista.com, johnstul@us.ibm.com,
       paulmck@us.ibm.com
Subject: Re: [ANNOUNCE] ktimers subsystem
Message-ID: <20050921192444.GD467@openzaurus.ucw.cz>
References: <20050919184834.1.patchmail@tglx.tec.linutronix.de> <Pine.LNX.4.62.0509191500040.27238@schroedinger.engr.sgi.com> <1127168232.24044.265.camel@tglx.tec.linutronix.de> <Pine.LNX.4.62.0509191521400.27238@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0509191521400.27238@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Also the basic prerequisite for for high resolution timers is a fast and
> > simple access to clock_monotonic rather than to a backward corrected
> > clock_realtime representation. 
> 
> Yup that may be a reason to tolerate the add for realtime.
> 
> > We should rather ask glibc people why gettimeofday() / clock_getttime()
> > is called inside the library code all over the place for non obvious
> > reasons.
> 
> You can ask lots of application vendors the same question because its all 
> over lots of user space code. The fact is that gettimeofday() / 
> clock_gettime() efficiency is very critical to the performance of many 
> applications on Linux. That is why the addtion of one add instruction may 
> better be carefully considered. Many platforms can execute gettimeofday 
> without having to enter the kernel.

Eh? One addition is going to be lost in noise compared to syscall overhead.
(For vsyscall, you may be closer to truth, but I doubt it. You could still gain
more than one addition by using some strange calling convention).


-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

