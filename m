Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266378AbUGUAco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266378AbUGUAco (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 20:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266379AbUGUAco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 20:32:44 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:11942 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266378AbUGUAcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 20:32:41 -0400
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary
	Kernel	Preemption Patch
From: Lee Revell <rlrevell@joe-job.com>
To: "The Linux Audio Developers' Mailing List" 
	<linux-audio-dev@music.columbia.edu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <40FDAF86.10104@gardena.net>
References: <20040712163141.31ef1ad6.akpm@osdl.org>
	 <1090306769.22521.32.camel@mindpipe> <20040720071136.GA28696@elte.hu>
	 <200407202011.20558.musical_snake@gmx.de>
	 <1090353405.28175.21.camel@mindpipe>  <40FDAF86.10104@gardena.net>
Content-Type: text/plain
Message-Id: <1090369957.841.14.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 20 Jul 2004 20:32:37 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-20 at 19:49, Benno Senoner wrote:
> While locking a RT process to a CPU to achieve even lower latencies 
> might be useful to some
> the general userbase wants good latencies on simple UP, non HT-enabled 
> hardware too.
> (AMD is gaining marketshare and we cannot simply expect that good 
> multimedia performance (aka low latency)
> can be achieved only on those SMP/HT boxes where the truth is that 
> except in the case of really crappy hardware,
> those common UP  machines are actually capable to delives  latencies in 
> the range of dozen of usecs.
> (taking the RTLinux benchmarks as reference).
> Of course Linux != RTLinux and we never expect nor pretend Linux to 
> match the response time of RTLinux but
> as said earlier latencies at around 1msec should are doable on decent UP 
> boxes and this is more than
> adequate to run demanding real time audio applications like software 
> synthesizers, samples, real time effects etc.
> The only hope is that the hard work from Ingo, Andrew and all the others 
> gets soon integrated in the mainstream
> 2.6 kernel so all Linux users can take run demanding multimedia 
> applications out of the box without going through
> the painful patching,kernel recompiling etc.
> Or is this still not realistic at this point ?
>  (see the old issue with kernel 2.4,  low latency patches were too 
> unclean to make it into the
> ufficial kernel tree).
> 

There are still a few areas that need work, ioctl gives me problems, but
the latest 2.6 kernels are quite good.  If you look at the 'clean'
version of the voluntary kernel preemption patch it is pretty small.  My
understanding is that the kernel is already preemptible anytime that a
spin lock (including the BKL) is not held, and that the voluntary kernel
preemption patch adds some scheduling points in places where it is safe
to sleep, but preemption is disabled because we are holding the BKL, and
that the number of these should approach zero as the kernel is improved
anyway.


> Plus what's very important is that every kernel developer and driver 
> developer (even thirdparty, especially those
> that do closed source stuff like Nvidia etc) takes into account the 
> latency problems that code paths that run for
> too long time (or disable IRQs for too long etc) might create.
> While I'm not a kernel expert I assume the premptible kernel alleviates 
> this problem but I guess it still cannot
> completely get rid of low latency-unfriendly routines and drivers.

Yes, this is important.  One problem I had recently with the Via EPIA
board was that unless 2D acceleration was disabled by setting 'Option
"NoAccel"' in /etc/X11/XF86Config-4, overloading the X server would
cause interrupts from the soundcard to be completely disabled for tens
of milliseconds.  Users should keep in mind that by using 2D or 3D
hardware acceleration in X, you are allowing the X server to directly
access hardware, which can have very bad results if the driver is
buggy.  I am not sure the kernel can do anything about this.

Lee

