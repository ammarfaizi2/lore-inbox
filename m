Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266306AbUGOVgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266306AbUGOVgX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 17:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266324AbUGOVgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 17:36:23 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:39913 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266306AbUGOVgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 17:36:19 -0400
Subject: Re: Losing interrupts
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1089843559.22841.8.camel@mindpipe>
References: <1089843559.22841.8.camel@mindpipe>
Content-Type: text/plain
Message-Id: <1089927383.24832.14.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 15 Jul 2004 17:36:24 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-14 at 18:19, Lee Revell wrote:
> It seems that interrupts are being disabled for long periods, resulting
> in the soundcard interrupt being lost.  I hacked the ALSA emu10k1 driver
> to keep track in the interrupt handler of the number of CPU cycles
> elapsed since the last time it ran.  I am using a period that
> corresponds to 666 microseconds between interrupts, or ~400000 cycles on
> my 600Mhz CPU.  As you can see the average jitter is *extremely* low -
> 50-400 CPU cycles of per interrupt.  I hardcoded it to printk if the
> jitter is more than 15000 (only happens every 5-10 seconds), and error
> if it's really big.  As you can see, something is disabling interrupts
> for a long time.  This is a completely different issue from an XRUN,
> improving the scheduler latency will not solve this.
> 

The problem is with the video driver (Via CastleRock integrated,
AGP4x).  By dragging certain windows around slowly in X, I can reliably
cause interrupts to be completely disabled for tens of milliseconds.

There was an issue several years ago where Matrox figured out they could
get slightly better benchmark scores by not checking whether a FIFO on
the video card was full before writing to it, which would cause the PCI
bus to completely freeze until the FIFO had drained.  Lots of vendors
followed suit until one of the audio software vendors figred it out and
called them on it, at which point they fixed their drivers.  The effects
(massive audio drouputs) and the steps to reproduce (drag a window
around the screen slowly) were identical.

I will contact the maintainer.

Lee



