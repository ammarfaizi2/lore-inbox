Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266902AbUGMVwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266902AbUGMVwN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 17:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266478AbUGMVwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 17:52:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:21933 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266898AbUGMVwB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 17:52:01 -0400
Date: Tue, 13 Jul 2004 14:54:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: paul@linuxaudiosystems.com, rlrevell@joe-job.com,
       linux-audio-dev@music.columbia.edu, mingo@elte.hu, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel
 Preemption Patch
Message-Id: <20040713145424.1217b67f.akpm@osdl.org>
In-Reply-To: <20040713213847.GH974@dualathlon.random>
References: <20040712163141.31ef1ad6.akpm@osdl.org>
	<200407130001.i6D01pkJ003489@localhost.localdomain>
	<20040712170844.6bd01712.akpm@osdl.org>
	<20040713162539.GD974@dualathlon.random>
	<20040713114829.705b9607.akpm@osdl.org>
	<20040713213847.GH974@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> On Tue, Jul 13, 2004 at 11:48:29AM -0700, Andrew Morton wrote:
> > sys_sched_yield() also calls schedule() with local interrupts disabled. 
> > It's a bit grubby, but saves a few cycles.  Nick and Ingo prefer it that way.
> 
> we can remove the irqs_disabled() check in might_sleep then, I'd like to
> call might_sleep from cond_resched.

Confused.  Where do we call cond_resched() with local interrupts disabled?

Sleeping with local interrupts disabled is usually a bug, so we should prefer
to keep that check in might_sleep().
