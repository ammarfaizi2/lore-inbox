Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261954AbVEEV4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261954AbVEEV4T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 17:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbVEEV4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 17:56:19 -0400
Received: from h-64-105-159-118.phlapafg.covad.net ([64.105.159.118]:51340
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S261954AbVEEV4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 17:56:12 -0400
Subject: Re: [PATCH] Saving ARCH and CROSS_COMPILE in generated Makefile
From: Pavel Roskin <proski@gnu.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux <linux-kernel@vger.kernel.org>
In-Reply-To: <20050505212003.GA16877@mars.ravnborg.org>
References: <1115248267.12758.21.camel@dv.roinet.com>
	 <20050504232338.GF18977@parcelfarce.linux.theplanet.co.uk>
	 <1115263105.17646.1.camel@dv.roinet.com>
	 <20050505212003.GA16877@mars.ravnborg.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 05 May 2005 17:56:11 -0400
Message-Id: <1115330171.3838.24.camel@dv.roinet.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-05 at 23:20 +0200, Sam Ravnborg wrote:
>  > > In any case, there's no reason to mess with that at all.  This stuff is
> > > trivally dealt with by a wrapper script that takes target name as its
> > > first argument (the rest is passed to make unchanged) and figures out
> > > ARCH, CROSS_COMPILE, SUBARCH and build directory by it.  End of story.
> > 
> > I'm using such script now.  It's called kmake.
> 
> Use a Makefile called either makefile or GNUMakefile to call make with
> correct arguments. No kmake script required.
> And no difference in behaviour using O= or not.
> You could teach kmake to create such a file if not present.

Or we could teach scripts/mkmakefile to do it for all of us.  I can post
a patch that would call scripts/mkmakefile regardless of whether O= is
used, and scripts/mkmakefile would generate makefile rather than
Makefile.

> > I keep forgetting to run
> > kmake instead of make, so it's an annoyance for me (usually it end up
> > with a full screen of error messages, but I'm afraid I could get a mix
> > of object files for different architectures in some cases).
> 
> Nope. .o files are rebuild if commandline changes. This works well.
> This works so well that when you change name of gcc you have to rebuild
> the kernel - no matter the arguments used.
> It amy be a shift from gcc 2.96 to gcc 4.0.

Good to know.  But my point still stands.

If I have a build tree already compiled for a specific architecture, and
I'm going to compile an external driver against that tree, why do I need
to set ARCH and CROSS_COMPILE to match those used during compilation?
Why cannot the build system do it for me?

Also, if I want to recompile the kernel after changing the source, I
want to run make in the build tree.  That's what the generated Makefile
is for.  But if I overrode ARCH or CROSS_COMPILE, I have to remember to
do it again.  And that's what I want to fix.

I'm sure I can write a very intelligent script tuned for my system that
would do the right thing and that will even set CROSS_COMPILE based on
the architecture from .config file.  But I want to share my code, not to
hoard it.

Maybe I should try to implement saving ARCH and CROSS_COMPILE in .config
file, but it would be more intrusive.

-- 
Regards,
Pavel Roskin

