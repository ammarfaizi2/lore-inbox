Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932444AbWCIQeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbWCIQeJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 11:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbWCIQeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 11:34:08 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:35080 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751186AbWCIQeH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 11:34:07 -0500
Date: Thu, 9 Mar 2006 17:33:45 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Fix scripts/namespace.pl portability
Message-ID: <20060309163345.GA23215@mars.ravnborg.org>
References: <20060309130150.GA10275@linux-mips.org> <20060309154030.GA14682@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060309154030.GA14682@linux-mips.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2006 at 03:40:30PM +0000, Ralf Baechle wrote:
> On Thu, Mar 09, 2006 at 01:01:50PM +0000, Ralf Baechle wrote:
> 
> > scripts/namespace.pl was assuming the nm and objdump tools to use are
> > always just named that which breaks things in a crosscompilation
> > environment.
> > 
> > Fixed by honouring $NM and $OBJDUMP if passed by make, otherwise
> > defaulting to just nm rsp. objdump just as we used to.
> > 
> > Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
> Atsushi Nemoto pointed me to http://lkml.org/lkml/2005/9/20/68.  This
> old patch which seems more complete than mine but made it into the kernel.
>  I just refreshed the patch and added the bits to ensure namespace.pl
> uses the right nm binary also - Keith's original patch only fixed the
> objdump use.
> 
> From: Keith Owens <kaos@ocs.com.au>
> 
> Those scripts are meant to work even when they are invoked by hand,
> without OBJDUMP being defined in the environment.  This is the correct
> fix.

Hi Ralf. In my kbuild tree I have this fixed already:
my $nm = ($ENV{'NM'} || "nm") . " -p";
my $objdump = ($ENV{'OBJDUMP'} || "objdump") . " -s -j .comment";

Patch is from Aaron Brooks.

The reference_init.pl + reference_discarded.pl are subject for removal
since the check has been moved to modpost.

	Sam
