Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265791AbUFORkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265791AbUFORkc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 13:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265792AbUFORkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 13:40:32 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:10006 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S265791AbUFORkT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 13:40:19 -0400
Date: Tue, 15 Jun 2004 19:49:29 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/5] kbuild
Message-ID: <20040615174929.GB2310@mars.ravnborg.org>
Mail-Followup-To: Tom Rini <trini@kernel.crashing.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
References: <20040614204029.GA15243@mars.ravnborg.org> <20040615154136.GD11113@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040615154136.GD11113@smtp.west.cox.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 08:41:36AM -0700, Tom Rini wrote:
> On Mon, Jun 14, 2004 at 10:40:29PM +0200, Sam Ravnborg wrote:
> 
> > Hi Andrew. Here follows a number of kbuild patches.
> > 
> > The first replaces kbuild-specify-default-target-during-configuration.patch
> > 
> > They have seen ligiht testing here, but on the other hand the do not touch
> > any critical part of kbuild.
> > 
> > Patches:
> > 
> > default kernel image:		Specify default target at config
> > 				time rather then hardcode it.
> > 				Only enabled for i386 for now.
> 
> While I'd guess this is better than the patch it's replacing, given that
> most i386 kernels are 'bzImage', what's wrong with the current logic
> that picks out what to do for the all target now?

Compared to the original behaviour where the all: target picked the default
target for a given architecture, this patch adds the following:

- One has to select the default kernel image only once
  when configuring the kernel.
- There exist a possibility to add more than half a line of text
  describing individual targets. All relevant information can be
  specified in the help section in the Kconfig file
- Other programs now have access to what kernel image has been built.
  This is needed when creating kernel packages like rpm.

Where I see this really pay off is for architectures like MIPS with
at least four different targets, depending on selected config.
When one has selected to build a certain kernel, including a specific
bootloader only the make command is needed.
No need to remember the 'make rom.bin' or whatever target.

But this trigger the discussion how much should actually be
part of the kernel.
Building a kernel, storing it on target, and starting the kernel
should be a simple process.
>From this the current behaviour seems good:
$ make
$ copy image
$ reset the board (reset PC whatever)

If we remove the current support for for example uboot we create an
additional step in between the make and copy image.

What is the problem today is more the lack of infrastructure
support for different kernel images.
And this is where we should concentrate.

	Sam
