Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262233AbUKQI2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262233AbUKQI2J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 03:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbUKQI2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 03:28:09 -0500
Received: from smtp.Lynuxworks.com ([207.21.185.24]:48649 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S262233AbUKQI1Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 03:27:24 -0500
Date: Wed, 17 Nov 2004 00:26:20 -0800
To: Amit Shah <amit.shah@codito.com>
Cc: Ingo Molnar <mingo@elte.hu>, "K.R. Foley" <kr@cybsft.com>,
       Mark_H_Johnson@raytheon.com, Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>,
       Stefan Schweizer <sschweizer@gmail.com>
Subject: Re: BUG with 0.7.27-11, with KGDB
Message-ID: <20041117082620.GA23226@nietzsche.lynx.com>
References: <OFE5FC77BB.DA8F1FAE-ON86256F4E.0058C5CF-86256F4E.0058C604@raytheon.com> <419A5A53.6050100@cybsft.com> <20041116212401.GA16845@elte.hu> <200411171329.41209.amit.shah@codito.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411171329.41209.amit.shah@codito.com>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2004 at 01:29:33PM +0530, Amit Shah wrote:
> Initializing Cryptographic API
> kgdb <20030915.1651.33> : port =3f8, IRQ=4, divisor =1
> BUG: scheduling while atomic: swapper/0x00000001/1
> caller is schedule+0x3f/0x13c
>  [<c01041f4>] dump_stack+0x23/0x27 (20)
>  [<c02ce307>] __sched_text_start+0xc97/0xce7 (116)
>  [<c02ce396>] schedule+0x3f/0x13c (36)
>  [<c02ce60a>] wait_for_completion+0x95/0x137 (96)
>  [<c0138cd8>] kthread_create+0x22a/0x22c (368)
>  [<c0145a30>] start_irq_thread+0x4f/0x83 (32)
>  [<c01453ec>] setup_irq+0x55/0x140 (36)
>  [<c0145655>] request_irq+0x90/0x107 (44)
>  [<c01e1bc1>] kgdb_enable_ints_now+0xa5/0xb0 (28)
>  [<c03bfb89>] kgdb_enable_ints+0x2c/0x63 (16)
>  [<c03a8a23>] do_initcalls+0x31/0xc6 (32)
>  [<c01003bb>] init+0x87/0x19a (28)
>  [<c0101329>] kernel_thread_helper+0x5/0xb (1047322644)

Woops, it means that KGDB needs a direct irq and not an irq-thread.
Let me see if I can work up something tonight before I head to bed.

bill

