Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261795AbUKJNhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261795AbUKJNhL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 08:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbUKJNhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 08:37:11 -0500
Received: from witte.sonytel.be ([80.88.33.193]:23970 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261795AbUKJNhA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 08:37:00 -0500
Date: Wed, 10 Nov 2004 14:36:45 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
cc: Robert Love <rml@novell.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] kmem_alloc (generic wrapper for kmalloc and vmalloc)
In-Reply-To: <4191B5D8.3090700@gmx.net>
Message-ID: <Pine.GSO.4.61.0411101435170.17015@waterleaf.sonytel.be>
References: <4191A4E2.7040502@gmx.net> <1100066597.18601.124.camel@localhost>
 <4191B5D8.3090700@gmx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Nov 2004, Carl-Daniel Hailfinger wrote:
> Robert Love schrieb:
> > On Wed, 2004-11-10 at 06:19 +0100, Carl-Daniel Hailfinger wrote:
> >>it seems there is a bunch of drivers which want to allocate memory as
> >>efficiently as possible in a wide range of allocation sizes. XFS and
> >>NTFS seem to be examples. Implement a generic wrapper to reduce code
> >>duplication.
> >>Functions have the my_ prefixes to avoid name clash with XFS.
> > 
> > 
> > No, no, no.  A good patch would be fixing places where you see this.
> > 
> > Code needs to conscientiously decide to use vmalloc over kmalloc.  The
> > behavior is different and the choice needs to be explicit.
> 
> Yes, but what do you suggest for the following problem:
> alloc(max_loop*sizeof(struct loop_device))
> 
> where sizeof(struct loop_device)==304 and 1<=max_loop<=16384
> 
> For the smallest allocation (304 bytes) vmalloc is clearly wasteful
> and for the largest allocation (~ 5 MBytes) kmalloc doesn't work.

Try vmalloc() if kmalloc() fails?

BTW, is there a simple and portable way to distinguish between memory allocated
using kmalloc() and vmalloc(), or should the called remember the allocation
method?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
