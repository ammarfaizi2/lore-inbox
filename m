Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbUKMXi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbUKMXi1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 18:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbUKMXi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 18:38:27 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:6016
	"EHLO x30.random") by vger.kernel.org with ESMTP id S261212AbUKMXhd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 18:37:33 -0500
Date: Sun, 14 Nov 2004 00:37:40 +0100
From: Andrea Arcangeli <andrea@novell.com>
To: Chris Ross <chris@tebibyte.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Nick Piggin <piggin@cyberone.com.au>, Rik van Riel <riel@redhat.com>,
       Martin MOKREJ? <mmokrejs@ribosome.natur.cuni.cz>, tglx@linutronix.de
Subject: Re: [PATCH] fix spurious OOM kills
Message-ID: <20041113233740.GA4121@x30.random>
References: <20041111112922.GA15948@logos.cnet> <4193E056.6070100@tebibyte.org> <4194EA45.90800@tebibyte.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4194EA45.90800@tebibyte.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2004 at 05:52:21PM +0100, Chris Ross wrote:
> 
> 
> Chris Ross escreveu:
> >It seems good.
> 
> Sorry Marcelo, I spoke to soon. The oom killer still goes haywire even 
> with your new patch. I even got this one whilst the machine was booting!

On monday I'll make a patch to place the oom killer at the right place.

Marcelo's argument that kswapd is a localized place isn't sound to me,
kswapd is still racing against all other task contexts, so if the task
context isn't reliable, there's no reason why kswapd should be more
reliable than the task context. the trick is to check the _right_
watermarks before invoking the oom killer, it's not about racing against
each other, 2.6 is buggy in not checking the watermarks. Moving the oom
killer in kswapd can only make thing worse, fix is simple, and it's the
opposite thing: move the oom killer up the stack outside vmscan.c.
