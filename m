Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267401AbUHSVOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267401AbUHSVOy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 17:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267407AbUHSVOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 17:14:54 -0400
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:30641 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S267401AbUHSVOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 17:14:48 -0400
Date: Thu, 19 Aug 2004 23:14:41 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Ivan Kalatchev <ivan.kalatchev@esg.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: System time slowdown after upgrading from 2.4 to 2.6
In-Reply-To: <000501c48624$b1ac72f0$2e646434@ivans>
Message-ID: <Pine.LNX.4.53.0408192308050.23614@gockel.physik3.uni-rostock.de>
References: <000501c48624$b1ac72f0$2e646434@ivans>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Aug 2004, Ivan Kalatchev wrote:
> We have a project that uses PC-104 (ZFx86 100 MHz CPU) Linux box to acquire
> some seismological signals. System resides on a M-Systems DiskOnChip 2000.
> We have an ISA acquisition card that acquires data into FIFO buffer and
> triggers interrupt as soon as 341 points were acquired (then this data is
> read out in interrupt handler routine). System worked perfectly well when we
> used 2.4.18 kernel. When I printk-ed system time (do_gettimeofday)  in
> interrupt routine, at 1kHz sampling frequency interrupts were reported every
> 341 msec as they should do.
> But after I've switched to 2.6 kernel (2.6.7 - preempted, then I tried
> 2.6.8 - non-preempted) time between successive interrupts at 1kHz became 335
> msec, losing 6 msec at each interrupt. What is interesting, when sampling
> frequency is 10 kHz, with 2.4.18 kernel interrupts are reported every 34
> msec, which is right, but with 2.6 kernels interrupts are coming at 28 msec
> interval, again losing same 6 msec!

How long does the interrupt handler take to read the data? You might lose
timer interrupts during data readout. Timer interrupts in 2.6 are 10 times 
as frequent as in 2.4
Try changing
  # define HZ   1000
back to
  # define HZ    100
in include/asm-i386/param.h. If that helps, just leave it that way.

Tim

