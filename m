Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313724AbSDIFXN>; Tue, 9 Apr 2002 01:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313736AbSDIFXJ>; Tue, 9 Apr 2002 01:23:09 -0400
Received: from zero.tech9.net ([209.61.188.187]:49156 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S313724AbSDIFXI>;
	Tue, 9 Apr 2002 01:23:08 -0400
Subject: [PATCH] preemption latency measurement tool
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Cc: kpreempt-tech@lists.sourceforge.net
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 09 Apr 2002 01:23:16 -0400
Message-Id: <1018329797.908.10.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

preempt-stats, the preemption-off period measurement tool, has been
updated with new patches for 2.4.18, 2.4.19-pre6, 2.4.19-pre5-ac3,
2.5.7, and 2.5.8-pre2 available at:

	http://www.kernel.org/pub/linux/kernel/people/rml/preempt-stats
		and
	http://tech9.net/rml/linux

A lot of work, courtesy of MontaVista, has gone into this release to
greatly improve the accuracy of the tool's measurements.

This patch instructs the kernel preemption code to measure periods of
non-preemptibility and report the 20 worst in /proc/latencytimes.  These
results typically correspond to the 20 longest held spinlocks in your
working kernel.  They help pinpoint specific problem areas that need
work.  Example results:

cpu 0 worst 20 latency times of 2236 measured in this period.
  usec      cause     mask   start line/file      address   end line/file
  9292        BKL        1  2839/buffer.c        c0142caf  2842/buffer.c
  5999  spin_lock        9    86/softirq.c       c011c56d   112/softirq.c
  4495  spin_lock        1   401/memory.c        c0126f18   422/memory.c
  2697  spin_lock        1   671/inode.c         c015658a   697/inode.c
  ... et cetera

The patch obviously requires a preemptive kernel.  For 2.4, the patches
are available at the above address.  Preempt-kernel is merged in 2.5.

Change Log:

20020409

- make stats code aware of PREEMPT_ACTIVE	(Todd Poynor)
- proper start/stop order in preempt_schedule	(Todd Poynor)
- explicitly force preempt region on/off in	(Todd Poynor)
  schedule
- improve reporting wrt interrupts		(Todd Poynor)
- missing stop in do_softirq			(Todd Poynor)

20020302:

- make preempt-stats report meaningful stats	(Todd Poynor)
  on SMP
- fix overflow with large latency values on	(Todd Poynor)
  high clock-rate CPUs

20020204:

- accidently removed preempt_schedule export	(Willy Tarreau)
- properly export statistics functions		(Willy Tarreau)

Enjoy,

	Robert Love

