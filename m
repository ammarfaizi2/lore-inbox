Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262919AbTHZTOS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 15:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262915AbTHZTOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 15:14:18 -0400
Received: from chaos.analogic.com ([204.178.40.224]:5760 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262919AbTHZTMr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 15:12:47 -0400
Date: Tue, 26 Aug 2003 15:12:46 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Andy Isaacson <adi@hexapodia.org>
cc: max@vortex.physik.uni-konstanz.de,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test4 shocking (HT) benchmarking (wrong logic./phys. HT
 CPU distinction?)
In-Reply-To: <20030826135051.A16285@hexapodia.org>
Message-ID: <Pine.LNX.4.53.0308261455590.4526@chaos>
References: <200308261552.44541.max@vortex.physik.uni-konstanz.de>
 <20030826135051.A16285@hexapodia.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Aug 2003, Andy Isaacson wrote:

> On Tue, Aug 26, 2003, max@vortex.physik.uni-konstanz.de wrote:
> > in our fine physics group we recently bought a DUAL XEON P4 2666MHz, 2GB,
> > with
> > hyper-threading support and I had the honour of making the thing work.
> > In the
> > process I also did some benchmarking using two different kernels (stock
> > SuSE-8.2-Pro 2.4.20-64GB-SMP, and the latest and greatest vanilla
> > 2.6.0-test4). I benchmarked
> >
> > [2] running time of a multi-threaded numerical simulation making
> > extensive use of FFTs, using the fftw.org library.
>
> One thing to watch out for, with fftw:  I believe it will benchmark
> various kernels, and decide which one to use, at run-time.  If the
> scheduler fools it into thinking that a particular kernel is going to
> perform better, it might do the wrong thing.
>
> Does fftw have a switch to write a debug log?
>
> ("kernel" in this context means "the small section of code used to solve
> the fft", not "the OS code running in privileged mode".)
>
> -andy

The benchmarks in the fftw.org libraries are useful only as
time-sinks. At least on ix86, our tests show that a generic
fft, perhaps 10 years old, with no special treatment except
using pointers instead of indexes, when using 'double' as
float, is, within the test noise, as fast as their "self-
adapting" fft.

Also, the nature of a fft, reduces the influence of the kernel.
Even with some kind of parallelism, for which there is little
chance because of the serial nature of a fft, you are testing
threads, not the kernel. To the kernel, a fft is just some
CPU bound math.

If you are going to do a lot of math simulation and are not
going to be creating a lot of separate tasks that communicate,
your choice of kernel (or operating system) is irrelevant.
This kind of math-code just sits in user's memory plugging
along until it writes its results to something, somewhere.
The kernel is not involved until the answers are available.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


