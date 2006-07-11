Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751057AbWGKL1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbWGKL1z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 07:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbWGKL1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 07:27:54 -0400
Received: from ns2.suse.de ([195.135.220.15]:62873 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751057AbWGKL1x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 07:27:53 -0400
Date: Tue, 11 Jul 2006 13:27:46 +0200
From: Olaf Hering <olh@suse.de>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Roman Zippel <zippel@linux-m68k.org>, torvalds@osdl.org, klibc@zytor.com,
       linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [klibc] klibc and what's the next step?
Message-ID: <20060711112746.GA14059@suse.de>
References: <klibc.200606251757.00@tazenda.hos.anvin.org> <Pine.LNX.4.64.0606271316220.17704@scrub.home> <20060711044834.GA11694@suse.de> <44B37D9D.8000505@tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <44B37D9D.8000505@tls.msk.ru>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Tue, Jul 11, Michael Tokarev wrote:

> kinit SHOULD go with kernel. To stay compatible, to be able to move some more
> stuff to it from kernelspace with time, and so on.

compatible with what? What changes do you expect that will break kinit
as we have it right now?

> The question was about klibc, not kinit.

klibc without user is really pointless.

> > The rationale is that there are essentially 2 kind of consumers:
> > 
> > One is the kind that builds static kernels and uses no initrd of any kind.
> > For those people, the code and interfaces behind prepare_namespace() has
> > not changed in a long time.
> > They will install that kinit binary once and it will continue to work with
> > kernels from 2.6.6 and later, when "/init" support was merged. Or rather
> > from 2.6.1x when CONFIG_INITRAMFS_SOURCE was introduced.
> 
> And stuff will break on them after eg uswsusp move into kinit etc.

Why? If they want that new feature:
download kinit-2.0, make && make install. That concept is not new.
kinit-2.0 will surely be compatible with what is required for last years
kernel because its not maintained by the-average-udev-developer kind of
people.

> > The other group is the one that uses some sort of initrd (loop mount or cpio),
> > created with tools from their distribution.
> > Again, they should install that kinit binary as well because kinit emulates
> > the loop mount handling of /initrd.image. This is for older distributions
> > that still create a loop mounted initrd.
> 
> There's no need for loop-mounting of any initrd.images.  Initramfs (cpio image,
> possible gzipped) works just fine, and it will NOT go away because something
> should do the unpacking/loading of that image so that kinit &Co will run.
> There's no need for old initrd+pivot_root at all.  Only the ones who are,
> for some reason, didn't switch to initramfs yet.  And I personally see no
> reasons not to switch - initramfs (rootfs) concept is much more clean and
> easy to handle and gives more possibilities than initrd.

Are you saying that everyone now suddenly is forced to use a cpio image?
Why did hpa add the loop mount code to kinit?
So if you force people who build kernels to use newer tools, one more
external binary will surely not hurt.
