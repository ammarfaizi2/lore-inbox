Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262453AbUEBIR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262453AbUEBIR7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 04:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbUEBIR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 04:17:59 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:61454 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262453AbUEBIR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 04:17:57 -0400
Date: Sun, 2 May 2004 09:17:51 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: vandrove@vc.cvut.cz, cw@f00f.org, koke@amedias.org,
       linux-kernel@vger.kernel.org
Subject: Re: strange delays on console logouts (tty != 1)
Message-ID: <20040502091751.B9605@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, vandrove@vc.cvut.cz,
	cw@f00f.org, koke@amedias.org, linux-kernel@vger.kernel.org
References: <20040430195351.GA1837@amedias.org> <20040501214617.GA6446@taniwha.stupidest.org> <20040501232448.GA4707@vana.vc.cvut.cz> <20040501180347.31f85764.akpm@osdl.org> <20040502090059.A9605@flint.arm.linux.org.uk> <20040502011337.2b0b3ca3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040502011337.2b0b3ca3.akpm@osdl.org>; from akpm@osdl.org on Sun, May 02, 2004 at 01:13:37AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 02, 2004 at 01:13:37AM -0700, Andrew Morton wrote:
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> >
> > On Sat, May 01, 2004 at 06:03:47PM -0700, Andrew Morton wrote:
> > > Petr Vandrovec <vandrove@vc.cvut.cz> wrote:
> > > >
> > > > (2) tty hangup is scheduled for work_queue.
> > > 
> > > This is the problem, isn't it?
> > > 
> > > >From what context is tty_hangup() invoked?  (stick a dump_stack() in there>?)
> > 
> > >From IRQ context.  It's tty_vhangup() which is invoked from user context,
> > and calls do_tty_hangup() synchronously.
> > 
> 
> But Chris and Petr are talking about virtual terminals on the local
> console, are they not?
> 
> If so, how is tty_hangup() getting involved?

The only way it could be invoked is via SAK, which obviously isn't
happening here.

However, login _does_ call sys_vhangup() which in turn calls tty_vhangup()
so I suspect that the statement "tty hangup is scheduled for work_queue"
is based on the _assumption_ that sys_vhangup() calls tty_hangup()
rather than the function it actually does.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
