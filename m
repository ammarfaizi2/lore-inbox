Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261889AbVFLG6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbVFLG6Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 02:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbVFLG6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 02:58:16 -0400
Received: from mx2.elte.hu ([157.181.151.9]:30915 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261889AbVFLG6N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 02:58:13 -0400
Date: Sun, 12 Jun 2005 08:57:33 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Walker <dwalker@mvista.com>, Esben Nielsen <simlo@phys.au.dk>,
       linux-kernel@vger.kernel.org, sdietrich@mvista.com
Subject: Re: [PATCH] local_irq_disable removal
Message-ID: <20050612065733.GA6997@elte.hu>
References: <Pine.LNX.4.44.0506111345400.12084-100000@dhcp153.mvista.com> <1118533485.13312.91.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118533485.13312.91.camel@tglx.tec.linutronix.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Sat, 2005-06-11 at 13:51 -0700, Daniel Walker wrote:
> > On Sat, 11 Jun 2005, Ingo Molnar wrote:
> 
> > Interesting .. So "cli" takes 7 cycles , "sti" takes 7 cycles. The current 
> > method does "lea" which takes 1 cycle, and "or" which takes 1 cycle. I'm 
> > not sure if there is any function call overhead .. So the soft replacment 
> > of cli/sti is 70% faster on a per instruction level .. So it's at least 
> > not any slower .. Does everyone agree on that?
> 
> No, because x86 is not the whole universe

x86 is actually a 'worst-case', because it has one of the cheapest CPU 
level cli/sti implementations. Usually it's the hard-local_irq_disable() 
overhead on non-x86 platforms that is a problem. (ARM iirc) So in this 
sense the soft-flag should be a win on most sane architectures.

	Ingo
