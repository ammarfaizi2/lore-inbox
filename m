Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264767AbUGMKXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264767AbUGMKXp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 06:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264770AbUGMKXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 06:23:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:23250 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264767AbUGMKXm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 06:23:42 -0400
Date: Tue, 13 Jul 2004 03:22:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: Thomas Charbonnel <thomas@undata.org>
Cc: paul@linuxaudiosystems.com, albert@users.sourceforge.net,
       linux-kernel@vger.kernel.org, florin@sgi.com,
       linux-audio-dev@music.columbia.edu
Subject: Re: desktop and multimedia as an afterthought?
Message-Id: <20040713032201.010f3e0f.akpm@osdl.org>
In-Reply-To: <1089683379.5773.62.camel@localhost>
References: <1089665153.1231.88.camel@cube>
	<200407122354.i6CNsNqS003382@localhost.localdomain>
	<20040712172458.2659db52.akpm@osdl.org>
	<1089683379.5773.62.camel@localhost>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Charbonnel <thomas@undata.org> wrote:
>
> On my system xruns seem related to the keyboard. I get xruns on ~8.079
>  seconds boundaries when the keyboard is in use, regardless of the load.
>  My usual test is running jack with 2 periods of 64 samples and no
>  client, and keep a key pressed. Those latencytest graphs give an idea of
>  the problem : http://www.undata.org/~thomas/latencytest/index.html
> 
>  Here are the xrun_debug reports :

OK, thanks.

Stack tracing seems a bit broken with 4k stacks.  Can you disable
CONFIG_4KSTACKS for future testing?

>  For the intel8x0 :
>  XRUN: pcmC1D0p
>  Stack pointer is garbage, not printing trace
>  Unexpected hw_pointer value [1] (stream = 1, delta: -16, max jitter =
>  64): wrong interrupt acknowledge?
>   [<c0105f3e>] dump_stack+0x1e/0x30
>   [<c033240d>] snd_pcm_period_elapsed+0x1cd/0x420
>   [<c03578cc>] snd_intel8x0_interrupt+0x1fc/0x260
>   [<c010739b>] handle_IRQ_event+0x3b/0x70
>   [<c0107824>] do_IRQ+0x194/0x1b0
>   [<c0105ac4>] common_interrupt+0x18/0x20
>   [<c0107754>] do_IRQ+0xc4/0x1b0
>   [<c0105ac4>] common_interrupt+0x18/0x20
>   [<c0108126>] do_softirq+0x46/0x60
>   [<c01077d9>] do_IRQ+0x149/0x1b0
>   [<c0105ac4>] common_interrupt+0x18/0x20
>   [<c01030f4>] cpu_idle+0x34/0x40
>   [<c053c809>] start_kernel+0x169/0x190
>   [<c010019f>] 0xc010019f
>   =======================
>   [<c0105f3e>] dump_stack+0x1e/0x30
>   [<c033240d>] snd_pcm_period_elapsed+0x1cd/0x420
>   [<c03578cc>] snd_intel8x0_interrupt+0x1fc/0x260
>   [<c010739b>] handle_IRQ_event+0x3b/0x70
>   [<c0107824>] do_IRQ+0x194/0x1b0
>   [<c0105ac4>] common_interrupt+0x18/0x20
>   [<c0107754>] do_IRQ+0xc4/0x1b0
>   [<c0105ac4>] common_interrupt+0x18/0x20
>   [<c0108126>] do_softirq+0x46/0x60
>   [<c01077d9>] do_IRQ+0x149/0x1b0
>   [<c0105ac4>] common_interrupt+0x18/0x20
>   [<c01030f4>] cpu_idle+0x34/0x40
>   [<c053c809>] start_kernel+0x169/0x190
