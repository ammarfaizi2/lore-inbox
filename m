Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265391AbUAKQiZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 11:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265436AbUAKQiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 11:38:25 -0500
Received: from nobody.lpr.e-technik.tu-muenchen.de ([129.187.151.1]:27601 "EHLO
	nobody.lpr.e-technik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S265391AbUAKQiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 11:38:19 -0500
Message-ID: <40017BFC.9000408@metrowerks.com>
Date: Sun, 11 Jan 2004 17:38:20 +0100
From: Bernhard Kuhn <bkuhn@metrowerks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Voicu Liviu <pacman@mscc.huji.ac.il>
CC: linux-kernel@vger.kernel.org
Subject: Re: [announcement, patch] real-time interrupts for the Linux kernel
References: <3FFE078D.20400@metrowerks.com> <400113EE.6060909@mscc.huji.ac.il>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Voicu Liviu wrote:

> Can this be used for a normal desktop?

I don't think that real time interrupts are usefull for
a desktop environment: here, even interrupt latencies
below one millisecond should be more than good enough for
streaming/multimedia applications and games - if your
specific application is not "fast" or "reactive" enough,
i would tend to say that it is not the fault of the linux
kernel and it's the implementation of the application
itself or one of the related kernel drivers that needs
improovment. If you recognize interrupt response times
higher than a millisecond with a standard linux kernel,
then there is definitly a bad device driver or something
is broken with your hardware.

The real time interrupt patch is mostly intended to be
used in control loop and data aquisition applications
where higher latencies or jitters higher than a few
mirocseconds could have catastrophic consequences.
However, i can imagine that it makes sense to use
this patch for some very special networking devices
where the kernel might sometimes not be able to response
quick enough because it is just processing an
interrupt of type SA_INTERRUPT that takes too much
time. But in these cases, i guess it's simpler to fix
that other device driver (by moving parts of the interrupt
handler to a tasklet) rather than introducing
real time interrupts - the only problem with this
variant is that for oftenly changing hardware
configurations, you can never be sure if you catched
all "longest execution paths" and you may end up
spending most of your time improving other device
drivers.

BTW.: having interrupt priorities is only the first
step to make the kernel hard real time aware. The
next step would be to make the kernel scheduler
re-entrentable, so that a user space application
related to a high priority interrupt could run
at a higher priority than a low level interrupt service
routine (low priority interrupts are disabled while the
high priority application is running) - this scheme
is pretty similar to LXRT, except that the kernel scheduler
is used instead of an external dispatcher. But just
as like as with LXRT, you only have a very limited
set of system calls and you can easly lock up your system
when an application takes 100% of the CPU.

best regards

Bernhard

