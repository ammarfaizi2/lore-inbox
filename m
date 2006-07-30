Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbWG3VCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbWG3VCa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 17:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbWG3VCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 17:02:30 -0400
Received: from [212.33.163.22] ([212.33.163.22]:13583 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S932306AbWG3VC3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 17:02:29 -0400
From: Al Boldi <a1426z@gawab.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] initramfs:  Allow rootfs to use tmpfs instead of ramfs
Date: Mon, 31 Jul 2006 00:03:48 +0300
User-Agent: KMail/1.5
Cc: Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, stable@kernel.org, akpm@osdl.org,
       chrisw@sous-sol.org, grim@undead.cc, Hugh Dickins <hugh@veritas.com>
References: <200607301808.14299.a1426z@gawab.com> <Pine.LNX.4.64.0607301750080.10648@blonde.wat.veritas.com> <44CCFF09.2000106@zytor.com>
In-Reply-To: <44CCFF09.2000106@zytor.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200607310003.48637.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Hugh Dickins wrote:
> > On Sun, 30 Jul 2006, Al Boldi wrote:
> >> Replugs rootfs to use tmpfs instead of ramfs as a Kconfig option.
> >
> > Why?  Looking further down we see what you should have explained here:
> >> + This option switches rootfs so that it uses tmpfs rather than ramfs
> >> + for its file storage.  This makes rootfs swappable so having a large
> >> + initrd or initramfs image won't eat up valuable RAM.
> >
> > Now, I'm far from an expert on initramfs and early userspace, but my
> > understanding is that the "init" of a (properly designed) initramfs
> > would pretty much "rm -rf" everything in the initramfs before passing
> > control to the final "init".  So (almost?) no valuable RAM is eaten
> > up, nor the less valuable swap if you do extend this to tmpfs (unless
> > something gets left open, which I think should not be the case).
> >
> > So I'm inclined to say that this patch is simply unnecessary.  But
> > if people who know better think it's a good thing, I've no objection
> > (though I've not tried it): the Kconfiggery looks more likely to
> > provoke argument than the tmpfs/ramfs mods.
>
> Well...
>
> There is some justification: embedded people would like to load
> inittmpfs and then continue running.
>
> The main issue -- which I am not sure what effect this patch has -- is
> that we would really like to move initramfs initialization even earlier
> in the kernel, so that it can include firmware loading for built-in
> device drivers, for example.

I suspect, if there would be a problem with tmpfs, then ramfs would be no 
different.

> Thus, if this patch makes it harder to push initramfs initialization
> earlier, it's probably a bad thing.

Agreed, but remember that tmpfs is an option, not a replacement.

> If not, the author of the patch
> really needs to explain why it works and why it doesn't add new
> dependencies to the initialization order.
>
> Saying "this is a trivial patch" and pushing it on the -stable tree
> doesn't inspire too much confidence, as initialization is subtle.

Ok, I did play with main.c, and as you mentioned, initialization is subtle.  
But categorizing this patch as trivial is based more on the fact, that ramfs 
and tmpfs are semantically equivalent, and as such should not impose 
additional dependencies.


Thanks for your comments!

--
Al

