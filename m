Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262671AbTHZT2s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 15:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262667AbTHZT2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 15:28:48 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:16659 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262671AbTHZT2q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 15:28:46 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: 2.6.0-test4 shocking (HT) benchmarking (wrong logic./phys. HT CPU distinction?)
Date: 26 Aug 2003 19:20:20 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bigbtk$i7v$1@gatekeeper.tmr.com>
References: <200308261552.44541.max@vortex.physik.uni-konstanz.de>
X-Trace: gatekeeper.tmr.com 1061925620 18687 192.168.12.62 (26 Aug 2003 19:20:20 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200308261552.44541.max@vortex.physik.uni-konstanz.de>,
 <max@vortex.physik.uni-konstanz.de> wrote:

| The next strange thing is that using FFTW (in a single program) with two or 
| four simulataneous FFT-threads on 2.6.0-test4 is significantly *slower* than 
| in 2.4, where the hyperthreading/SMP is said to be inferior to 2.6. The 
| simulation took almost 50% longer on 2.6, all other things being equal. 
| Unfortunately, these results made me go back to 2.4 for the time being.

You may want to run w/o HT at all for your particular problem, or limit
threads to the number of physical CPUs. Having multiple threads trying
to do ffts is likely to thrash the cache, and will result in contention
for the (single) FPU.

The schedular would seem to lack the information to make a determination
of the magnitude of the fpu contention, and by making better use of HT
it makes the contention worse.

Perhaps there should be a "don't hyperthread" attribute one could set to
hint that running multiple threads in a single CPU is unlikely to work
well. Since there isn't, I don't know a way to avoid the problem unless
you can set maxthreads to Ncpu.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
