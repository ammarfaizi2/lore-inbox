Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284211AbRLFUuQ>; Thu, 6 Dec 2001 15:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284248AbRLFUsn>; Thu, 6 Dec 2001 15:48:43 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:9477 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S284211AbRLFUrd>; Thu, 6 Dec 2001 15:47:33 -0500
Message-ID: <3C0FD955.4510B738@zip.com.au>
Date: Thu, 06 Dec 2001 12:47:17 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Greg Hennessy <gsh@cox.rr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: horrible disk thorughput on itanium
In-Reply-To: <20011206110713.A8404@cox.rr.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Hennessy wrote:
> 
> ...
> Hydra is the itanium, leo is the 32 bit machine. The character io of
> hydra is a factor of 10 slower than that of leo. Is this more likely a
> kernel issue, or a glibc issue? Both machiness run standard redhat
> 7.1, and 2.4.9-12smp kernels.
> 

The character I/O part of bonnie++ writes a single character at a time,
via stdio.  It's more a test of your C library than of the kernel.

The fact that you get the same throughput on each platform with
the block I/O part of the test indicates that the hardware and
kernel are OK, but the C library is broken.

Not sure how to diagnose this.  Probably you should write a
simple five-line stdio-based test program, see if that exhibits
the same behaviour, then fiddle with setvbuf().

-
