Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbUG1G1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbUG1G1T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 02:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266240AbUG1G1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 02:27:19 -0400
Received: from mx1.elte.hu ([157.181.1.137]:32131 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261375AbUG1G1K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 02:27:10 -0400
Date: Wed, 28 Jul 2004 06:55:17 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: linux-kernel@vger.kernel.org, William Lee Irwin III <wli@holomorphy.com>,
       Lenar L?hmus <lenar@vision.ee>, Andrew Morton <akpm@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>, Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-L2, preemptable hardirqs
Message-ID: <20040728045517.GB14363@elte.hu>
References: <1090732537.738.2.camel@mindpipe> <1090795742.719.4.camel@mindpipe> <20040726082330.GA22764@elte.hu> <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu> <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu> <20040727162759.GA32548@elte.hu> <1090967441.1835.2.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090967441.1835.2.camel@teapot.felipe-alfaro.com>
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


* Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> wrote:

> I've seen an oops on my P4 machine when booting with voluntary-
> preempt=3, but not with voluntary-preempt<3. I think it's related to
> the serial controller (IRQ3 and IRQ4). Please, see attached dmesg.

do you mean this one:

> irq event 4: bogus return value ffffffff
>  [<c0105b7e>] __report_bad_irq+0x24/0x7d
>  [<c0105c3e>] note_interrupt+0x49/0x88
>  [<c02bb3c2>] schedule+0x222/0x48d
>  [<c0105f05>] do_hardirq+0x10f/0x191
>  [<c0123cb5>] irqd+0x0/0xad
>  [<c0123d55>] irqd+0xa0/0xad
>  [<c0130010>] kthread+0x7c/0xa4
>  [<c012ff94>] kthread+0x0/0xa4
>  [<c0102249>] kernel_thread_helper+0x5/0xb
> handlers:

this isnt an oops, it is essentially just a warning. I am too getting
this a couple of times during bootup when using the serial console.

irqd changes timings and apparently in this case the serial IRQ line
gets deregistered for some amount of time while the hw still produces an
interrupt. (it might also be an irqd bug, but all seems to be functional
and i have no problems using the serial console.)

so unless you see some instability later on (or see a large flood of
such messages), you can disregard this warning.

	Ingo
