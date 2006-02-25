Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbWBYWha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbWBYWha (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 17:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbWBYWha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 17:37:30 -0500
Received: from [192.231.160.6] ([192.231.160.6]:24687 "EHLO cinder.waste.org")
	by vger.kernel.org with ESMTP id S932137AbWBYWh3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 17:37:29 -0500
Date: Sat, 25 Feb 2006 16:37:37 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] inflate pt1: clean up input logic
Message-ID: <20060225223737.GO13116@waste.org>
References: <4.399206195@selenic.com> <20060224221909.GD28855@flint.arm.linux.org.uk> <20060225065136.GH13116@waste.org> <20060225084955.GA27538@flint.arm.linux.org.uk> <20060225145412.GI13116@waste.org> <20060225180521.GB15276@flint.arm.linux.org.uk> <20060225210454.GL13116@waste.org> <20060225212247.GC15276@flint.arm.linux.org.uk> <20060225214704.GN13116@waste.org> <20060225215850.GD15276@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060225215850.GD15276@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2006 at 09:58:50PM +0000, Russell King wrote:
> On Sat, Feb 25, 2006 at 03:47:04PM -0600, Matt Mackall wrote:
> > On Sat, Feb 25, 2006 at 09:22:48PM +0000, Russell King wrote:
> > > init/do_mounts_rd.c:#include "../lib/inflate.c"
> > > init/initramfs.c:#include "../lib/inflate.c"
> > > 
> > > for these your arguments that halting is fine is _NOT_ correct nor is it
> > > desirable.
> > 
> > If you have an argument for why we shouldn't halt on failed
> > init{rd,ramfs} decompression, I look forward to hearing it.
> > 
> > > Did you read that post?
> > 
> > This? http://www.ussg.iu.edu/hypermail/linux/kernel/0312.2/1024.html
> 
> Yes, that.
> 
> > "The firmware then calls the kernel decompressor, which dutifully
> > decompresses the image, and calls the kernel. This image ends up
> > getting corrupted at some point."
> > 
> > Is your argument that we shouldn't halt after encountering a corrupt
> > image?
> 
> You're getting very confused.
> 
> 1. kernel is loaded.
> 2. firmware scans loaded kernel, finds gzip magic numbers (the compressed
>    kernel.)
> 3. firmware sets initrd pointeres to point at the compressed kernel.
> 4. firmware calls kernel decompressor.
> 5. kernel decompresses and self-relocates.
> 6. compressed kernel image is thereby partly corrupted.
> 7. kernel boots.
> 8. kernel tries to decompress the compressed kernel image.
> 9. decompressor gets confused and tries to gobble more data than is
>    available.
> 10. kernel sits there being a dumb fuck.

Why are we attempting to decompress the kernel image again? Accident?

> > In my mind, being unable to decompress init* is every bit as fatal as
> > being unable to mount root.
> 
> It's very simple.  With fix, the kernel successfully boots on these
> machines.  Without fix, the kernel hangs on these machines for _no_
> good reason other than the firmware did something that was stupid.

And how does this work currently? We attempt to decompress the kernel
a second time, give up and move on?

Assuming we can write to the compressed image (and thereby corrupt
it), wouldn't it be better to just stomp on the gzip magic and spare
us the overhead of decompressing it twice?

> I'm sorry, I just do not see why you're being soo bloody difficult
> over this.

Because it's taken this long to get close to an explanation of what
the problem is.

-- 
Mathematics is the supreme nostalgia of our time.
