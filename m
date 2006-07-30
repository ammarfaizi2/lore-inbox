Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750858AbWG3OdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbWG3OdA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 10:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbWG3OdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 10:33:00 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:2009 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750835AbWG3Oc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 10:32:59 -0400
Subject: Re: FP in kernelspace
From: Arjan van de Ven <arjan@infradead.org>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <44CC97A4.8050207@gmail.com>
References: <44CC97A4.8050207@gmail.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 30 Jul 2006 16:32:57 +0200
Message-Id: <1154269977.2941.21.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-30 at 13:27 +0159, Jiri Slaby wrote:
> 
> I have a driver written for 2.4 + RT patches with FP support. I want
> it to work 
> in 2.6. How to implement FP? Has anybody developped some "protocol"
> between KS 
> and US yet? If not, could somebody point me, how to do it the best --
> with low 
> latency.
> The device doesn't generate irqs *), I need to quickly respond to
> timer call, 
> because interval between two posts of data to the device has to be
> equal as much 
> as possible (BTW is there any way how to gain up to 5000Hz).
> I've one idea: have a thread with RT priority and wake the app in US
> waiting in 
> read of character device when timer ticks, post a struct with 2 floats
> and 
> operation and wait in write for the result. App computes, writes the
> result, we 
> are woken and can post it to the device. But I'm afraid it would be
> tooo slow.

real floating point in the kernel is basically no-go; especially if you
enable preemption. The entire floating point exception, context save and
restore engine is designed with the assumption of no kernel space FPU
usage... and there are a LOT of nasty corner cases to deal with... and
so far the kernel decided to cheap out on many of those by just not
allowing kernel FPU use (mmx is easier so that can be dealt with).

Volume 3 of the Intel architecture manuals are a good start if you want
to know what some of these corner cases are...


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

