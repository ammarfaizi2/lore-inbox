Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275078AbRJFH5h>; Sat, 6 Oct 2001 03:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275082AbRJFH51>; Sat, 6 Oct 2001 03:57:27 -0400
Received: from smtp.mailbox.co.uk ([195.82.125.32]:22167 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S275078AbRJFH5S>; Sat, 6 Oct 2001 03:57:18 -0400
Date: Sat, 6 Oct 2001 08:57:43 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Ian Thompson <ithompso@stargateip.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How can I jump to non-linux address space?
Message-ID: <20011006085743.A23628@flint.arm.linux.org.uk>
In-Reply-To: <20011004213523.D14538@flint.arm.linux.org.uk> <NFBBIBIEHMPDJNKCIKOBCELFCAAA.ithompso@stargateip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <NFBBIBIEHMPDJNKCIKOBCELFCAAA.ithompso@stargateip.com>; from ithompso@stargateip.com on Fri, Oct 05, 2001 at 05:38:53PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2001 at 05:38:53PM -0700, Ian Thompson wrote:
> I tried both of these, and I must be doing something wrong.  For (1), I
> grabbed the code you mentioned from the RiscPC port (setup_mm_for_reboot()
> and some code from the soft reset routine).  After calling
> setup_mm_for_reboot, if I call __ioremap(), the processor hangs.  If I shut
> down the MMU, I get the same results.

You will need to disable interrupts if the machine vectors are located at
address 0 (check your boot logs with a recent kernel for a message like
"Vectors relocated to ...").

It's probably best to call cpu_proc_fin(), setup_mm_for_reboot() and
cpu_reset(address) directly rather than making your own copy - these
functions already do the right things for you.  setup_mm_for_reboot()
will remap all of user space with a 1:1 virtual to physical mapping,
and hopefully on the Xscale, the two cpu_* functions do the intended
setup for this (I've not reviewed the xscale stuff in any great detail
yet though).

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

