Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289756AbSAKL5u>; Fri, 11 Jan 2002 06:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289919AbSAKL5l>; Fri, 11 Jan 2002 06:57:41 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:19464 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S289756AbSAKL5Y>; Fri, 11 Jan 2002 06:57:24 -0500
Date: Fri, 11 Jan 2002 11:57:17 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] O(1) scheduler, -H5
Message-ID: <20020111115717.A30965@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.33.0201110130290.11478-100000@localhost.localdomain.suse.lists.linux.kernel> <20020111113131.C30756@flint.arm.linux.org.uk.suse.lists.linux.kernel> <p73zo3lnmg9.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <p73zo3lnmg9.fsf@oldwotan.suse.de>; from ak@suse.de on Fri, Jan 11, 2002 at 12:42:14PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2002 at 12:42:14PM +0100, Andi Kleen wrote:
> When they hold the kernel lock in addition to the global cli() before
> schedule() it should be ok. Only the behaviour of code not holding
> kernel lock but global cli and calling schedule() has changed.

Agreed, however, there is one thing that has bugged me for a long time
(and which I believe is causing someone a problem at the moment) - when
we shut down a port, we're holding the BKL, and have global IRQs disabled.
We unhook the port from the serial drivers chain, and maybe free and
reclaim the IRQ with a different handler, and then disable the IRQ from
the port in question.

If we happen to schedule within request_irq, it doesn't take too much
imagination to see that Bad Things can happen.

(There is a report of complete lockup, and re-ordering stuff around here
fixes the problem, but the example patch changed a number of things, and
I'm trying to work towards a proper solution).

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

