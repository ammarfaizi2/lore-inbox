Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262204AbTCHUPn>; Sat, 8 Mar 2003 15:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262205AbTCHUPn>; Sat, 8 Mar 2003 15:15:43 -0500
Received: from hera.cwi.nl ([192.16.191.8]:18897 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S262204AbTCHUPl>;
	Sat, 8 Mar 2003 15:15:41 -0500
From: Andries.Brouwer@cwi.nl
Date: Sat, 8 Mar 2003 21:26:15 +0100 (MET)
Message-Id: <UTC200303082026.h28KQFN04439.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, akpm@digeo.com, alan@lxorguk.ukuu.org.uk,
       greg@kroah.com, hch@infradead.org, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [PATCH] register_blkdev
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> That's why the character device code should get a similar massaging

> I agree, I thought this was a 2.7 change, but it's looking like people
> want this change sooner :)

There is no need to do all of that. Going to 32-bit dev_t
is trivial, not a major restructuring.

Three minutes editing of kdev_t.h and posix_types.h and you have it.
Boot the kernel and it runs fine.

However, it can be crashed from userspace, so before we do
the three minutes editing the audit is needed.
Look at the patch for raw.c I posted a few hours ago.
One trivial test.

If we do it as Alan suggested even this one test can be
avoided in most places.

> If people really think they need a 32bit dev_t
> we should just introduce it and use it only for block devices
> and stay with the old 8+8 split for character devices.

Of course discussing the future and how the cake should
be divided once we have it may be of interest - but let
us bake the cake first. The work required is entirely
independent of the size and structure of dev_t.

Andries - curious whether 2.5.65 will show progress


[not that the road isn't long - once the kernel is happy
there are some glibc details - strange enough glibc uses
a gigantic dev_t but simultaneously assumes that major and
minor only have a few bits]
