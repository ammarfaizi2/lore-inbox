Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264500AbUGMAK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264500AbUGMAK0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 20:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264492AbUGMAKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 20:10:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:65249 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264461AbUGMAKF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 20:10:05 -0400
Date: Mon, 12 Jul 2004 17:08:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: rlrevell@joe-job.com, linux-audio-dev@music.columbia.edu, mingo@elte.hu,
       arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel
 Preemption Patch
Message-Id: <20040712170844.6bd01712.akpm@osdl.org>
In-Reply-To: <200407130001.i6D01pkJ003489@localhost.localdomain>
References: <20040712163141.31ef1ad6.akpm@osdl.org>
	<200407130001.i6D01pkJ003489@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Davis <paul@linuxaudiosystems.com> wrote:
>
> >OK, thanks.  The problem areas there are the timer-based route cache
> >flushing and reiserfs.
> >
> >We can probably fix the route caceh thing by rescheduling the timer after
> >having handled 1000 routes or whatever, although I do wonder if this is a
> >thing we really need to bother about - what else was that machine up to?
> 
> i have one concern about this that i talked to takashi about when we
> were in bordeaux. it seems to me that the ALSA xrun debug stuff is
> measuring things when the interrupt handler for the ALSA device
> executes and detects an xrun. if the handler itself was delayed, then
> the stack trace for its execution doesn't or might not show what
> caused the delay. this means, perhaps, that we need to be rather
> careful interpreting these traces.
> 

We can usually tell that from the trace.  If it points up into a busy piece
of code then it's pretty obvious what's happening.  If the trace is due to
a long irq-off time then it will point up into the offending
local_irq_enable().

