Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbTINOwu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 10:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbTINOwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 10:52:50 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:2834 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261167AbTINOws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 10:52:48 -0400
Date: Sun, 14 Sep 2003 15:52:45 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] add a config option for -Os compilation
Message-ID: <20030914155245.A675@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@fs.tum.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20030914121655.GS27368@fs.tum.de> <20030914133349.A27870@flint.arm.linux.org.uk> <20030914132143.GT27368@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030914132143.GT27368@fs.tum.de>; from bunk@fs.tum.de on Sun, Sep 14, 2003 at 03:21:43PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 14, 2003 at 03:21:43PM +0200, Adrian Bunk wrote:
> On Sun, Sep 14, 2003 at 01:33:49PM +0100, Russell King wrote:
> > On Sun, Sep 14, 2003 at 02:16:56PM +0200, Adrian Bunk wrote:
> > > The patch below adds a config option OPTIMIZE_FOR_SIZE for telling gcc 
> > > to use -Os instead of -O2. Besides this, it removes constructs on 
> > > architectures that had a -Os hardcoded in their Makefiles.
> > 
> > I'd rather retain the -Os default for ARM please.  (The init/Kconfig
> > defaults it to 'n' for everything.)
> 
> Below is the patch with the ARM part omitted.

But it doesn't make sense - you include a generic configuration option
which people will see, yet it makes no effect on ARM - seems to be rather
silly putting it there in the first place.

Also, do users particularly care what -Os and -O2 mean?

Maybe you need to change init/Kconfig to be something like the following,
and reinstate the change to the ARM makefile:

config OPTIMIZE_FOR_SIZE
	bool "Optimize for size" if EXPERIMENTAL
	default n if !ARM
	default y if ARM
	help
	  Enabling this option will cause the compiler to reduce the code
	  size of the kernel by disabling certain optimisations.  However,
	  the resulting kernel may run faster due to more efficient
	  cache utilisation.

	  If unsure, say N.

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Linux kernel maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core
