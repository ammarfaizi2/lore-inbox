Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315358AbSF3Rw7>; Sun, 30 Jun 2002 13:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315370AbSF3Rw6>; Sun, 30 Jun 2002 13:52:58 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:19174 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S315358AbSF3Rw5>; Sun, 30 Jun 2002 13:52:57 -0400
Date: Sun, 30 Jun 2002 13:55:22 -0400
To: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Thinkpad 560 suspend/hibernate requires floppy
Message-ID: <20020630175522.GA26454@ravel.coda.cs.cmu.edu>
Mail-Followup-To: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>,
	linux-kernel@vger.kernel.org
References: <E17OJdE-0000ne-00@coll.ra.phy.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17OJdE-0000ne-00@coll.ra.phy.cam.ac.uk>
User-Agent: Mutt/1.4i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 29, 2002 at 03:55:24PM +0100, Sanjoy Mahajan wrote:
> I almost always run into trouble suspending or hibernating my Thinkpad
> 560.  On some boots, it works once only.  On others it works many
> times and then stops (it always stops working if I put in a Zoom modem
> card).  I've tried many different kernels, all with the same problem.

I have a 560X, and successful suspending depends on a few things. If you
are on the battery it typically works, but if you are on wall-power, the
BIOS refuses to suspend whenever a communication related pccard is
inserted (i.e. any modem/serial/network card).

I typically need to reload the cs4236 sound driver to avoid DMA timeouts
when the machine comes back.


> CONFIG_APM_DO_ENABLE=y

This one doesn't seem to be needed, APM is already active.

> CONFIG_APM_CPU_IDLE=y

This one seems to _reduce_ my battery life with some kernels (the ones
where kapmd is simply calling apm_idle in a loop without halting the
CPU). Disable this and I can often run for more than 3 hours on a battery,
enabled it is typically less than 2 hours.

> # CONFIG_APM_ALLOW_INTS is not set

Enable this, the bios seems to want interrupts enabled, especially when
suspending to disk.

Jan

