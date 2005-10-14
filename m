Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbVJNJ5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbVJNJ5L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 05:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750703AbVJNJ5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 05:57:11 -0400
Received: from mail.suse.de ([195.135.220.2]:21996 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750701AbVJNJ5K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 05:57:10 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: lkml <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, dwalker@mvista.com,
       david singleton <dsingleton@mvista.com>
Subject: Re: 2.6.14-rc4-rt1
References: <20051011111454.GA15504@elte.hu>
	<1129135337.21743.11.camel@localhost.localdomain>
	<20051014062212.GA30874@elte.hu>
From: Andi Kleen <ak@suse.de>
Date: 14 Oct 2005 11:57:02 +0200
In-Reply-To: <20051014062212.GA30874@elte.hu>
Message-ID: <p73r7aos9ox.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> * Badari Pulavarty <pbadari@gmail.com> wrote:
> 
> > Hi Ingo,
> > 
> > 
> > I am getting similar segfault on boot problem on 2.6.14-rc4-rt1 on my 
> > x86-64 box (with LATENCY_TRACE).
> 
> > INIT: version 2.86 booting
> > hotplug[877]: segfault at ffffffff8010f588 rip ffffffff8010f588 rsp
> > 00007fffff8bee68 error 15
> 
> what does the ffffffff8010f588 RIP address map to? You can find out by 

It could be any kernel address that someone injected into user space.
Most likely some problem with the vsyscall page with either signal
handling or gettimeofday. vsyscall code is tricky to hack because you
cannot add any new functions there, just inlines, otherwise the code
won't end up the right section.

-Andi
