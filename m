Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263148AbTJEQLC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 12:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263149AbTJEQLC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 12:11:02 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:23565 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263148AbTJEQK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 12:10:58 -0400
Date: Sun, 5 Oct 2003 17:10:55 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test6: APM unable to suspend (the 2.6.0-test2 saga continues)
Message-ID: <20031005171055.A21478@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 17, 2003 at 05:23:10PM +0100, Russell King wrote:
> On Wed, Aug 06, 2003 at 11:15:19PM +0100, Russell King wrote:
> > I'm trying to test out APM on my laptop (in order to test some PCMCIA
> > changes), but I'm hitting a brick wall.  I've added the device_suspend()
> > calls for the SAVE_STATE, DISABLE and the corresponding device_resume()
> > calls into apm's suspend() function.  (this is needed so that PCI
> > devices receive their notifications.)
> > 
> > However, APM is refusing to suspend.  I'm seeing the following kernel
> > messages:
> 
> I've just been doing further testing.
> 
> The kernel test setup consists of booting a kernel with init=/bin/sh,
> and after the shell prompt appears, hitting the BIOS-magic "suspend to
> RAM" key combination.

I've just re-tested this with 2.6.0-test6, and the problem persists.
Red Hat 2.4.20-20.7smp works fine.

I'm booting both 2.4 and 2.6 kernels with: init=/bin/sh apm=debug
without starting any daemons, or having any PCMCIA socket drivers
loaded.  apm debug messages appear to be identical between 2.4 and
2.6 kernels.

On Mon, Aug 11, 2003 at 10:50:39PM +1000, Stephen Rothwell wrote:
> The error logged by the apm driver indicates an error from the BIOS. So
> the BIOS thinks the machine is in a state that it cannot suspend from.

If that is so, how do we go about debugging this type of problem?
I've tried the obvious of disabling virtually all drivers, and this
doesn't appear to make any difference what so ever.  I'm guessing
that something in the core i386 architecture code is causing the
problem.

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
      Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
      maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                      2.6 Serial core
