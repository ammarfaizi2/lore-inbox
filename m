Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbTJRWLp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 18:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbTJRWLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 18:11:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60549 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261841AbTJRWLo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 18:11:44 -0400
Date: Sat, 18 Oct 2003 23:11:43 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] initrd with devfs enabled (Re: initrd and 2.6.0-test8)
Message-ID: <20031018221143.GI7665@parcelfarce.linux.theplanet.co.uk>
References: <3F916A0C.10800@comcast.net> <1066501993.4208.6.camel@chtephan.cs.pocnet.net> <20031018194148.GE7665@parcelfarce.linux.theplanet.co.uk> <200310182356.04346.arekm@pld-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310182356.04346.arekm@pld-linux.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 18, 2003 at 11:56:04PM +0200, Arkadiusz Miskiewicz wrote:
> On Saturday 18 of October 2003 21:41, viro@parcelfarce.linux.theplanet.co.uk 
> wrote:
> > 	OK, that should do it - the problems happened if you had devfs
> > enabled; in that case late-boot code does temporary mount of devfs over
> > rootfs /dev, which made /dev/initrd inaccessible.  For setups without
> > devfs that didn't happen.
> >
> > 	Fix is trivial - put the file in question outside of /dev; IOW,
> > we simply replace "/dev/initrd" with "/initrd.image" in init/*.  It works
> > here; please check if it fixes all initrd problems on your boxen.
> Works fine for me.
> 
> btw. is it possible to do not use initrd with some fs and instead use external 
> initramfs image?
> 
> I've tried to create initramfs image with unpacking initrd image, mounting it 
> over loop and creating cpio archive from that (find . | cpio -o -c > 
> ../x.cpio), gzipping that cpio and placeing it instead of old initrd at 
> /boot/initrd + lilo reload. 
> 
> It doesn't work that way unfortunately (test8 with your patch).

Yes and no - it *is* unpacked, but currently we have no code that would
try to run something from initramfs.  If you want to play with that -
add something like run_init_process("/init"); right before the call of
prepare_namespace() in init/main.c (and be ready to have /init on
initramfs do the rest, obvoiusly).
