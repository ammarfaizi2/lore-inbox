Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267473AbUHTThO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267473AbUHTThO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 15:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267553AbUHTThO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 15:37:14 -0400
Received: from 251041.vserver.de ([62.75.251.41]:40909 "EHLO 251041.vserver.de")
	by vger.kernel.org with ESMTP id S268667AbUHTTgh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 15:36:37 -0400
Date: Fri, 20 Aug 2004 13:35:20 -0600
From: martin rumori <lists@rumori.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Jackit-devel] Re: problems with volunteer preempt patch WAS: little NPTL SCHED_FIFO test program
Message-ID: <20040820193520.GA3129@amadora.tejo>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	Lee Revell <rlrevell@joe-job.com>,
	jackit-devel <jackit-devel@lists.sourceforge.net>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200408180100.04955.pnambic@unu.nu> <20040818023546.03e79fc4@mango.fruits.de> <1092794828.813.49.camel@krustophenia.net> <20040818050708.54a27a7e@mango.fruits.de> <pan.2004.08.19.23.33.47.308243@gmx.de> <1092987523.10063.62.camel@krustophenia.net> <20040820092042.GA2496@amadora.tejo> <1092994979.10063.80.camel@krustophenia.net> <20040820175351.GA2302@amadora.tejo> <20040820183559.GD21956@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040820183559.GD21956@elte.hu>
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2004 at 08:35:59PM +0200, Ingo Molnar wrote:
> > i am wondering especially about the ACPI messages, as ACPI is
> > completely switched off now.
> 
> is ACPI switched off in the .config too?

basically yes, but there is one strange thing:

#
# Power management options (ACPI, APM)
#
# CONFIG_PM is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
# CONFIG_ACPI is not set
CONFIG_ACPI_BOOT=y

i don't know where to find the last option in the config programs
(menuconfig, xconfig).  if i comment it manually, it'll get
uncommented as soon as the next make command is issued, regardless
whether make xconfig again, make oldconfig, or make.  it gets reverted
to the above shown state.

i figured out that in stock 2.6.8.1 and 2.6.7-cko5 this option is
enabled, too, (even with the rest of acpi disabled and apm enabled)
maybe i can't see the messages at boot time since they are going to
fast.

> > maybe latency.o is not included when linking without
> > CONFIG_PREEMPT_TIMING?
> 
> right. We dont want to link it in so i've added a NOP define for
> __trace() to sched.h. This fix will show up in -P6.

great, many thanks.

bests,

martin
