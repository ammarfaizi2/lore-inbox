Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271788AbRICT6t>; Mon, 3 Sep 2001 15:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271792AbRICT6k>; Mon, 3 Sep 2001 15:58:40 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:58554 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S271788AbRICT6f>; Mon, 3 Sep 2001 15:58:35 -0400
Date: Mon, 3 Sep 2001 13:57:38 -0600
Message-Id: <200109031957.f83Jvc927318@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Per Niva <pna@mendosus.org>
Cc: <arjanv@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Added devfs support for i386 msr/cpuid driver
In-Reply-To: <Pine.LNX.4.33.0108271621410.22199-100000@subcentral.mendosus.org>
In-Reply-To: <200108271452.f7REqjT15752@vindaloo.ras.ucalgary.ca>
	<Pine.LNX.4.33.0108271621410.22199-100000@subcentral.mendosus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Per Niva writes:
> On Mon, 27 Aug 2001, Richard Gooch wrote:
> > The reason it's wrong is because he put #ifdef's in there. The
> > functions should just be called unconditionally. The #ifdef's are in
> > the header.
> 
> I actually pondered a while on this, and settled on
> the cut'n'paste-from-mtrr.c version. There is no error
> check there, and I just overlooked it.
> 
> The defence for the #ifdefs is that I didn't see
> register_chrdev() being aware of devfs, and I thought
> we'd be better off just not calling register_chrdev()
> at all if we have devfs.

No, even if CONFIG_DEVFS_FS=y, doesn't mean the user wants to
mount/use devfs, so you shouldn't disable register_chrdev().

> It's not like I personally like #ifdefs, but it seemed
> justified to my inexperienced eyes at that point. And
> there's a #ifdef CONFIG_DEVFS_FS around the call in
> mtrr.c too, and I thought it safe to do like what's
> already in the official tree.

The #ifdef in mtrr.c is there for historical reasons (at one point,
neither the mtrr or devfs patches were in the kernel, but I wanted
mtrr to use devfs if available, hence the #ifdef). The #ifdef can be
safely taken out (and should be).

> In microcode.c however, is the new-style without #ifdef
> (or rather with the #ifdef in the headers instead)
> and with error checking, but microcode_init() doesn't
> use register_chrdev() anyway, even if devfs is not
> supported.
> 
> Please enlighten me!

The microcode patch went in after devfs was in the kernel, IIRC, and
thus could unconditionally reference devfs_register().

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
