Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751468AbWIYVmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbWIYVmV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 17:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbWIYVmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 17:42:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46728 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751468AbWIYVmU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 17:42:20 -0400
Date: Mon, 25 Sep 2006 14:42:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Daniel Walker <dwalker@mvista.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] console: console_drivers not initialized
Message-Id: <20060925144204.e71c2423.akpm@osdl.org>
In-Reply-To: <1159219581.3648.10.camel@c-67-180-230-165.hsd1.ca.comcast.net>
References: <20060925210710.931336000@mvista.com>
	<20060925211122.GC25257@flint.arm.linux.org.uk>
	<1159219581.3648.10.camel@c-67-180-230-165.hsd1.ca.comcast.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sep 2006 14:26:21 -0700
Daniel Walker <dwalker@mvista.com> wrote:

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
> It happens on two different compilers gcc 4.1 and 3.3 .. I was using
> arch/powerpc/ which is fairly new .. However, If stuff was suppose to be
> zero'd and wasn't, I'd imagine this machine would be rebooting _a lot_
> more often.
> 

What Russell said.  If the arch startup code isn't correctly zeroing bss
then that's pretty badly busted.

The other possibility is that something is accidentally overwriting this
variable.  The explicit initialisation will cause the compiler to move this
variable into a different linker section, so now some other variable will
be getting corrupted.

