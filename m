Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264673AbSKUUYK>; Thu, 21 Nov 2002 15:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264677AbSKUUYK>; Thu, 21 Nov 2002 15:24:10 -0500
Received: from quark.didntduck.org ([216.43.55.190]:58641 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S264673AbSKUUYJ>; Thu, 21 Nov 2002 15:24:09 -0500
Message-ID: <3DDD4288.70605@didntduck.org>
Date: Thu, 21 Nov 2002 15:31:04 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joel Becker <Joel.Becker@oracle.com>
CC: lkml <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Wim Coekaerts <Wim.Coekaerts@oracle.com>
Subject: Re: [RFC] hangcheck-timer module
References: <20021121201711.GG770@nic1-pc.us.oracle.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker wrote:
> Folks,
> 	Attached is a module, hangcheck-timer.  It is used to detect
> when the system goes out to lunch for a period of time, such as when a
> driver like qla2x00 udelays a bunch.
> 	The module sets a timer.  When the timer goes off, it then uses
> the TSC (warning: portability needed) to determine how much real time
> has passed.
> 	On a normal system, the real elapsed time will be almost
> identical to the expected timer duration.  However, if a device decided
> to udelay for 60 seconds (or some other circumstance), the module takes
> notice.  If the margin of error passes a threshold, the machine is
> rebooted.
> 	The module is currently used in a cluster environment.  After
> some time out to lunch, the rest of the cluster will have given up on a
> machine.  If the machine suddenly comes back and assumes it is still
> "live", bad things can happen.
> 	We can also see use for this in a debugging sense, for kernel
> hangs as well as driver code.  That's why I'm proposing it for general
> inclusion.
> 	Comments?  Thoughts?
> 
> Joel
> 
> Building:
> 	The module should happily build against most 2.4 kernels.  The
> usual module building compile line:
> 	gcc  -I /scratch/jlbec/kernel/linux-2.4.20-rc2/include \
> 		-DMODULE -D__KERNEL__ -DLINUX  -c -o hangcheck-timer.o \
> 		hangcheck-timer.c
> 
> Running:
> 	Load the module with insmod.  There are two options.
> "hangcheck_tick=<seconds>" specifies the timer timeout, and
> "hangcheck_margin=<seconds" specifies the margin of error.
> 
> Joel
> 

There is already an NMI watchdog that is better than what you propose, 
because it will also catch cases where something gets stuck with 
interrupts disabled.

--
				Brian Gerst

