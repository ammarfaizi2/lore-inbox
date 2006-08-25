Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbWHYGBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbWHYGBw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 02:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbWHYGBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 02:01:52 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:30664 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1750826AbWHYGBv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 02:01:51 -0400
Date: Fri, 25 Aug 2006 08:01:27 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: David Woodhouse <dwmw2@infradead.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Compile kernel with -fwhole-program --combine
In-Reply-To: <1156439110.3012.147.camel@pmac.infradead.org>
Message-ID: <Pine.LNX.4.61.0608250759190.7912@yvahk01.tjqt.qr>
References: <1156429585.3012.58.camel@pmac.infradead.org> 
 <1156433068.3012.115.camel@pmac.infradead.org>  <Pine.LNX.4.61.0608241840440.16422@yvahk01.tjqt.qr>
 <1156439110.3012.147.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Compiling files on their own (`make drivers/foo/bar.o`) seems to make 
>> the optimization void. Sure, most people don't stop compiling in 
>> between. Just a note
>
>Actually I'm not entirely sure what you write is true. It'll _build_
>fs/jffs2/read.o, for example, but it still won't then use it when I make
>the kernel -- it'll just use fs/jffs2/jffs2.o which is built from all
>the C files with --combine. So the optimisation isn't lost.

Umm then it spends double the time in compilation, doing:

  read.o <- read.c
  foo.o <- foo.c
  bar.o <- bar.c
  built-in.o <- read.c foo.c bar.c

(cf. default current:
  built-in.o <- read.o foo.o bar.o)

>So to overcome this, we use GCC's __attribute__((externally_visible))
>which, as documented, just makes it global again -- undoing the effect
>of -fwhole-program just for this _one_ symbol.

Interesting. __attribute__((visibility("default"))) does the same?


Jan Engelhardt
-- 
