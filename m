Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262210AbTEATRX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 15:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262233AbTEATRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 15:17:22 -0400
Received: from chaos.analogic.com ([204.178.40.224]:54160 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262210AbTEATRV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 15:17:21 -0400
Date: Thu, 1 May 2003 15:32:00 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Lee, Shuyu" <SLee@cognex.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: How to notify a user process from within a driver
In-Reply-To: <6AF24836F3EB074BA5C922466F9E92E10791B52F@prince.pc.cognex.com>
Message-ID: <Pine.LNX.4.53.0305011528001.1744@chaos>
References: <6AF24836F3EB074BA5C922466F9E92E10791B52F@prince.pc.cognex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

