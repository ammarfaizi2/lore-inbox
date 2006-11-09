Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423223AbWKIAzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423223AbWKIAzs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 19:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423975AbWKIAzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 19:55:47 -0500
Received: from smtp.osdl.org ([65.172.181.4]:8164 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423223AbWKIAzr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 19:55:47 -0500
Date: Wed, 8 Nov 2006 16:55:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc5-mm1
Message-Id: <20061108165540.0d3c4340.akpm@osdl.org>
In-Reply-To: <200611090144.53887.rjw@sisk.pl>
References: <20061108015452.a2bb40d2.akpm@osdl.org>
	<200611090031.35069.rjw@sisk.pl>
	<20061108161732.1225730d.akpm@osdl.org>
	<200611090144.53887.rjw@sisk.pl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Nov 2006 01:44:53 +0100
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Thursday, 9 November 2006 01:17, Andrew Morton wrote:
> > On Thu, 9 Nov 2006 00:31:34 +0100
> > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > 
> > > On Wednesday, 8 November 2006 10:54, Andrew Morton wrote:
> > > > 
> > > > Temporarily at
> > > > 
> > > > http://userweb.kernel.org/~akpm/2.6.19-rc5-mm1/
> > > > 
> > > > will turn up at
> > > > 
> > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc5/2.6.19-rc5-mm1/
> > > > 
> > > > when kernel.org mirroring catches up.
> > > > 
> > > > 
> > > > 
> > > > - Merged the Kernel-based Virtual Machine patches.  See kvm.sf.net for
> > > >   userspace tools, instructions, etc.
> > > > 
> > > >   It needs a recent binutils to build.
> > > > 
> > > > - The hrtimer+dynticks code still doesn't work right for machines which halt
> > > >   their TSC in low-power states.
> > > 
> > > On my HPC nx6325 it doesn't even reach the point in which the messages become
> > > visible on the console, so I'm unable to get any debug info from it.
> > 
> > Nice.  You're using earlyprintk?
> 
> earlyprintk=vga doesn't show anything (ie. blank screen), so it seems to crash
> really early.

OK, so it's definitely bisection time.

> I'm unable to reproduce the problem on a non-SMP box (Asus L5D), which works
> just fine with this kernel, but on the other SMP box the framebuffer is broken
> (displays all fonts inverted, as in a mirror)

Which fbdev driver?  (suspect fbcon-rere-fix-little-endian-bogosity-in-slow_imageblit.patch)

> and the kernel says it cannot
> mount the root fs (which is on an md-raid).

hm, there was probably some earlier message which tells us why that
happened.  Doing a capure-and-compare on the dmesg output would be nice
(netconsole?)


> All boxes are x86_64, the .config for nx6325 is attached.
> 
