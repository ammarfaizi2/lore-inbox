Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130113AbRBMKyb>; Tue, 13 Feb 2001 05:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130385AbRBMKyV>; Tue, 13 Feb 2001 05:54:21 -0500
Received: from tsukuba.m17n.org ([192.47.44.130]:26003 "EHLO tsukuba.m17n.org")
	by vger.kernel.org with ESMTP id <S130113AbRBMKyM>;
	Tue, 13 Feb 2001 05:54:12 -0500
Date: Tue, 13 Feb 2001 19:53:11 +0900 (JST)
Message-Id: <200102131053.TAA11808@mule.m17n.org>
From: NIIBE Yutaka <gniibe@m17n.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: marcelo@conectiva.com.br (Marcelo Tosatti),
        torvalds@transmeta.com (Linus Torvalds),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (lkml)
Subject: Re: [PATCH] swapin flush cache bug
In-Reply-To: <200102130950.f1D9ohq01768@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.21.0102122107550.29855-100000@freak.distro.conectiva>
	<200102130950.f1D9ohq01768@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
 > What was the problem?  The old code seems to behave well on a virtual
 > address indexed virtual address tagged cache.

My case (SH-4) is: virtual address indexed, physical address tagged cache
(which has alias issue).

Suppose there's I/O to the physical page P asynchronously, and the
page is placed in the swap cache.  It remains cache entry, say,
indexed kernel virtual address K.  Then, process maps P at U.  U and K
(may) indexes differently.  The process will get the data from memory
(not the one in the cashe), if it's not flushed.
-- 
