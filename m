Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264981AbUAUPGt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 10:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265442AbUAUPGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 10:06:49 -0500
Received: from SMTP3.andrew.cmu.edu ([128.2.10.83]:23234 "EHLO
	smtp3.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S264981AbUAUPGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 10:06:47 -0500
Subject: Re: 2.6.1 "clock preempt"?
From: Steinar Hauan <steinhau@andrew.cmu.edu>
Reply-To: hauan@cmu.edu
To: john stultz <johnstul@us.ibm.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1074633977.16374.67.camel@cog.beaverton.ibm.com>
References: <1074630968.19174.49.camel@steinar.cheme.cmu.edu>
	 <1074633977.16374.67.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Organization: Carnegie Mellon University
Message-Id: <1074697593.5650.26.camel@steinar.cheme.cmu.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-3) 
Date: Wed, 21 Jan 2004 10:06:33 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-01-20 at 16:26, john stultz wrote:
> On Tue, 2004-01-20 at 12:36, Steinar Hauan wrote:
> >   i've started to test the 2.6 series of kernels and observed a
> >   strange thing: with moderate background load, the system clock
> >   (i.e. time) seems to slow down to about 60% of normal speed
> >   and the normally reliable ntp process (v4.2.0)

omission in original post: 
  [...] ntp process "was running", but failed to update time.

> >   the kernel logs show messages on the form:
> > 
> > localhost kernel: Losing too many ticks!
> > localhost kernel: TSC cannot be used as a timesource.
> >                        (Are you running with SpeedStep?)
> 
> How quickly do you see this message? Does it happen right at boot time,
> or during load?

boottime:
  Jan 19 08:59:24 localhost kernel: Linux version 2.6.1
                        (root@offa) (gcc version 3.3.2 20031218
                        (Red Hat Linux 3.3.2-5)) #2 
                        SMP Sat Jan 17 18:05:09 EST 2004

  (yes, i have SMP enabled even for a single cpu machine; the kernel
   will be run on a multitude of machines of which most are SMP)

log messages prior to time issues:

Jan 20 04:02:01 localhost anacron[6057]: Updated timestamp for 
                                             job `cron.daily' to
2004-01-20
Jan 20 04:05:38 localhost kernel: hdb: dma_timer_expiry:
                                             dma status == 0x61
Jan 20 04:05:48 localhost kernel: hdb: DMA timeout error
Jan 20 04:05:48 localhost kernel: hdb: dma timeout error:
                                             status=0xd0 {Busy }
Jan 20 04:05:48 localhost kernel: hda: DMA disabled
Jan 20 04:05:48 localhost kernel: hdb: DMA disabled
Jan 20 04:05:48 localhost kernel: ide0: reset: success

(hda and hdb are on the same controller; the only active disk at
 this time should be hda ... hdb should be essentially idle
 except for cron.daily scripts running around then)

timing error starts here; interactive work

Jan 20 07:52:40 localhost kernel: Losing too many ticks!

> You might want to try the attached patch to see if we're overreacting
[...]
> Also, do you see the problem when preempt is disabled 

testing overnight failed to reproduce the problem. note that the
original event only occurred after about 12 hrs of testing.
i'll install lm_sensors & smarttools and run cpuburn for a while
to ensure this is not related to any hardware issues.

--> other suggestions also appreciated.

regards,
-- 
  Steinar Hauan, dept of ChemE  --  hauan@cmu.edu
  Carnegie Mellon University, Pittsburgh PA, USA


