Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289071AbSAGBlP>; Sun, 6 Jan 2002 20:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289070AbSAGBlK>; Sun, 6 Jan 2002 20:41:10 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:23460 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S289071AbSAGBk6>; Sun, 6 Jan 2002 20:40:58 -0500
Date: Sun, 6 Jan 2002 18:40:58 -0700
Message-Id: <200201070140.g071ewk21192@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Matt Dainty <matt@bodgit-n-scarper.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, torvalds@transmeta.com
Subject: Re: [PATCH] DevFS support for /dev/cpu/X/(cpuid|msr)
In-Reply-To: <3C38FAB0.4000503@zytor.com>
In-Reply-To: <20020106181749.A714@butterlicious.bodgit-n-scarper.com>
	<200201061934.g06JYnZ15633@vindaloo.ras.ucalgary.ca>
	<3C38BC6B.7090301@zytor.com>
	<200201062108.g06L8lM17189@vindaloo.ras.ucalgary.ca>
	<3C38BD32.6000900@zytor.com>
	<200201070131.g071VrM20956@vindaloo.ras.ucalgary.ca>
	<3C38FAB0.4000503@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin writes:
> Richard Gooch wrote:
> 
> > 
> > So you mean something like this:
> > 
> > void devfs_per_cpu_register (const char *leafname, unsigned int flags,
> > 			     unsigned int major, unsigned int minor_start,
> > 			     umode_t mode, void *ops);
> > 
> > void devfs_per_cpu_unregister (const char *leafname);
> > 
> > with code in the per-cpu boot code to create the /dev/cpu/%d
> > directories.
> 
> Yes, that sounds like a good way to do it.

Unfortunately, there doesn't seem to be a really nice place to put
generic SMP startup code. Each arch defines it's own per-cpu startup
code. As Matt asked in a private email, it would require hacks to each
arch to support this (Matt: this is my reply:-). While it would be
fairly simple to add a call to a devfs_cpu_register() function to each
arch, this does seem a bit hackish.

So I'd like to propose a new file (say kernel/smp.c) which has generic
startup code for each CPU. To start with, it can have a
generic_cpu_init() function, which is called by each arch. Note that
this function would be called for the boot CPU too.

Comments?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
