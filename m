Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262702AbTEAVls (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 17:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262703AbTEAVlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 17:41:45 -0400
Received: from cambridge1-smrly1.gtei.net ([199.94.215.245]:30447 "HELO
	cambridge1-smrly1.gtei.net") by vger.kernel.org with SMTP
	id S262702AbTEAVlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 17:41:42 -0400
Message-ID: <6AF24836F3EB074BA5C922466F9E92E10791B532@prince.pc.cognex.com>
From: "Lee, Shuyu" <SLee@cognex.com>
To: linux-kernel@vger.kernel.org
Cc: "'root@chaos.analogic.com'" <root@chaos.analogic.com>,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Subject: RE: How to notify a user process from within a driver
Date: Thu, 1 May 2003 17:54:01 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard and Alan,

Thank you for the info. Given the prototype for poll() is
"int poll(struct pollfd *ufds, unsigned int nfds, int timeout);", and pollfd
is struct pollfd {int fd; short events; short revents};, how do I
communicate complex info to the driver?

For example, assuming there are 8 input lines on my hardware, and the user
wants to be notified in the following three cases:
1) input on Line 1 only,
2) input on either Line 2 or Line 3,
3) input on both Line 4 and Line 5,
how do I pass that info to the driver? Also, other than POLLERR and POLLHUP,
can I pass back to the user more descriptive error messages?

Thanks,
Shuyu


 -----Original Message-----
From: 	Richard B. Johnson [mailto:root@chaos.analogic.com] 
Sent:	Thursday, May 01, 2003 3:32 PM
To:	Lee, Shuyu
Cc:	linux-kernel@vger.kernel.org
Subject:	Re: How to notify a user process from within a driver

On Thu, 1 May 2003, Lee, Shuyu wrote:

> Hello, All.
>
> I am working on a device driver. One of the features of the hardware is
> multi-channel I/O control. In order for a user process to communicate with
> the hardware, my design is for the user process to call the driver's ioctl
> to register a semaphore for each I/O channel, then wait on them. When the
> hardware detects an input, the ISR then BH will wake up the user process.
> This sounds straightforward in principle. Because there are two types of
> semaphores in Linux (one for kernel, and one for user), I am not sure how
> this can be accomplished. Any help would be greatly appreciated.
>
> My development environment is:
> 1) OS:  RedHat 7.2 (Linux 2.4.7),
> 2) gcc: 3.2.1,
> 3) PC:  one P-III (HP kayak) with 128Mbyte of memory,
> 4) Bus: PCI.
>
> Shuyu
>

You normally use poll() or select() for this. It's called poll()
inside the driver.

The user-mode code sleeps in poll() or select(). When your
driver ISR wants to wake up the process, it calls
wake_up_interruptible() from within the ISR.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.
