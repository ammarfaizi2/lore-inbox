Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbWIJXDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbWIJXDx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 19:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964803AbWIJXDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 19:03:53 -0400
Received: from gw.goop.org ([64.81.55.164]:24472 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S964802AbWIJXDx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 19:03:53 -0400
Message-ID: <450499D3.5010903@goop.org>
Date: Sun, 10 Sep 2006 16:03:47 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060907)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>,
       Laurent Riffard <laurent.riffard@free.fr>,
       Arjan van de Ven <arjan@infradead.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Jeremy Fitzhardinge <jeremy@xensource.com>
Subject: Re: 2.6.18-rc6-mm1: GPF loop on early boot
References: <20060908011317.6cb0495a.akpm@osdl.org>	<200609101032.17429.ak@suse.de>	<20060910115722.GA15356@elte.hu>	<200609101334.34867.ak@suse.de>	<20060910132614.GA29423@elte.hu> <20060910093307.a011b16f.akpm@osdl.org>
In-Reply-To: <20060910093307.a011b16f.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> I must say that having an unreliable early-current is going to be quite a
> pita for evermore.  Things like mcount-based tricks and
> basic-block-profiling-based tricks, for example.
>
> Is it really going to be too messy to fake up some statically-defined gdt
> which points at init_task, install that before we call any C at all?

That's on my TODO list - make %gs set correctly before hitting C code, 
and get rid of all the early_* stuff.  I had already encountered a 
PDA-related oops with lockdep enabled, and addressed it.

It's pretty easy to solve in general for the boot CPU, but its a bit 
more tricky to handle for secondary CPUs.

Laurent, could you resend your original oops?  It doesn't seem to have 
appeared on lkml.

In the meantime, I'll work on a proper fix for this.

    J
