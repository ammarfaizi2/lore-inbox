Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291640AbSBNNdv>; Thu, 14 Feb 2002 08:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291641AbSBNNdj>; Thu, 14 Feb 2002 08:33:39 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:52242 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291640AbSBNNd3>; Thu, 14 Feb 2002 08:33:29 -0500
Subject: Re: Using kernel_fpu_begin() in device driver - feasible or not?
To: rwestman@telia.com (Rickard Westman)
Date: Thu, 14 Feb 2002 13:47:23 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C6B00B3.6000602@telia.com> from "Rickard Westman" at Feb 14, 2002 01:11:31 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16bMEO-0008Up-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1. Would it be sufficient to just bracket all fpu-using code code by
> kernel_fpu_begin()/kernel_fpu_end()?  If not, what problems could I
> run into?

You can do that providing you dont

> 2. Would it be OK to go to sleep inside such a region, or should I
> take care to avoid that?

You can't sleep in such a region - there is nowhere left to store the
FPU context

> 3. Perhaps I should call init_fpu() at some point as well?  If so,
> should it be done before or after kernel_fpu_begin()?

After

> 4. Is there any difference between doing this in the context of a user
> process (implementation of an ioctl) compared to doing it in a
> daemonized kernel thread (created by a loadable kernel module)?

The kernel thread is actually easier, you can happily corrupt its user
FPU context by sleeping since you are the only FPU user for the thread.
Not nice, not portable but should work fine on x86 without any of the 
above for the moment.

You should probably also test the FPU is present and handle it accordingly
with polite messages not an oops 8)
