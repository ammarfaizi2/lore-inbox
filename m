Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbTDDVCf (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 16:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbTDDVCe (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 16:02:34 -0500
Received: from chaos.analogic.com ([204.178.40.224]:7553 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261282AbTDDVCd (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 16:02:33 -0500
Date: Fri, 4 Apr 2003 16:17:05 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Stephen Cameron <steve.cameron@hp.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: How to speed up building of modules?
In-Reply-To: <20030404085740.GA10052@zuul.cca.cpqcorp.net>
Message-ID: <Pine.LNX.4.53.0304041601100.5000@chaos>
References: <20030404085740.GA10052@zuul.cca.cpqcorp.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Apr 2003, Stephen Cameron wrote:

> Hi
>
> I'm wondering if you guys know any tricks to speed up building
> of linux kernel modules.
>
> First, some background.
>
> We have to put out binary HBA driver modules for a variety
> of linux distributions for things like driver diskettes, to allow
> new drivers to be used during initial install.  (I'm thinking
> of the cciss, cpqarray and cpqfc drivers.)
>
> With all the distributions, and differnent
> offerings of distributions, and errata kernels... today, I count
> almost 40 distinct kernels we're trying to support, not counting the
> mainline development on kernel.org, and not counting multiple
> config file variations for each of those 40 or so kernels.
>
> The main catch seems to be the symbol checksums.  In order for those
> to match (and I'm not too interested in subverting those), the
> config files used during the compile need to be very similar.  That
> means building lots and lots of modules.  (Think about all the
> modules which are enabled in redhat's typical default config files.)
> This takes time.  Mulitply 3 drivers * ~40 kernels * several config
> files, and pretty soon... well, pretty soon you don't remember
> what "preety soon" means.
>
> It would be VERY nice if I could find a way to build only the modules
> I care about  and not all the rest, which add hours and hours.
> It seems that some things in the config file can be turned off without
> harm, but it's not clear how I can know whether it's safe to turn a module
> off  Also, sometimes I need to make changes to the Config.in files,
> add options, etc.  Ccache hasn't helped.  (I think because the different
> config files use different compiler flags, and otherwise the kernels
> just aren't the same.)
>
> Any ideas?
>
> Thanks,
>
> -- steve

You can create a Makefile to make only the modules you want.
All you need exists in a kernel tree that has (once) been configured
to build, at least, the modules that you want. It is trivial.
You have to remember to -DMODULE as well as -D__KERNEL__ as a
'C' compile parameter along with the other stuff on the command-line.

Understand that when somebody is designing a module, they just
build it in their own directory but, using -I on the command-line
make sure that the correct kernel headers are used (like
-I/usr/src/linux-2.4.20/include -I.).

So, a typical compile-command for a module would be to define the
correct includes and defines as CFLAGS, export those parameters, then
do make -C drivers/net 3x59x.o from inside your Makefile (to do the
3x59x.o module (it requires mii.o also).


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

