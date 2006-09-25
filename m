Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751444AbWIYVak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbWIYVak (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 17:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbWIYVak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 17:30:40 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:14607 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751444AbWIYVaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 17:30:39 -0400
Date: Mon, 25 Sep 2006 22:30:31 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Daniel Walker <dwalker@mvista.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] console: console_drivers not initialized
Message-ID: <20060925213031.GD25257@flint.arm.linux.org.uk>
Mail-Followup-To: Daniel Walker <dwalker@mvista.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20060925210710.931336000@mvista.com> <20060925211122.GC25257@flint.arm.linux.org.uk> <1159219581.3648.10.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159219581.3648.10.camel@c-67-180-230-165.hsd1.ca.comcast.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2006 at 02:26:21PM -0700, Daniel Walker wrote:
> On Mon, 2006-09-25 at 22:11 +0100, Russell King wrote:
> > On Mon, Sep 25, 2006 at 02:07:10PM -0700, dwalker@mvista.com wrote:
> > > I was doing -rt stuff on a PPC PowerBook G4. It would always reboot
> > > itself when it hit console_init() .
> > > 
> > > I noticed that the console code seems to want console_drivers = NULL,
> > > but it never actually sets it that way. Once I added this, the reboot 
> > > issue was gone..
> > 
> > It's a BSS variable, it _should_ be zeroed by the architecture's BSS
> > initialisation.  If not, it suggests there's something very _very_
> > wrong in the architecture's C runtime initialisation code.
> > 
> > As such, this patch is merely a band-aid, not a correct fix.
> 
> It happens on two different compilers gcc 4.1 and 3.3 ..

The zeroing of the BSS is not a function of the compiler, but the C startup
code, which might be written in assembly or c.

> I was using
> arch/powerpc/ which is fairly new .. However, If stuff was suppose to be
> zero'd and wasn't, I'd imagine this machine would be rebooting _a lot_
> more often.

The alternative explaination is that explicitly changing a variable from
the BSS to have an explicit initialisation moves it into the data segment,
which results in quite a bit of data moving around.  So it might not even
be related to this - maybe a data structure alignment issue somewhere?
Shrug - but it's for powerpc folk to investigate.

Suggest you report it to powerpc folk as a bug.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
