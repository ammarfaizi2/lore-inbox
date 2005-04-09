Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261281AbVDIElG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbVDIElG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 00:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbVDIElG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 00:41:06 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:473 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261281AbVDIEjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 00:39:39 -0400
Subject: Re: HELP:porting linux PXA audio driver to RTLinux(RTLinux core
	driver)
From: Lee Revell <rlrevell@joe-job.com>
To: nobin matthew <nobin_matthew@yahoo.com>
Cc: kernelnewbies@nl.linux.org, linux-arm-kernel@lists.arm.linux.org.uk,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
In-Reply-To: <20050409040327.93029.qmail@web53902.mail.yahoo.com>
References: <20050409040327.93029.qmail@web53902.mail.yahoo.com>
Content-Type: text/plain
Date: Sat, 09 Apr 2005 00:39:38 -0400
Message-Id: <1113021578.5975.56.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-08 at 21:03 -0700, nobin matthew wrote:
> Dear Friends,
> 
>               I am trying to port Linux PXA audio
> driver to RTLinux. I am using pxa-ac7.c and
> pxa-audio.c
>  and eliminated sound_core.c, and i will register two
> device /dev/mixer and /dev/dsp to RTLinux kernel.
> 
>            The real need is, i wants to generate a sin
> wave using audio codec. With in 600us DMA controller
> should fill the codec FIFO, if that is not met
> distortion will happen. I think normal linux
> interrupts and Process scheduling may cause some
> problems.
> 
> In porting it seems difficult to port kernel
> scheduling , dynamic memory allocation(for DMA) and
> synchronization.

This is the exact same question you posted to linux-audio-dev.  And
you'll get the same answer here:

Don't waste your time with RTLinux.  Use a recent 2.6 kernel with Ingo's
realtime-preempt patches.  Configure with PREEMPT_RT.  This will provide
deterministic, hard realtime performance for any RT constraint down to
about 50 usecs.

RTLinux can meet a ~15 usec RT constraint, the RT preempt kernel will be
able to do this once the timer ISR is made preemptible again.

RTLinux is an obsolescent product that had its place in the 2.4 era but
is being superseded by a solution that's both technically superior and
100% free software.  Real time preemption is the future of hard realtime
on Linux.  All the major real time Linux players have recognized this,
even the ones who had competing solutions for 2.4 are porting their work
to the 2.6 RT-preempt framework.

Besides, RTLinux is a commercial product anyway.  If this project
requires use of RTLinux for political reasons, call your support rep.

Lee

