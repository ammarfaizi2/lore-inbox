Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268686AbUHTShV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268686AbUHTShV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 14:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268687AbUHTShU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 14:37:20 -0400
Received: from mx1.elte.hu ([157.181.1.137]:25508 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268691AbUHTSf2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 14:35:28 -0400
Date: Fri, 20 Aug 2004 20:35:59 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>, lists@rumori.de
Subject: Re: problems with volunteer preempt patch WAS: little NPTL SCHED_FIFO test program
Message-ID: <20040820183559.GD21956@elte.hu>
References: <20040818004633.35eb6501@mango.fruits.de> <200408180100.04955.pnambic@unu.nu> <20040818023546.03e79fc4@mango.fruits.de> <1092794828.813.49.camel@krustophenia.net> <20040818050708.54a27a7e@mango.fruits.de> <pan.2004.08.19.23.33.47.308243@gmx.de> <1092987523.10063.62.camel@krustophenia.net> <20040820092042.GA2496@amadora.tejo> <1092994979.10063.80.camel@krustophenia.net> <20040820175351.GA2302@amadora.tejo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040820175351.GA2302@amadora.tejo>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* martin rumori <lists@rumori.de> wrote:

> ACPI RSDP .....
> .....
> ACPI build 1 zone list
> Detected Processor...
> Memory ...
> ...
> Checking if processor honors the WP bit even in supervisor mode... ok.
> 
> ---
> that's it.  freezes for 1-2 seconds after this last message, then
> reboots.  tried to write down these contents of the screen, as far as
> i could recognize them during the short period of time.
> 
> i am wondering especially about the ACPI messages, as ACPI is
> completely switched off now.

is ACPI switched off in the .config too?

> second (minor) issue: when having enabled CONFIG_PREEMPT_VOLUNTARY(=y)
> but not CONFIG_PREEMPT_TIMING(=n), i get the following when linking:
> 
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> arch/i386/kernel/built-in.o(.text+0x2da1): In function `do_nmi':
> : undefined reference to `__trace'

> maybe latency.o is not included when linking without
> CONFIG_PREEMPT_TIMING?

right. We dont want to link it in so i've added a NOP define for
__trace() to sched.h. This fix will show up in -P6.

	Ingo
