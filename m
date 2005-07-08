Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262792AbVGHT2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262792AbVGHT2e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 15:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262790AbVGHT14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 15:27:56 -0400
Received: from mx2.elte.hu ([157.181.151.9]:20133 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262798AbVGHTZu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 15:25:50 -0400
Date: Fri, 8 Jul 2005 21:25:55 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Message-ID: <20050708192555.GB6503@elte.hu>
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <200507081047.07643.s0348365@sms.ed.ac.uk> <20050708114642.GA10379@elte.hu> <200507081938.27815.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507081938.27815.s0348365@sms.ed.ac.uk>
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

> > | new stack-footprint maximum: smartd/1747, 1768 bytes.

> Unfortunately I see nothing like this when the machine crashes. Find 
> attached my config, which has CONFIG_4KSTACKS and the options you 
> specified. Are you sure this is sufficient to enable it?

do you have any such messages in the syslog? You should be getting a 
bunch of them during bootup.

> Here is an extremely bad digital camera pic from the crash. My 
> debugging prowess has evolved to the stage where by I'm using a 
> maximum res vesafb console.
> 
> However, I'm not at work so it's my own digital camera that I'm using 
> rather than work's, and it seems to react badly to the LCD. I hope you 
> can read the numbers, if not I'll try to transliterate them for you.
> 
> http://devzero.co.uk/~alistair/oops5.jpeg

yeah, i could decypher it - it's a rare type of crash which too signals 
some sort of stack trouble. But it's not necessarily a stack overflow - 
e.g. the process name that is printed (openvpn) is correct, which means 
the kernel could find the right thread_info (which lies on the bottom of 
the stack). So it could be some other type of stack corruption. To debug 
this even more, there's this line in kernel/latency.c:

//#define DEBUG_STACK_POISON

could you enable it by uncommenting the line? Does that make the crash 
any more informative? (Note that runtime stack poisoning is extremely 
expensive (we clear 128 bytes of stack for every function call), so if 
it doesnt have any impact then turn it off. That's the reason why i'm 
not offering the option even over a .config flag.)

	Ingo
