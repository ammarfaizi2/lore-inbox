Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266211AbUGASHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266211AbUGASHu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 14:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266213AbUGASHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 14:07:50 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:62477 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266211AbUGASH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 14:07:27 -0400
Date: Thu, 1 Jul 2004 19:07:20 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: binutils woes
Message-ID: <20040701190720.C8389@flint.arm.linux.org.uk>
Mail-Followup-To: Tom Rini <trini@kernel.crashing.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
References: <20040701175231.B8389@flint.arm.linux.org.uk> <20040701174731.GD15960@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040701174731.GD15960@smtp.west.cox.net>; from trini@kernel.crashing.org on Thu, Jul 01, 2004 at 10:47:31AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2004 at 10:47:31AM -0700, Tom Rini wrote:
> On Thu, Jul 01, 2004 at 05:52:31PM +0100, Russell King wrote:
> 
> > Hi guys,
> > 
> > On ARM, we appear to have somewhat of a problem with binutils.  At
> > least the following binutils suffer from a problem whereby it is
> > possible to create programs which contain undefined symbols:
> [snip]
> > I think the only way we can ensure kernel correctness is to add a
> > subsequent stage to kbuild such that whenever we generate a final
> > program, we grep the 'nm' output for undefined symbols.
> > 
> > Comments?
> 
> Is there a version of binutils that really does get things right?  If
> so, can't you Just Say No to older versions and force people to upgrade
> (with a simple testcase done upfront) ?

I've just tested:

 GNU assembler 2.15.90 20040409
 Copyright 2002 Free Software Foundation, Inc.
 This program is free software; you may redistribute it under the terms of
 the GNU General Public License.  This program has absolutely no warranty.
 This assembler was configured for a target of `arm-linux'.

and it also is aflicted with the same problem.  I guess the answer
to your question is that currently there are no recent versions which
work correctly.

Looking at the timescale of 2.13 through to present day, we're talking
potentially of 2 years of binutils versions with this problem, and even
if it was fixed tomorrow, I don't think it's acceptable to say "use the
latest binutils version."

Also, I have just received another report that somewhere in the kernel
is an undefined reference to another symbol - I_BIT, but where we have
no idea at present...

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
