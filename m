Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbVEOOBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbVEOOBQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 10:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261633AbVEOOBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 10:01:16 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:1043 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261602AbVEOOBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 10:01:07 -0400
Date: Sun, 15 May 2005 15:01:03 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andi Kleen <ak@muc.de>
Cc: Dave Jones <davej@redhat.com>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: tickle nmi watchdog whilst doing serial writes.
Message-ID: <20050515150103.B29619@flint.arm.linux.org.uk>
Mail-Followup-To: Andi Kleen <ak@muc.de>, Dave Jones <davej@redhat.com>,
	akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20050513184806.GA24166@redhat.com> <m1u0l4afdx.fsf@muc.de> <20050515130742.A29619@flint.arm.linux.org.uk> <m1ekc8adfl.fsf@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m1ekc8adfl.fsf@muc.de>; from ak@muc.de on Sun, May 15, 2005 at 02:20:14PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 15, 2005 at 02:20:14PM +0200, Andi Kleen wrote:
> Then someone needs to convince Linus to export touch_nmi_watchdog
> again. 
> 
> Or how about checking if interrupts are off here (iirc we have 
> a generic function for that now) and then using
> a smaller timeout and otherwise schedule_timeout() ?

The interrupt state doesn't tell us whether we can schedule.  It
tells us when we can't schedule, which is different from when we
can.  For example:

	spin_lock(foo_lock);
	...
	printk("blah blah blah\n");
	...
	spin_unlock(foo_lock);

This context is non-preemptable, but doesn't have IRQs disabled.
The solution would be to keep a "spinlock depth" counter, but
obviously that's not a possibility.

I would agree that the most correct thing to do would be to export
touch_nmi_watchdog()... if only Linus would accept the arguments
_for_ exporting it.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
