Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262347AbTH0Nk3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 09:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbTH0Nk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 09:40:29 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:16834 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262347AbTH0Nk1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 09:40:27 -0400
From: Andrew Theurer <habanero@us.ibm.com>
Reply-To: habanero@us.ibm.com
To: root@chaos.analogic.com, Andy Isaacson <adi@hexapodia.org>
Subject: Re: 2.6.0-test4 shocking (HT) benchmarking (wrong logic./phys. HT CPU distinction?)
Date: Wed, 27 Aug 2003 08:40:33 -0500
User-Agent: KMail/1.5
Cc: max@vortex.physik.uni-konstanz.de,
       Linux kernel <linux-kernel@vger.kernel.org>
References: <200308261552.44541.max@vortex.physik.uni-konstanz.de> <20030826135051.A16285@hexapodia.org> <Pine.LNX.4.53.0308261455590.4526@chaos>
In-Reply-To: <Pine.LNX.4.53.0308261455590.4526@chaos>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308270840.33932.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 August 2003 14:12, Richard B. Johnson wrote:
> On Tue, 26 Aug 2003, Andy Isaacson wrote:
> > On Tue, Aug 26, 2003, max@vortex.physik.uni-konstanz.de wrote:
> > > in our fine physics group we recently bought a DUAL XEON P4 2666MHz,
> > > 2GB, with
> > > hyper-threading support and I had the honour of making the thing work.
> > > In the
> > > process I also did some benchmarking using two different kernels (stock
> > > SuSE-8.2-Pro 2.4.20-64GB-SMP, and the latest and greatest vanilla
> > > 2.6.0-test4). I benchmarked

Chances are -neither- of these kernels have HT enhancements for the scheduler.  
I am positive the 260test kernels do not have shared runqueues for HT 
siblings and the scheduler does not make use of the cpu_sibling_map.  Test 
make -j2 with HT disabled, and I bet you get better results than make -j2 
with HT enabled....

> P.S. HT References I found online have not compared HT between 2.4 and 2.6, 
> but they all assume improvements in 2.6.
> http://www.linuxworld.com/story/33885.htm

This article is incorrect.  The scheduler changes did not make it in to 2.5.32

> http://www-106.ibm.com/developerworks/linux/library/l-htl/

This article discusses the changes needed, but does not state that the changes 
are in the 2.5 kernel.

This is still a problem, even the "What to Expect From 2.6" is incorrect:
http://ftp.kernel.org/pub/linux/kernel/people/davej/misc/post-halloween-2.5.txt

Ingo's latest patch that fixes this is here:
http://people.redhat.com/mingo/O(1)-scheduler/sched-2.5.68-B2

And here for 2.4:
http://people.redhat.com/mingo/O(1)-scheduler/sched-HT-2.4.21-rc7-ac1-A1

Not sure why the FFT results are so much lower on 2.6, but I'm not sure sure 
it has anything to do with HT, maybe something else?  Can you try turning off 
HT and see what happens?

-Andrew Theurer
