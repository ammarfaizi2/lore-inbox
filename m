Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261495AbULYLBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbULYLBZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 06:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbULYLBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 06:01:25 -0500
Received: from aun.it.uu.se ([130.238.12.36]:16579 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261495AbULYLBW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 06:01:22 -0500
Date: Sat, 25 Dec 2004 12:01:18 +0100 (MET)
Message-Id: <200412251101.iBPB1IpP009024@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: fw@deneb.enyo.de, juhl-lkml@dif.dk
Subject: Re: [PATCH] fix inlining related build failures in mxser.c
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Dec 2004 14:54:43 +0100, Florian Weimer wrote:
>* Jesper Juhl:
>
>>> Add -funit-at-a-time to the CFLAGS, and the compiler is happy.
>>> 
>> But, does unit-at-a-time work reliably for all compilers on all archs back 
>> to and including gcc 2.95.3 ? 
>
>Unit-at-a-time is only available in GCC 3.4 and above.

The problem with unit-at-a-time isn't compiler availability,
but the fact that at least with gcc-3.4 on x86 it causes
significant stack usage increases, which in the kernel lead
to stack overflow problems. This is not a theoretical issue,
the overflows have been observed in normal kernels.

So wrt inlining failures, the correct fix is to remove the
inlines or rearrange the code to allow inlining w/o unit-at-a-time.

/Mikael
