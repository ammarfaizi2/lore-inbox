Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbTL1Rq2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 12:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbTL1Rq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 12:46:28 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:60682 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261799AbTL1Rq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 12:46:26 -0500
Date: Sun, 28 Dec 2003 17:46:22 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>
Subject: Re: 2.6.0-test6: APM unable to suspend (the 2.6.0-test2 saga continues)
Message-ID: <20031228174622.A20278@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@redhat.com>
References: <20031005171055.A21478@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031005171055.A21478@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Sun, Oct 05, 2003 at 05:10:55PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 05, 2003 at 05:10:55PM +0100, Russell King wrote:
> On Sun, Aug 17, 2003 at 05:23:10PM +0100, Russell King wrote:
> > The kernel test setup consists of booting a kernel with init=/bin/sh,
> > and after the shell prompt appears, hitting the BIOS-magic "suspend to
> > RAM" key combination.
> 
> I've just re-tested this with 2.6.0-test6, and the problem persists.
> Red Hat 2.4.20-20.7smp works fine.
> 
> I'm booting both 2.4 and 2.6 kernels with: init=/bin/sh apm=debug
> without starting any daemons, or having any PCMCIA socket drivers
> loaded.  apm debug messages appear to be identical between 2.4 and
> 2.6 kernels.
> 
> On Mon, Aug 11, 2003 at 10:50:39PM +1000, Stephen Rothwell wrote:
> > The error logged by the apm driver indicates an error from the BIOS. So
> > the BIOS thinks the machine is in a state that it cannot suspend from.
> 
> If that is so, how do we go about debugging this type of problem?
> I've tried the obvious of disabling virtually all drivers, and this
> doesn't appear to make any difference what so ever.  I'm guessing
> that something in the core i386 architecture code is causing the
> problem.

Alan Cox has shed some light on this problem.  He mentions that the
x86 GDT/LDT stuff changed around 2.5.30, which is the time when others
have also reported that their APM has stopped working.  I've not
confirmed whether that is the case for me as well, but it seems to
be highly likely.

I also asked Alan if there's the possibility of backing this out or
making it configurable, but the answer seems to be a most definite
no.  However, maybe Ingo can say otherwise?

This effectively means that people with laptops which do not work
with 2.6 APM nor ACPI can expect their machines to be stuck with 2.4
for the future, unless someone with the necessary knowledge sees this
problem as important enough to solve.

It also means that I'm never going to be able to test PCMCIA suspend
under real conditions with the hardware I have available to me.  This
in turn brings up the question of passing PCMCIA off to someone else
to maintain and test for 2.6.  However, I remain willing to continue
the development, albiet limited by the working hardware I have
available to me.

Do we have any willing volunteers?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
