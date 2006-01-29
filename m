Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbWA2AaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWA2AaK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 19:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbWA2AaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 19:30:10 -0500
Received: from mail.kroah.org ([69.55.234.183]:29152 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750731AbWA2AaJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 19:30:09 -0500
Date: Sat, 28 Jan 2006 16:28:34 -0800
From: Greg KH <greg@kroah.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [PATCH RFC] put UTS_RELEASE in separate utsversion.h file
Message-ID: <20060129002834.GA8525@kroah.com>
References: <20060128215937.GA14442@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060128215937.GA14442@mars.ravnborg.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2006 at 10:59:37PM +0100, Sam Ravnborg wrote:
> During the last few days I have been toying with a allmodconfig tree
> and got irritated by all the extra modules being build over and over
> again.
> The root cause was the definition of UTS_RELEASE in version.h.
> I had enabled automatic appending of git version and it changed each
> time I committed something resulting in a lot of recompiling.
> With the following patch the recompile is kept minimal, the most
> annoying part being all the .mod.c files - but they actually use
> UTS_RELEASE so this is avoidable.
> 
> I have not updated checkversion.pl - Randy can you do that?
> 
> I have not applied the patch yet - wanted some feedback from lkml first.
> Only functional changes is in top-level makefile.
> For all users of UTS_RELEASE I simple included utsversion.h.
> 
> Note: I do not know if any external stuff(*) uses UTS_RELEASE and expect it
> to be in version.h!
> 
> (*) I here think of glibc, gcc, udev etc.

udev does not build against any kernel file, nor care about what kernel
is installed when built.  It also really doesn't check kernel info when
it is running either...

I like this patch, as someone who builds with a lot of modules enabled
:)

thanks,

greg k-h
