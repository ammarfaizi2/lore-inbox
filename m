Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbTJMMaI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 08:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbTJMMaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 08:30:08 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:17562 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261705AbTJMMaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 08:30:02 -0400
Subject: Re: [RFC][PATCH] Kernel thread signal handling.
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20031013051149.29da705a.akpm@osdl.org>
References: <1066041096.24015.431.camel@hades.cambridge.redhat.com>
	 <20031013040219.6ad71a57.akpm@osdl.org>
	 <1066044079.24015.442.camel@hades.cambridge.redhat.com>
	 <20031013044042.23ab7f69.akpm@osdl.org>
	 <1066046102.14783.11.camel@hades.cambridge.redhat.com>
	 <20031013051149.29da705a.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1066048200.14783.25.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-2.dwmw2.3) 
Date: Mon, 13 Oct 2003 13:30:00 +0100
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: dwmw2@infradead.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <dwmw2@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-10-13 at 05:11 -0700, Andrew Morton wrote:
> > 	daemonize("jffs2_gcd_mtd%d", c->mtd->index);
> 
> And then what?  Parse the output of ps(1)?  Use pidof(8)?

Those work. 

> Insufficient contrition detected :)

Hehe.

> Why cannot a procfs or sysfs control be used?

Mostly because I think that idea sucks, and partly because I think your
ire is misdirected -- it shouldn't be directed at kernel code which
handles signals, but rather at kernel code which sleeps in state
TASK_INTERRUPTIBLE but _doesn't_ handle signals.

On the other hand, if you ever find people actually trying to pass
_data_ to kernel threads with sys_rt_sigqueueinfo(), I'll be right
behind you with my own baseball bat waiting to bash the pieces you leave
behind :)

-- 
dwmw2

