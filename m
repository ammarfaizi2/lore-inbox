Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932428AbWG3Stx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbWG3Stx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 14:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbWG3Stx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 14:49:53 -0400
Received: from terminus.zytor.com ([192.83.249.54]:22924 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932428AbWG3Stw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 14:49:52 -0400
Message-ID: <44CCFF09.2000106@zytor.com>
Date: Sun, 30 Jul 2006 11:48:41 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Al Boldi <a1426z@gawab.com>, Rob Landley <rob@landley.net>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, stable@kernel.org,
       akpm@osdl.org, chrisw@sous-sol.org, grim@undead.cc
Subject: Re: [PATCH] initramfs:  Allow rootfs to use tmpfs instead of ramfs
References: <200607301808.14299.a1426z@gawab.com> <Pine.LNX.4.64.0607301750080.10648@blonde.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.64.0607301750080.10648@blonde.wat.veritas.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> On Sun, 30 Jul 2006, Al Boldi wrote:
>> Replugs rootfs to use tmpfs instead of ramfs as a Kconfig option.
> 
> Why?  Looking further down we see what you should have explained here:
>> + This option switches rootfs so that it uses tmpfs rather than ramfs
>> + for its file storage.  This makes rootfs swappable so having a large
>> + initrd or initramfs image won't eat up valuable RAM.
> 
> Now, I'm far from an expert on initramfs and early userspace, but my
> understanding is that the "init" of a (properly designed) initramfs
> would pretty much "rm -rf" everything in the initramfs before passing
> control to the final "init".  So (almost?) no valuable RAM is eaten
> up, nor the less valuable swap if you do extend this to tmpfs (unless
> something gets left open, which I think should not be the case).
> 
> So I'm inclined to say that this patch is simply unnecessary.  But
> if people who know better think it's a good thing, I've no objection
> (though I've not tried it): the Kconfiggery looks more likely to
> provoke argument than the tmpfs/ramfs mods.
> 

Well...

There is some justification: embedded people would like to load 
inittmpfs and then continue running.

The main issue -- which I am not sure what effect this patch has -- is 
that we would really like to move initramfs initialization even earlier 
in the kernel, so that it can include firmware loading for built-in 
device drivers, for example.

Thus, if this patch makes it harder to push initramfs initialization 
earlier, it's probably a bad thing.  If not, the author of the patch 
really needs to explain why it works and why it doesn't add new 
dependencies to the initialization order.

Saying "this is a trivial patch" and pushing it on the -stable tree 
doesn't inspire too much confidence, as initialization is subtle.

	-hpa
