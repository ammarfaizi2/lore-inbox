Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965196AbWFIONm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965196AbWFIONm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 10:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965198AbWFIONm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 10:13:42 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:14511 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S965196AbWFIONl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 10:13:41 -0400
Date: Fri, 9 Jun 2006 16:13:20 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: klibc - another libc?
In-Reply-To: <e69fu3$5ch$1@terminus.zytor.com>
Message-ID: <Pine.LNX.4.64.0606091409220.17704@scrub.home>
References: <44869397.4000907@tls.msk.ru> <e67fok$h25$1@terminus.zytor.com>
 <Pine.LNX.4.64.0606080036250.17704@scrub.home> <e69fu3$5ch$1@terminus.zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 8 Jun 2006, H. Peter Anvin wrote:

> > That still doesn't answer, why it has to be distributed with the kernel, 
> > just install the thing somewhere under /lib and Kbuild can link to it. The 
> > point is that it contains nothing kernel specific and doesn't has to be 
> > rebult with every new kernel.
> > 
> 
> Actually, that isn't quite true.  One of the ways klibc is kept small
> is by not guaranteeing a stable ABI... and not having compatibility
> support for older kernels.  This is one of the kinds of luxuries that
> bundling offers.

It's indeed more of a luxury than a necessity.
How often does that really change? Bundling it with the kernel may 
actually encourage some developers to be less careful regarding 
compatibility. We already have enough problems with this as it is.

> Does it make bundling mandatory?  Not really.  In fact, people have
> been using klibc in its standalone form for years.  However, I believe
> there would be a lot of resistace to have the kernel tarball have
> outside dependencies on anything but the most basic build tools.

If you wouldn't remove all old init code at once it would still be 
possible to build a kernel this way. Why are you making it mandatory? Why 
don't you leave it optional for a while and only gradually remove the old 
code? This way distributions/users can experiment with it regarding their 
current initrd/boot setups.

Why shouldn't klibc be part of the basic build tools? I asked this already 
earlier: where do you draw the line regarding duplication? Are you going 
to duplicate every single tool, which might be needed to build the kernel 
only to reduce outside dependencies? IMO that's illusory for more complex 
setups anyway. Let's take booting from raid, in this case you need to 
install mdadm anyway, which could also provide an initramfs version. This 
way the setup tools can be generated from the same source, which reduces 
duplication and maintenance overhead.

Just to be clear here, I really appreciate the work you've done, but I'm 
not exactly comfortable with merging a huge patch, which completely 
changes the boot sequence at once, without any clear plan of what's coming 
next. It would be a lot less problematic if the transition would be more 
gradually, which IMO is very well possible. Usually it's a requirement to 
split large patches, why should klibc be special?

bye, Roman
