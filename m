Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269608AbUICKbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269608AbUICKbN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 06:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269595AbUICKbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 06:31:12 -0400
Received: from mx1.elte.hu ([157.181.1.137]:56203 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S269605AbUICKaC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 06:30:02 -0400
Date: Fri, 3 Sep 2004 12:29:48 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Luke Yelavich <luke@audioslack.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Free Ekanayaka <free@agnula.org>,
       Eric St-Laurent <ericstl34@sympatico.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Mark_H_Johnson@raytheon.com,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>,
       nando@ccrma.stanford.edu, free78@tin.it
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R1
Message-ID: <20040903102948.GA23726@elte.hu>
References: <1094181447.4815.6.camel@orbiter> <1094192788.19760.47.camel@krustophenia.net> <20040903063658.GA11801@elte.hu> <1094194157.19760.71.camel@krustophenia.net> <20040903070500.GB13100@elte.hu> <1094197233.19760.115.camel@krustophenia.net> <87acw7bxkh.fsf@agnula.org> <1094198755.19760.133.camel@krustophenia.net> <20040903092547.GA18594@elte.hu> <20040903095031.GA22607@luke-laptop.yelavich.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040903095031.GA22607@luke-laptop.yelavich.home>
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


* Luke Yelavich <luke@audioslack.com> wrote:

> I think I might be having a problem here, that I didn't have with
> previous patches. Bare in mind that the previous patch I tested was
> against 2.6.8.1 vanilla.
> 
> I am using a D-Link KVM here between my notebook and my desktop
> machine. It is the desktop I am currently testing these patches on,
> and the KVM requires a double-tap of the scroll lock key to switch
> between machines. With the latest R0 patch, something is not working
> when I attempt to change from my desktop to my notebook. The KVM
> usually lets out a beep when I can use the arrow keys to switch, but
> it isn't here. Adding to that, my console locks up totally for about
> 10 seconds, before allowing me to go on and type commands. [...]

i have a KVM too to two testsystems and unfortunately i cannot reproduce
your problems neither with KVM (key-based-)switching nor with scroll
lock. But this KVM uses a triple-key combination to switch, not
scroll-lock.

it's a PS2 keyboard, right? If yes then does:

	echo 0 > /proc/irq/1/i8042/threaded
	( maybe also: echo 0 > /proc/irq/12/i8042/threaded )

fix the problem? The PS2 driver has been a bit unrobust when hardirq
redirection is enabled.

> [...] I also seem to get some debugging output or a trace of some sort
> when rebooting, and the kernel panics with the message: (0)Kernel
> Panic - not syncing: Failed exception in interrupt

hm. Would be nice to get a serial console capture of this, if possible.

	Ingo
