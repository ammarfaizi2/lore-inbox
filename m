Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265134AbUHJNwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265134AbUHJNwG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 09:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266219AbUHJNkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 09:40:16 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:63495 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265134AbUHJNjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 09:39:47 -0400
Date: Tue, 10 Aug 2004 14:39:40 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: William Lee Irwin III <wli@holomorphy.com>, V13 <v13@priest.com>,
       Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.8-rc3-mm2
Message-ID: <20040810143940.D20890@flint.arm.linux.org.uk>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	William Lee Irwin III <wli@holomorphy.com>, V13 <v13@priest.com>,
	Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>
References: <200408091217.50786.jbarnes@engr.sgi.com> <20040810100234.GN11200@holomorphy.com> <20040810115307.GR11200@holomorphy.com> <200408101552.22501.v13@priest.com> <20040810125140.GU11200@holomorphy.com> <20040810125529.GA22650@elte.hu> <20040810125651.GV11200@holomorphy.com> <20040810130122.GA26326@elte.hu> <20040810141220.B20890@flint.arm.linux.org.uk> <20040810131628.GA28167@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040810131628.GA28167@elte.hu>; from mingo@elte.hu on Tue, Aug 10, 2004 at 03:16:28PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2004 at 03:16:28PM +0200, Ingo Molnar wrote:
> 
> * Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> 
> > Except serial console IO does not generate _any_ IRQ traffic - it
> > purposely disables IRQs on the device before starting any IO to
> > prevent any user-level IO interfering with the console output.
> 
> indeed - but it does generate _some_ IRQ traffic still:
> 
>   3:        251    IO-APIC-edge  serial
> 
> this is from a box that uses the serial line only for the kernel
> console.

If the IRQ is claimed, userspace has opened the port.  Is a getty
running on the port?  If so, it would've written some messages to
the port, which would have caused these interrupts.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
