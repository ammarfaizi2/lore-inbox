Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbUAUSUW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 13:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265590AbUAUSUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 13:20:22 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:59570 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263775AbUAUSUQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 13:20:16 -0500
Subject: Re: 2.6.1 "clock preempt"?
From: john stultz <johnstul@us.ibm.com>
To: hauan@cmu.edu
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1074697593.5650.26.camel@steinar.cheme.cmu.edu>
References: <1074630968.19174.49.camel@steinar.cheme.cmu.edu>
	 <1074633977.16374.67.camel@cog.beaverton.ibm.com>
	 <1074697593.5650.26.camel@steinar.cheme.cmu.edu>
Content-Type: text/plain
Message-Id: <1074709166.16374.73.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 21 Jan 2004 10:19:26 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-01-21 at 07:06, Steinar Hauan wrote:
> On Tue, 2004-01-20 at 16:26, john stultz wrote:
> > How quickly do you see this message? Does it happen right at boot time,
> > or during load?
> 
> boottime:
>   Jan 19 08:59:24 localhost kernel: Linux version 2.6.1
>                         (root@offa) (gcc version 3.3.2 20031218
>                         (Red Hat Linux 3.3.2-5)) #2 
>                         SMP Sat Jan 17 18:05:09 EST 2004
> 
>   (yes, i have SMP enabled even for a single cpu machine; the kernel
>    will be run on a multitude of machines of which most are SMP)
> 
> log messages prior to time issues:
> 
> Jan 20 04:02:01 localhost anacron[6057]: Updated timestamp for 
>                                              job `cron.daily' to
> 2004-01-20
> Jan 20 04:05:38 localhost kernel: hdb: dma_timer_expiry:
>                                              dma status == 0x61
> Jan 20 04:05:48 localhost kernel: hdb: DMA timeout error
> Jan 20 04:05:48 localhost kernel: hdb: dma timeout error:
>                                              status=0xd0 {Busy }
> Jan 20 04:05:48 localhost kernel: hda: DMA disabled
> Jan 20 04:05:48 localhost kernel: hdb: DMA disabled
> Jan 20 04:05:48 localhost kernel: ide0: reset: success
> 
> (hda and hdb are on the same controller; the only active disk at
>  this time should be hda ... hdb should be essentially idle
>  except for cron.daily scripts running around then)
> 
> timing error starts here; interactive work
> 
> Jan 20 07:52:40 localhost kernel: Losing too many ticks!

Hmm. It might be that IDE PIO mode on your system blocks interrupts for
too long.

> > You might want to try the attached patch to see if we're overreacting
> [...]
> > Also, do you see the problem when preempt is disabled 
> 
> testing overnight failed to reproduce the problem. note that the
> original event only occurred after about 12 hrs of testing.

Sorry, that was vague. Did you fail to reproduce the problem using the
patch or with preempt disabled?

> i'll install lm_sensors & smarttools and run cpuburn for a while
> to ensure this is not related to any hardware issues.

I doubt its its a hardware fault issue, but more likely some driver not
working properly with your hardware and blocking interrupts for too
long. 

thanks
-john

