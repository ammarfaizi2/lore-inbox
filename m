Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283180AbRK2LkD>; Thu, 29 Nov 2001 06:40:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283181AbRK2Ljx>; Thu, 29 Nov 2001 06:39:53 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:9094 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S283180AbRK2Ljq>;
	Thu, 29 Nov 2001 06:39:46 -0500
Date: Thu, 29 Nov 2001 06:39:40 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Jens Axboe <axboe@suse.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>, rwhron@earthlink.net
Subject: Re: 2.5.1-pre3 FIXED (was Re: 2.5.1-pre3 DON'T USE)
In-Reply-To: <20011129121431.D10601@suse.de>
Message-ID: <Pine.GSO.4.21.0111290634490.9516-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 29 Nov 2001, Jens Axboe wrote:

> - BIO_HASH remnant in LVM
> - bouncing should take multi-page bio's into account
> - bouncing should bounce pages _above_ the bounce_pfn :-)
> - remove bio_size() macro, it's just silly
> - multi-page bio fixes (BIO_CONTIG etc)
> 
> Linus, please apply.

I suspect that we will be better off if I send the next batch of
fs/super.c and fs/namespace.c cleanups in -pre4, then...

One obvious compile fix for -pre3, though:

--- C1-pre3/net/ipv4/ipconfig.c Tue Nov 20 18:47:27 2001
+++ linux/net/ipv4/ipconfig.c   Thu Nov 29 06:18:38 2001
@@ -47,6 +47,7 @@
 #include <linux/route.h>
 #include <linux/udp.h>
 #include <linux/proc_fs.h>
+#include <linux/major.h>
 #include <net/arp.h>
 #include <net/ip.h>
 #include <net/ipconfig.h>

- we had lost definition of UNNAMED_MAJOR there.

