Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265119AbUHJNRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265119AbUHJNRq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 09:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265106AbUHJNQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 09:16:50 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:22791 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265091AbUHJNMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 09:12:30 -0400
Date: Tue, 10 Aug 2004 14:12:20 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: William Lee Irwin III <wli@holomorphy.com>, V13 <v13@priest.com>,
       Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.8-rc3-mm2
Message-ID: <20040810141220.B20890@flint.arm.linux.org.uk>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	William Lee Irwin III <wli@holomorphy.com>, V13 <v13@priest.com>,
	Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>
References: <200408091217.50786.jbarnes@engr.sgi.com> <20040810100234.GN11200@holomorphy.com> <20040810115307.GR11200@holomorphy.com> <200408101552.22501.v13@priest.com> <20040810125140.GU11200@holomorphy.com> <20040810125529.GA22650@elte.hu> <20040810125651.GV11200@holomorphy.com> <20040810130122.GA26326@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040810130122.GA26326@elte.hu>; from mingo@elte.hu on Tue, Aug 10, 2004 at 03:01:22PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2004 at 03:01:22PM +0200, Ingo Molnar wrote:
> 
> * William Lee Irwin III <wli@holomorphy.com> wrote:
> 
> > On Tue, Aug 10, 2004 at 02:55:29PM +0200, Ingo Molnar wrote:
> > > i'd guess it's the con->write() in __call_console_drivers() that makes
> > > the difference. (i.e. touching the framebuffer)
> > 
> > This is serial port IO; would that make the same kind of difference?
> 
> serial port IO is even more heavy, it also generates IRQ traffic.

Except serial console IO does not generate _any_ IRQ traffic - it
purposely disables IRQs on the device before starting any IO to
prevent any user-level IO interfering with the console output.

It does, however, create a fair amount of IO reads and writes to
the serial port.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
