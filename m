Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264172AbUDGSVN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 14:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264161AbUDGSSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 14:18:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:36284 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264179AbUDGSRb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 14:17:31 -0400
Date: Wed, 7 Apr 2004 11:18:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andy Isaacson <adi@hexapodia.org>
Cc: bug-coreutils@gnu.org, linux-kernel@vger.kernel.org
Subject: Re: dd PATCH: add conv=direct
Message-Id: <20040407111841.78ae0021.akpm@osdl.org>
In-Reply-To: <20040407173116.GB2814@hexapodia.org>
References: <20040406220358.GE4828@hexapodia.org>
	<20040406173326.0fbb9d7a.akpm@osdl.org>
	<20040407173116.GB2814@hexapodia.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Isaacson <adi@hexapodia.org> wrote:
>
> On Tue, Apr 06, 2004 at 05:33:26PM -0700, Andrew Morton wrote:
> > Andy Isaacson <adi@hexapodia.org> wrote:
> > >          dd(1) is convenient for this purpose, but is lacking a method
> > > to force O_DIRECT.  The enclosed patch adds a "conv=direct" flag to
> > > enable this usage.
> > 
> > This would be rather nice to have.  You'll need to ensure that the data
> > is page-aligned in memory.
> 
> So, some confusion on my part about O_DIRECT:  I can't get O_DIRECT to
> work on ext3, at all, on 2.4.25

ext3 doesn't support O_DIRECT in 2.4 kernels.  I did a patch once and I
think it's in 2.4-aa kernels.

ext3 supports O_DIRECT in 2.6 kernels.  Quite a number of filesystems do.

> -- open(O_DIRECT) succeeds, but the write
> returns EINVAL.

Yup that's a bit silly.  In 2.6 we do the check at open() and fcntl() time.
In 2.4 we don't fail until the actual I/O attempt.

>  Same code works fine when writing to a block device.
> If the problem is that ext3 can't support O_DIRECT, why does the open
> succeed?

We have been insufficiently assiduous in merging externally-supported
patches into the mainline 2.4 tree.

> > While you're there, please add an fsync-before-closing option.
> 
> Easy enough.  How does this look?  Note that C_TWOBUFS ensures the
> output buffer is getpagesize()-aligned.

Looks nice and simple.  You'll need an ext2 filesystem to test it under 2.4.

Be aware that it's rather a challenge to actually get the O_DIRECT #define
in scope under some glibc versions.  I think you need to define _GNU_SOURCE
or something like that.

