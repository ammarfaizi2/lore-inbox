Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292283AbSBBON1>; Sat, 2 Feb 2002 09:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292286AbSBBONS>; Sat, 2 Feb 2002 09:13:18 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:19400 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S292283AbSBBONF>; Sat, 2 Feb 2002 09:13:05 -0500
Date: Sat, 2 Feb 2002 15:12:41 +0100
From: "W. Michael Petullo" <mike@flyn.org>
To: linux-kernel@vger.kernel.org
Cc: wli@holomorphy.com
Subject: Re: SMP Pentium III, GA-6VXDC7 MoBo. -- 2.4.18-pre7 SMP not working
Message-ID: <20020202151241.A1417@dragon.flyn.org>
In-Reply-To: <20020127172150.A1407@dragon.flyn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020127172150.A1407@dragon.flyn.org>; from mike@flyn.org on Sun, Jan 27, 2002 at 05:21:50PM +0100
X-Operating-System: Linux dragon.flyn.org 2.4.10-xfs 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a home-built dual Pentium III computer which does not seem to
> want to run recent SMP kernels.  The computer is built on a Gigabyte
> GA-6VXDC7 motherboard, which is in turn based on a VIA Apollo Pro chip-set.
> It is an exclusively SCSI system -- I do not compile any IDE drivers
> into my kernel.
> 
> Kernel 2.4.12 works fine when compiled with SMP on.  However, anything
> newer fails to load when compiled with SMP support.  In the failing cases,
> lilo prints its uncompressing kernel and booting kernel messages followed
> by a system hang -- the kernel never prints anything.
> 
> Kernel.org
> Vanilla		CONFIG_SMP=y		# CONFIG_SMP is not set
> Version		SMP Status		UP Status
> ======================================================
> 2.4.10		SMP works		Fine
> 2.4.11		Wouldn't touch		Wouldn't touch
> 2.4.12		SMP Works		Fine
> 2.4.13		SMP does not boot	Fine
> 2.4.14		Did not try		Did not try
> 2.4.15		Did not try		Did not try
> 2.4.16		SMP does not boot	Fine
> 2.4.17		SMP does not boot	Fine
> 2.4.18-pre7		SMP does not boot	Fine
> 
> Since the kernel does not even peep an oops message, I'm not sure where
> to start debugging.  Is anyone else having similar problems?

I'm having a lot of trouble debugging this one.  Prinks are not being
displayed on the screen, though I know they are being executed.  I have
even tried William Lee Irwin's early_printk patch to try and get printks
to display.  Apparently the prink buffer is not being flushed this early
in the kernel code?

The only debugging technique I have found is to insert return statements
in order to avoid different sections of code.  I find, for example,
that if I make the first statement of the smpboot.c:do_boot_cpu a return,
the kernel will boot (without SMP on, of course).

Obviously, this is not the best technique.  I have been able to narrow
the location of the bug down a little with it, but I feel I will be able
to discover little more with this technique.

I'm not sure what else to do without printks.

I would appreciate any tips on debugging smpboot.c.

Thank you.

-- 
Mike

:wq
