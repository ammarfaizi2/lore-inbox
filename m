Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275901AbSIULSG>; Sat, 21 Sep 2002 07:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275902AbSIULSG>; Sat, 21 Sep 2002 07:18:06 -0400
Received: from vaak.stack.nl ([131.155.140.140]:44559 "EHLO mailhost.stack.nl")
	by vger.kernel.org with ESMTP id <S275901AbSIULSE>;
	Sat, 21 Sep 2002 07:18:04 -0400
Date: Sat, 21 Sep 2002 13:23:10 +0200 (CEST)
From: Jos Hulzink <josh@stack.nl>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: udelay and nanosleep questions
Message-ID: <20020921124235.I46546-100000@toad.stack.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Talking about kernel driver programming:

1) Can I rely on udelay(1) ? i.e. is the resolution high enough to wait at
least 1 microsecond given it returns normally ? I know the actual
implementation is platform / cpu dependant, so maybe I should ask: Should
I be able to rely on udelay(1) ?

2) With the highspeed CPUs these days, the implementation of sys_nanosleep
(in kernel/timer.c) for realtime processes:

sys_nanosleep {udelay ((nsec+999)/1000}

is rather low-res. Time for something new ? sys_nanosleep seems not the
call to make for in-kernel accurate delays, for it schedules a timeout
instead of doing a busy wait. My driver needs 250 ns delays, is there a
more accurate way than udelay(1) ? It is a pity to waste 4x more
clockcycli than needed.

3) Usleep and friends seem not to care about speedstepping technologies.
Shouldn't we care, at least for in-kernel and realtime process waits ?
True, you are an idiot when running realtime processes on a speedstep
enabled CPU, but still...

Jos

