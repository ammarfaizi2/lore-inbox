Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030404AbWFITCv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030404AbWFITCv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 15:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030407AbWFITCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 15:02:51 -0400
Received: from hera.kernel.org ([140.211.167.34]:35768 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1030404AbWFITCu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 15:02:50 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: klibc - another libc?
Date: Fri, 9 Jun 2006 12:02:23 -0700 (PDT)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <e6cgjv$b8t$1@terminus.zytor.com>
References: <44869397.4000907@tls.msk.ru> <Pine.LNX.4.64.0606080036250.17704@scrub.home> <e69fu3$5ch$1@terminus.zytor.com> <Pine.LNX.4.64.0606091409220.17704@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1149879743 11550 127.0.0.1 (9 Jun 2006 19:02:23 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Fri, 9 Jun 2006 19:02:23 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.64.0606091409220.17704@scrub.home>
By author:    Roman Zippel <zippel@linux-m68k.org>
In newsgroup: linux.dev.kernel
> > 
> > Actually, that isn't quite true.  One of the ways klibc is kept small
> > is by not guaranteeing a stable ABI... and not having compatibility
> > support for older kernels.  This is one of the kinds of luxuries that
> > bundling offers.
> 
> It's indeed more of a luxury than a necessity.
> How often does that really change?

A lot more often than you'd think.

> If you wouldn't remove all old init code at once it would still be 
> possible to build a kernel this way. Why are you making it mandatory? Why 
> don't you leave it optional for a while and only gradually remove the old 
> code? This way distributions/users can experiment with it regarding their 
> current initrd/boot setups.

Linus vetoed that option years ago.  Anyway, the standalone version of
klibc has been available for almost three years, and has been used by
at least Debian for their initramfs code for a considerable amount of
time.  It's not like it's an untested piece of code.

> Why shouldn't klibc be part of the basic build tools? I asked this already 
> earlier: where do you draw the line regarding duplication?

Judgement call.  I'm not sure I have done the best possible job,
either, but you have to call it somewhere.

> Are you going to duplicate every single tool, which might be needed
> to build the kernel only to reduce outside dependencies? IMO that's
> illusory for more complex setups anyway.

Hyperbole.

FWIW, I've worked in environments where you pull a single source tree
and get the compilers as well as the code you build them with.  It is
*wonderful* for reproducibility, but I don't think that's going to
happen with respect to Linux, and noone is calling for that.

>  Let's take booting from raid, in this case you need to install
> mdadm anyway, which could also provide an initramfs version. This
> way the setup tools can be generated from the same source, which
> reduces duplication and maintenance overhead.

You don't need mdadm to boot from RAID.  kinit handles it just fine.
At the same time, I do intend to continue to maintain the standalone
klibc, which can be used to produce external binary trees.

> Just to be clear here, I really appreciate the work you've done, but I'm 
> not exactly comfortable with merging a huge patch, which completely 
> changes the boot sequence at once, without any clear plan of what's coming 
> next. It would be a lot less problematic if the transition would be more 
> gradually, which IMO is very well possible. Usually it's a requirement to 
> split large patches, why should klibc be special?

When I asked Andrew how he'd like me to pass him the code, he said he
was happy pulling my git tree.  This saved time for both of us, and
made it easier and quicker for me to integrate fixes.  You can do so
too, which will get you a full history of the development, in about
1,400 pieces.

	-hpa
