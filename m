Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265564AbSL1H54>; Sat, 28 Dec 2002 02:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265568AbSL1H5z>; Sat, 28 Dec 2002 02:57:55 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:41736 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265564AbSL1H5w>; Sat, 28 Dec 2002 02:57:52 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [BENCHMARK] vm swappiness with contest
Date: Sat, 28 Dec 2002 08:05:39 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <aujm0j$8fl$1@penguin.transmeta.com>
References: <200212271646.01487.conman@kolivas.net> <200212272100.44345.conman@kolivas.net> <200212281716.50535.conman@kolivas.net>
X-Trace: palladium.transmeta.com 1041062764 25887 127.0.0.1 (28 Dec 2002 08:06:04 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 28 Dec 2002 08:06:04 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200212281716.50535.conman@kolivas.net>,
Con Kolivas  <conman@kolivas.net> wrote:
>
>Is there something about the filesystem layer or elsewhere in the kernel that 
>could decay or fragment over time that only a reboot can fix? This would seem 
>to be a bad thing.

You might want to save and compare /proc/slabinfo before and after.

It might be things like the dcache growing out of control and not
shrinking gracefully under memory pressure, we've certainly had that
happen before. 

Or it might just be a memory leak, of course.  That too will be visible
in slabinfo if it's a slab/kmalloc leak (but obviously not if it's a
page allocator leak).

		Linus
