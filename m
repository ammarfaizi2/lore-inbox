Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265808AbUFOSMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265808AbUFOSMS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 14:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265811AbUFOSMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 14:12:17 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:50194 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265808AbUFOSJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 14:09:57 -0400
Date: Tue, 15 Jun 2004 19:09:51 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Tom Rini <trini@kernel.crashing.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/5] kbuild
Message-ID: <20040615190951.C7666@flint.arm.linux.org.uk>
Mail-Followup-To: Tom Rini <trini@kernel.crashing.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
References: <20040614204029.GA15243@mars.ravnborg.org> <20040615154136.GD11113@smtp.west.cox.net> <20040615174929.GB2310@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040615174929.GB2310@mars.ravnborg.org>; from sam@ravnborg.org on Tue, Jun 15, 2004 at 07:49:29PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 07:49:29PM +0200, Sam Ravnborg wrote:
> On Tue, Jun 15, 2004 at 08:41:36AM -0700, Tom Rini wrote:
> > On Mon, Jun 14, 2004 at 10:40:29PM +0200, Sam Ravnborg wrote:
> > 
> > > Hi Andrew. Here follows a number of kbuild patches.
> > > 
> > > The first replaces kbuild-specify-default-target-during-configuration.patch
> > > 
> > > They have seen ligiht testing here, but on the other hand the do not touch
> > > any critical part of kbuild.
> > > 
> > > Patches:
> > > 
> > > default kernel image:		Specify default target at config
> > > 				time rather then hardcode it.
> > > 				Only enabled for i386 for now.
> > 
> > While I'd guess this is better than the patch it's replacing, given that
> > most i386 kernels are 'bzImage', what's wrong with the current logic
> > that picks out what to do for the all target now?
> 
> Compared to the original behaviour where the all: target picked the default
> target for a given architecture, this patch adds the following:

This isn't the case on ARM.  I've always told people 'make zImage'
or 'make Image'.  I've never told people to use just 'make' on its
own - in fact, I've never used 'make' on its own with the kernel.

> - One has to select the default kernel image only once
>   when configuring the kernel.
> - There exist a possibility to add more than half a line of text
>   describing individual targets. All relevant information can be
>   specified in the help section in the Kconfig file

You can't fit details for 500 platforms into half a line of text.

> If we remove the current support for for example uboot we create an
> additional step in between the make and copy image.

uboot support on ARM was only recently added, and only happened
because I happened to misread the patch.  Had I been more on the
ball, the support would NOT have been merged.  However, as it did
get merged, I didn't want to create extra noise by taking it out.

Please don't take this as acceptance that throwing the uboot crap
into the kernel for ARM was something I found agreeable.  I still
find it distasteful that boot loaders have to define their own
image formats and the kernel has to conform to the boot loader
authors whims.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
