Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317448AbSGOMOT>; Mon, 15 Jul 2002 08:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317450AbSGOMOS>; Mon, 15 Jul 2002 08:14:18 -0400
Received: from conn6m.toms.net ([64.32.246.219]:2532 "EHLO conn6m.toms.net")
	by vger.kernel.org with ESMTP id <S317448AbSGOMOR>;
	Mon, 15 Jul 2002 08:14:17 -0400
Date: Mon, 15 Jul 2002 08:17:02 -0400 (EDT)
From: Tom Oehser <tom@toms.net>
To: Christian Ludwig <cl81@gmx.net>
cc: Daniel Phillips <phillips@arcor.de>, Ville Herva <vherva@niksula.hut.fi>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: bzip2 support against 2.4.18
In-Reply-To: <009701c22bc8$c8bd54e0$1c6fa8c0@hyper>
Message-ID: <Pine.LNX.4.44.0207150807450.9793-100000@conn6m.toms.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>>Does your mod of my patch support configuring the normal
>>>vs. "small" option?  Also, does it support choosing the
>>>compression-level-number?  Does it support using gzip/bzip2 one
>>>for the kernel and the other for the ramdisk in either combination?
>>>My original patch was only "small", disabled gzip, and I think used
>>>"-9" compression for both the kernel and the ramdisk.

> Choosing a compression level is (still) not supported, but choosing any
> combination of gzip/bzip2 is already implemented. I wonder if it is useful
> to have compression-level-numbers? The patch uses '-9' compression in any
> case (gzip/bzip2 kernel/ramdisk).

It is definitely useful to be able to control the compression
number, as it has drastic effects on decompression memory
requirements.  Especially between, say, -6 and -9, there is a
lot of memory usage increase without a lotta more compression,
controlling this may let your kernel decompress on a 4MB machine
it might not otherwise work on.  Consider:

                  Compress   Decompress   Decompress   Corpus
           Flag     usage      usage       -s usage     Size

            -1      1200k       500k         350k      914704
            -2      2000k       900k         600k      877703
            -3      2800k      1300k         850k      860338
            -4      3600k      1700k        1100k      846899
            -5      4400k      2100k        1350k      845160
            -6      5200k      2500k        1600k      838626
            -7      6100k      2900k        1850k      834096
            -8      6800k      3300k        2100k      828642
            -9      7600k      3700k        2350k      828642

Leaving it at -s only is probably OK, also, you would need major rework
of the patch to support the fast option, as I removed all that code
completely, it has alternate routines for much of bzip2, but supporting
control of the compression level will be really easy, since it only
affects the actual bzip2ing in the Makefile.

-Tom

