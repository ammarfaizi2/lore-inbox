Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265934AbRGERVQ>; Thu, 5 Jul 2001 13:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265962AbRGERVG>; Thu, 5 Jul 2001 13:21:06 -0400
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:4482 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S265934AbRGERUy>; Thu, 5 Jul 2001 13:20:54 -0400
From: mdaljeet@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: linux-kernel@vger.kernel.org
Message-ID: <CA256A80.005F1790.00@d73mta01.au.ibm.com>
Date: Thu, 5 Jul 2001 21:43:07 +0530
Subject: floating point problem
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In Linux PPC, the MSR[FP] bit (that is floating point available bit) is off
(atleast for non-SMP).

Due to this, whenever some floating point instruction is executed in 'user
mode', it leads to a exception 'FPUnavailable'. The exception handler for
this exception apart from setting the MSR[FP] bit, also sets the MSR[FE0]
and MSR[FE1] bits. These bits basically enables the floating point
exceptions so that if there are some floating point exception conditions
encountered while exeuting a floating point instruction, an appropriate
exception is raised.
But whenever some floating point instruction is executed in 'kernel mode',
'FPUnavailabe' exception handler code does not set the 'MSR[FE0] and
MSR[FE1]' bits.

The result is that when we execute a piece of code that executes floating
point instructions with some large values, we get 'floating point
exceptions for overflow etc' but we get some rounded off values when we
execute the same piece of code in a kernel module. We made a modification
in the head.S file and commented out the setting of 'MSR[FE0] and MSR[FE1]'
bits in the 'FPUnavailable' exception handler for user mode. Due to this we
are getting correct results i.e. rounded off values.

Problem is that we want to get the good results without changing the
kernel. Either by having the user mode application to interact with some
special module which can set the MSR[FP] bit before we execute the floating
point instruction or by some other trick.....Is there any solution apart
from changing the kernel?

thanks,
Daljeet.


