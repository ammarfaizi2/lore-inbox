Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266244AbUGATxC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266244AbUGATxC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 15:53:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266253AbUGATxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 15:53:02 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:58895 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266244AbUGATw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 15:52:58 -0400
Date: Thu, 1 Jul 2004 20:52:55 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Martin Schlemmer <azarah@nosferatu.za.org>
Cc: Tom Rini <trini@kernel.crashing.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: binutils woes
Message-ID: <20040701205255.F8389@flint.arm.linux.org.uk>
Mail-Followup-To: Martin Schlemmer <azarah@nosferatu.za.org>,
	Tom Rini <trini@kernel.crashing.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
References: <20040701175231.B8389@flint.arm.linux.org.uk> <20040701174731.GD15960@smtp.west.cox.net> <20040701190720.C8389@flint.arm.linux.org.uk> <1088711048.8875.5.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1088711048.8875.5.camel@nosferatu.lan>; from azarah@nosferatu.za.org on Thu, Jul 01, 2004 at 09:44:10PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2004 at 09:44:10PM +0200, Martin Schlemmer wrote:
> You might try (which should be on any kernel mirror):
> 
> GNU assembler 2.15.91.0.1 20040527
> Copyright 2002 Free Software Foundation, Inc.
> This program is free software; you may redistribute it under the terms of
> the GNU General Public License.  This program has absolutely no warranty.
> This assembler was configured for a target of `i686-pc-linux-gnu'.

I don't think there's any point in trying - I just received a mail
from Nick Clifton who has found the problem in the ARM backend of
GAS and is apparantly in the process of committing it to CVS.

So, all ARM binutils versions from 2002 to date are affected by
the bug.

Whether ld --no-undefined successfully producing binaries with
undefined symbols is a problem or not remains unclear, however.

Even so, we still can not check whether we are actually using a late
enough version of binutils and force kernel build failure on that
basis.  About the best we can do is as I originally suggested which
is to add a postprocessing step after we link a binary object to
ensure there are no undefined symbols remaining.

The alternative is we just say "Sorry, we're not prepared to provide
any form of support for problems reported for ARM builds until the
next stable release of binutils."  Realistically, I don't think
that's an acceptable position to take.

Therefore, unless anyone has any objections, I shall be cooking up
a patch which adds an extra pass to any final object link for the
kernel build system.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
