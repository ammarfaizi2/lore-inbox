Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261466AbULAWGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbULAWGK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 17:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261469AbULAWGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 17:06:10 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:5504
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S261466AbULAWGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 17:06:09 -0500
Subject: Re: [PATCH] oom killer (Core)
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20041201211638.GB4530@dualathlon.random>
References: <20041201104820.1.patchmail@tglx>
	 <20041201211638.GB4530@dualathlon.random>
Content-Type: text/plain
Date: Wed, 01 Dec 2004 23:06:07 +0100
Message-Id: <1101938767.13353.62.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-01 at 22:16 +0100, Andrea Arcangeli wrote:
> On Wed, Dec 01, 2004 at 10:49:03AM +0100, tglx@linutronix.de wrote:
> > It gets invoked multiple times [..]
> 
> You didn't move the invocation in page_alloc.c which is the major bug I
> can see (besides the other hacks in oom_kill.c). I'd try fixing the
> major bug first.

Where do you want to move it ? 

I don't buy that moving the invocation to any place will solve the
problem of multiple invocations.

The multiple invocations happen with SMP and UP + PREEMPT, when the lock
is dropped in out_of_memory()

	spin_unlock(&oom_lock);
	oom_kill();
	spin_lock(&oom_lock);

How does moving the invocation change this ? 

tglx




