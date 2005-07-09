Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261218AbVGIMAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbVGIMAR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 08:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbVGIMAC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 08:00:02 -0400
Received: from mx1.elte.hu ([157.181.1.137]:20879 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261218AbVGIL6g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 07:58:36 -0400
Date: Sat, 9 Jul 2005 13:58:18 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Message-ID: <20050709115817.GA4665@elte.hu>
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <200507081938.27815.s0348365@sms.ed.ac.uk> <20050708194827.GA22536@elte.hu> <200507082145.08877.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507082145.08877.s0348365@sms.ed.ac.uk>
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


* Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:

> Got this (slightly better) oops. Figured out how to use my camera :-)
> 
> http://devzero.co.uk/~alistair/oops6.jpeg

this was a bit more useful - shows a softirq wakeup. Could you send me 
your vmlinux (bzip -9 compressed, via private mail), your gcc generates 
a slightly different code layout so i couldnt match up everything that 
might be useful.

> Onto your stack-footprint metric. I don't know what the number means, 
> but at a guess it's the size of the stack. Unfortunately, if this is 
> the case, it's unlikely to be an overflow causing the crash. Here's a 
> grep of dmesg just before the crash.

it could still be near an overflow. To make sure i've changed the oops 
printout to also include the current stack left, and the worst-case 
stack-left value, and have uploaded the -51-18 kernel - could you try 
it? That way we can tell for sure. (note that the maximum-tracker can 
not always do an immediate printout of a worst-case - we have to skip 
printouts if irqs are disabled. [or we could recurse from within the 
scheduler or the printk code] Even in those cases we save the worst-case 
stack and print it out as soon as interrupts are enabled again. (The 
worst-case stack-left value printed out at oops time is immediate.)

	Ingo
