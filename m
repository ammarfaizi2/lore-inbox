Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbVKULsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbVKULsw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 06:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbVKULsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 06:48:51 -0500
Received: from hera.kernel.org ([140.211.167.34]:7904 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932207AbVKULsv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 06:48:51 -0500
Date: Mon, 21 Nov 2005 04:23:50 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Rob Landley <rob@landley.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Matt Mackall <mpm@selenic.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: [PATCH] skip initramfs check
Message-ID: <20051121062350.GA24381@logos.cnet>
References: <20051117141432.GD9753@logos.cnet> <200511210130.55774.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511210130.55774.rob@landley.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rob,

On Mon, Nov 21, 2005 at 01:30:55AM -0600, Rob Landley wrote:
> On Thursday 17 November 2005 08:14, Marcelo Tosatti wrote:
> > Hi,
> >
> > The initramfs check at populate_rootfs() can consume significant time
> > (several seconds) on slow/embedded platforms, since it has to decompress
> > the image.
> 
> Query: is the problem that a big initramfs image is being unpacked more than 
> once, or is unpacking an empty initramfs image (134 bytes) causing a 
> significant delay?

The problem is a big non-initramfs RAMDISK image (used for root mountpoint on this 
particular embedded platform), that is decompressed more than once:

- during the initramfs check, which fails because it is not initramfs.
- during the real RAMDISK decompression to memory.

> I'm fairly certain that back in 1990 I could unzip 134 bytes on my 33 mhz 386 
> running dos in a fraction of a second.  What's the use case here?

So the issue is not the empty initramfs image (which BTW could probably
be made unecessary?), but a 10Mb RAMDISK image being decompressed by a
48Mhz PPC, which takes quite a few seconds.

Need to rework the patch to use a __setup option as Andrew suggested.
