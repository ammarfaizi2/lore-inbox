Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275573AbRJFTdr>; Sat, 6 Oct 2001 15:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275576AbRJFTdg>; Sat, 6 Oct 2001 15:33:36 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:8759 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S275573AbRJFTdX>; Sat, 6 Oct 2001 15:33:23 -0400
To: Thomas Hood <jdthood@mail.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux should not set the "PnP OS" boot flag
In-Reply-To: <1002339356.814.45.camel@thanatos>
From: ebiederman@uswest.net (Eric W. Biederman)
Date: 06 Oct 2001 13:24:08 -0600
In-Reply-To: <1002339356.814.45.camel@thanatos>
Message-ID: <m1bsjky3l3.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Hood <jdthood@mail.com> writes:

> My problem was: After running a recent 2.4.x kernel, on a subsequent
> boot of Linux, all configurable devices (internal modem, audio chip,
> parallel, serial and IR ports) were disabled.  This would causes
> oopses in my sound device drivers.
> 
> My workarounds were:
> (1) to reinitialize the BIOS prior to booting, or,
> (2) to run "setpnp on" on all the configurable devices early in
>     the boot sequence.
> 
> I just now figured out what was going on.  When the PnP BIOS is
> going to boot a non-PnP OS, it configures all configurable devices
> itself.  When the PnP BIOS is going to boot a PnP OS (which it
> tells from a "boot flag") it leaves configurable devices, other
> than those needed to boot the OS, unconfigured.  Recent Linux
> kernels have set the "boot flag" indicating that the OS being booted
> is a PnP OS.
> 
> Unfortunately, Linux isn't really a "PnP OS".  The kernel alone
> doesn't configure the devices.  One has to use setpnp to do that.

Hmm.  Linux isn't quite a "PnP OS".  I agree that in the short
term we should not set the boot flag.  But we should also investigate
what needs to added so that setpnp does not need to be called.

In the normal case the pci subsystem gets this correct, and we need
the logic to get this correct to support hot plug devices.

Do you have any insite into what needs to be done so that the kernel
will automatically configure isa pnp devices?

Eric



