Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264965AbUFOEb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264965AbUFOEb0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 00:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264983AbUFOEb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 00:31:26 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:4103 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S264965AbUFOEbY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 00:31:24 -0400
Date: Tue, 15 Jun 2004 06:40:20 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/5] kbuild: default kernel image
Message-ID: <20040615044020.GC16664@mars.ravnborg.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
References: <20040614204029.GA15243@mars.ravnborg.org> <20040614204405.GB15243@mars.ravnborg.org> <20040614220549.L14403@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614220549.L14403@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2004 at 10:05:49PM +0100, Russell King wrote:
> 
> I'm slightly scared of this.  Historically, there's already pressure
> from boot loader people on ARM to include random file formats to suit
> their own boot loaders.
> 
> In the first place, ARM had Image and zImage and that was it.  It was
> well defined.  Then people decided that gzipped Image would be nice
> and they'd merge the zlib code into their boot loader.  I think there's
> even some people who use gzipped zImage...!
> 
> Then ARMboot came along and we eventually ended up with uboot-style
> wrappings to support uboot / ARMboot, which require an external program
> to be installed on the host system called "mkimage" (which, incidentally
> is an incredibly bad choice of name.)
> 
> People also came up with the idea of using the ELF file directly and
> having the boot loader parse the ELF file.  I wouldn't put it past
> someone to want gzipped ELF as well.
> 
> There's also srec to support serially downloaded images as well.
> 
> So, in total, we have boot loaders which want:
> 
>   - Image
>   - zImage
>   - gzipped Image
>   - gzipped zImage
>   - uboot
>   - ELF
>   - srec
> 
> Basically this is somewhere I don't want to go.  My position is that
> if boot loaders want to have their own proprietary formats, they
> should do whatever manipulation to the kernel image is necessary as
> a post processing step themselves from one of the two standard kernel
> formats - Image or zImage.
> 
> However, the problem of offering users all these options is that their
> first question will be "huh, which one of these 7 do I want?" rather
> than everyone knowing that they need the kernel build to produce either
> an Image or zImage and the boot loader documentation telling them what
> to do with it next.

The advantage is that you now have a good place to document all of
these formats - your Kconfig file.
And you select the default target for the user.

How did I know uboot required mkimage before - now it can be documented
in Kconfig.
So the situation above is actually a good example why it is whortwhile
to move the kernel image selection to the config stage.

If they all should be part of the kernel build is another discussion.

	Sam
