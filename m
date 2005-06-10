Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262603AbVFJQbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262603AbVFJQbQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 12:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbVFJQbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 12:31:16 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:45071 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262603AbVFJQbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 12:31:08 -0400
Date: Fri, 10 Jun 2005 17:30:58 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Adam Belay <ambx1@neo.rr.com>,
       matthieu castet <castet.matthieu@free.fr>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: PNP parallel&serial ports: module reload fails (2.6.11)?
Message-ID: <20050610173058.C18927@flint.arm.linux.org.uk>
Mail-Followup-To: Bjorn Helgaas <bjorn.helgaas@hp.com>,
	Michael Tokarev <mjt@tls.msk.ru>, Adam Belay <ambx1@neo.rr.com>,
	matthieu castet <castet.matthieu@free.fr>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050602222400.GA8083@mut38-1-82-67-62-65.fbx.proxad.net> <42A8AFA5.3090703@tls.msk.ru> <20050609221657.C14513@flint.arm.linux.org.uk> <200506101001.40980.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200506101001.40980.bjorn.helgaas@hp.com>; from bjorn.helgaas@hp.com on Fri, Jun 10, 2005 at 10:01:40AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2005 at 10:01:40AM -0600, Bjorn Helgaas wrote:
> On Thursday 09 June 2005 3:16 pm, Russell King wrote:
> > The reason that 8250 first detects your ports is that they're found
> > via the legacy method which is independent of PnP.  As you correctly
> > sumise, when you unload 8250_pnp, it disables the device so when you
> > re-load 8250, it's unable to detect your ports using the legacy method.
> > 
> > But the legacy method needs to continue to exist for systems which
> > don't have PnP enabled.
> 
> But shouldn't we someday move the legacy probing from 8250
> into an 8250_platform and only do it if we don't have 8250_pnp?

The structure's already there.  The biggest problem is the amount of
shere work there is to fix all the bloody architectures and drivers
which make use of random crap from asm/serial.h and friends.

I feel very much like I'm working on serial all by myself, especially
when asking arch people to do things results in silence.

So shrug - I've put in the ground work.  ARM's up to date in so much
as it doesn't use asm/serial.h at all anymore.  The other architectures
now need to follow suit.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
