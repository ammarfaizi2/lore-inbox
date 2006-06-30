Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964801AbWF3SJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbWF3SJe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 14:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932996AbWF3SJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 14:09:33 -0400
Received: from terminus.zytor.com ([192.83.249.54]:41125 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932995AbWF3SJV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 14:09:21 -0400
Message-ID: <44A568B5.3000208@zytor.com>
Date: Fri, 30 Jun 2006 11:08:53 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Gerd Hoffmann <kraxel@suse.de>
CC: Milton Miller <miltonm@bga.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: klibc and what's the next step?
References: <Pine.LNX.4.64.0606271316220.17704@scrub.home> <f5e0f599448456bcbf2699994f0bbc76@bga.com> <Pine.LNX.4.64.0606290117220.17704@scrub.home> <200606290034.k5T0YkCw028911@terminus.zytor.com> <Pine.LNX.4.64.0606300038410.12900@scrub.home> <44A4DA33.5050707@suse.de>
In-Reply-To: <44A4DA33.5050707@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerd Hoffmann wrote:
>   Hi,
> 
>> As it looks like it's distribution which are mostly interested in this. 
>> Have you talked with any distribution maintainer to find out what they 
>> need and what they want to put initramfs? What are the exact problems 
>> which distributions have and how do you want to solve them?
> 
> Well, we already have an initramfs, and it can do quite some stuff the
> current kernel doesn't do.  Here is a (probably incomplete) list:
> 
>   * load kernel modules needed to access and mount the root filesystem
>     (block device driver, filesystem module, device mapper, ...)
>   * raid/lvm2/evms setup.
>   * iscsi setup.
>   * fsck root filesystem before mounting it.
>   * setup /dev in tmpfs (using udev).
> 
>> How do we avoid having to split all utils into a klibc version and the 
>> normal version?
> 
> That is a big question.  Latest suse doesn't use klibc any more.  Older
> versions had a bunch of static klibc-based binaries for some utilities,
> i.e. insmod, udev, sh.  Sometimes you needed glibc because one of the
> tools needed in initramfs had no klibc-version (rootfs-on-lvm case for
> example).  After adding the "fsck rootfs" feature (I think) we had glibc
> on the initramfs in almost all cases.  So if you end up with glibc in
> initramfs anyway, what is the point of having klibc?
> 

For a "big" distribution that runs on modern kernels, then by all means, 
build something around glibc.  The additional disk space and memory is a 
proverbial drop in the bucket.

However, I don't think it's realistic for smaller systems.

> One advantage of merging klibc as-is is that it becomes much more
> visible and receives more testing.  And it is probably easier to make
> utility maintainers support building with klibc then (instead of forking
> a klibc version of every utility).  That still leaves some maintaining
> questions though, because we likely end up with some utilities coming
> bundled with the kernel (sh, nfsmount, kinit, ...) and some not (lvm2, ...).

The stuff that's bundled with the kernel are replacements for kernel 
functionality.  The purpose of bundling is that kernel functionality can 
be removed.  Obviously, utility developers can build with klibc; this is 
already supported by several out-of-tree utilities, including udev. 
Should udev be bundled with the kernel?  It could be debated; however, 
it doesn't really affect the situation at hand.

	-hpa

