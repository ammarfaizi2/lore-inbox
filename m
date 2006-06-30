Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751466AbWF3IBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbWF3IBL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 04:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbWF3IBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 04:01:11 -0400
Received: from mx1.suse.de ([195.135.220.2]:62890 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751466AbWF3IBK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 04:01:10 -0400
Message-ID: <44A4DA33.5050707@suse.de>
Date: Fri, 30 Jun 2006 10:00:51 +0200
From: Gerd Hoffmann <kraxel@suse.de>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Milton Miller <miltonm@bga.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: klibc and what's the next step?
References: <Pine.LNX.4.64.0606271316220.17704@scrub.home> <f5e0f599448456bcbf2699994f0bbc76@bga.com> <Pine.LNX.4.64.0606290117220.17704@scrub.home> <200606290034.k5T0YkCw028911@terminus.zytor.com> <Pine.LNX.4.64.0606300038410.12900@scrub.home>
In-Reply-To: <Pine.LNX.4.64.0606300038410.12900@scrub.home>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> As it looks like it's distribution which are mostly interested in this. 
> Have you talked with any distribution maintainer to find out what they 
> need and what they want to put initramfs? What are the exact problems 
> which distributions have and how do you want to solve them?

Well, we already have an initramfs, and it can do quite some stuff the
current kernel doesn't do.  Here is a (probably incomplete) list:

  * load kernel modules needed to access and mount the root filesystem
    (block device driver, filesystem module, device mapper, ...)
  * raid/lvm2/evms setup.
  * iscsi setup.
  * fsck root filesystem before mounting it.
  * setup /dev in tmpfs (using udev).

> How do we avoid having to split all utils into a klibc version and the 
> normal version?

That is a big question.  Latest suse doesn't use klibc any more.  Older
versions had a bunch of static klibc-based binaries for some utilities,
i.e. insmod, udev, sh.  Sometimes you needed glibc because one of the
tools needed in initramfs had no klibc-version (rootfs-on-lvm case for
example).  After adding the "fsck rootfs" feature (I think) we had glibc
on the initramfs in almost all cases.  So if you end up with glibc in
initramfs anyway, what is the point of having klibc?

One advantage of merging klibc as-is is that it becomes much more
visible and receives more testing.  And it is probably easier to make
utility maintainers support building with klibc then (instead of forking
a klibc version of every utility).  That still leaves some maintaining
questions though, because we likely end up with some utilities coming
bundled with the kernel (sh, nfsmount, kinit, ...) and some not (lvm2, ...).

just my 2 cent,

  Gerd

-- 
Gerd Hoffmann <kraxel@suse.de>
http://www.suse.de/~kraxel/julika-dora.jpeg
