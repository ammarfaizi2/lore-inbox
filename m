Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751334AbWHYIzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbWHYIzj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 04:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbWHYIzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 04:55:39 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:7320 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751334AbWHYIzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 04:55:38 -0400
Subject: Re: [PATCH 0/4] Compile kernel with -fwhole-program --combine
From: David Woodhouse <dwmw2@infradead.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0608250759190.7912@yvahk01.tjqt.qr>
References: <1156429585.3012.58.camel@pmac.infradead.org>
	 <1156433068.3012.115.camel@pmac.infradead.org>
	 <Pine.LNX.4.61.0608241840440.16422@yvahk01.tjqt.qr>
	 <1156439110.3012.147.camel@pmac.infradead.org>
	 <Pine.LNX.4.61.0608250759190.7912@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Fri, 25 Aug 2006 09:55:16 +0100
Message-Id: <1156496116.2984.14.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-25 at 08:01 +0200, Jan Engelhardt wrote:
> >> Compiling files on their own (`make drivers/foo/bar.o`) seems to make 
> >> the optimization void. Sure, most people don't stop compiling in 
> >> between. Just a note
> >
> >Actually I'm not entirely sure what you write is true. It'll _build_
> >fs/jffs2/read.o, for example, but it still won't then use it when I make
> >the kernel -- it'll just use fs/jffs2/jffs2.o which is built from all
> >the C files with --combine. So the optimisation isn't lost.
> 
> Umm then it spends double the time in compilation, doing:
> 
>   read.o <- read.c
>   foo.o <- foo.c
>   bar.o <- bar.c
>   built-in.o <- read.c foo.c bar.c

Only if you invoke make explicitly for read.o, foo.o and bar.o. If you
just type 'make' then it won't build those.

> >So to overcome this, we use GCC's __attribute__((externally_visible))
> >which, as documented, just makes it global again -- undoing the effect
> >of -fwhole-program just for this _one_ symbol.
> 
> Interesting. __attribute__((visibility("default"))) does the same?

That much you can test for yourself without a fixed compiler. No, it
doesn't.

-- 
dwmw2

