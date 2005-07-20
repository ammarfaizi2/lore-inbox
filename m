Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261286AbVGTIX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbVGTIX6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 04:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVGTIX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 04:23:58 -0400
Received: from mail.yosifov.net ([193.200.14.114]:38584 "EHLO home.yosifov.net")
	by vger.kernel.org with ESMTP id S261286AbVGTIX5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 04:23:57 -0400
Subject: Re: Noob question. Why is the for-pentium4 kernel built
	with	-march=i686 ?
From: Ivan Yosifov <ivan@yosifov.net>
Reply-To: ivan@yosifov.net
To: Kerin Millar <kerframil@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <pan.2005.07.20.08.03.25.15476@gmail.com>
References: <1121792852.11857.6.camel@home.yosifov.net>
	 <Pine.LNX.4.61.0507191950020.89@yvahk01.tjqt.qr>
	 <1121798151.15700.9.camel@home.yosifov.net>
	 <pan.2005.07.20.08.03.25.15476@gmail.com>
Content-Type: text/plain
Date: Wed, 20 Jul 2005 11:23:19 +0300
Message-Id: <1121847799.31603.5.camel@home.yosifov.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-20 at 09:03 +0100, Kerin Millar wrote:
> On Tue, 19 Jul 2005 21:35:51 +0300, Ivan Yosifov wrote:
> 
> <snip>
> 
> > -march implies -mtune and also implies thing like -msse2 for the
> > instruction set where applicable. 
> > I think -march=pentium4 is equivalent to -mmmx -msse -msse2
> > -mtune=pentium4 ( if I have not fogotten anything ).  
> > Pentium4 supports things like sse2 and mmx which AFAIK plain i686 does
> > not. I first thought that maybe the kernel was destabilized by such
> > optimizations, but k8 has all of them and more ( sse3 ). 
> > So, if it is ok to build the k8 kernel with -march=k8 why is it not ok
> > to built the p4 kernel with -march=pentium4 ? 
> > I may be wrong, but any way I think of it it looks like a performance
> > hit to build a p4 kernel with -march=i686.
> > 
> 
> Well, it may seem logical to think that but proving it is another matter
> entirely. The flags that you refer to (-mmmx, -msse and -msse2) enable
> support for vector extensions through various built-in functions. But this
> does not necessarily mean that the code is somehow transformed to make use
> of these functions, nor that the compiler decides to makes effective use
> of these extensions via the optimisation process. As far as I'm aware,
> only >=gcc-4.0 has support for auto-vectorisation although I am not
> certain as to how effective it is. Jakub Jellinek has some wise words to
> say on the topic in general:
> 
> https://www.redhat.com/archives/fedora-devel-list/2005-January/msg00742.html

Interesting. 

> 
> Where genuine performance tests are conducted the results are not always
> in accordance with what one might expect. Only hours ago I was reading a
> LFS thread where someone had noted poorer performance using the "prescott"
> target as opposed to "i386" for example. That Red Hat also choose to use
> -march=i386 is interesting (as noted in the link above, with the exception
> of the kernel and glibc) ...
> 
> Also, I believe that the -march=pentium4 option /was/ actually used up
> until kernel 2.6.10 where it was dropped because of a risk that some
> versions of gcc would cause the kernel to use SSE registers for data
> movement (which is a no-no).
> 

You seem right. I fetched a 2.6.9 tarball and it is really built with
-march=pentium4. Do you know which are versions of gcc in question ?

> Cheers,
> 
> --Kerin Millar
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

