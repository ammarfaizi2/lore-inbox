Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281066AbRKLW3X>; Mon, 12 Nov 2001 17:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281075AbRKLW3N>; Mon, 12 Nov 2001 17:29:13 -0500
Received: from posta2.elte.hu ([157.181.151.9]:60557 "HELO posta2.elte.hu")
	by vger.kernel.org with SMTP id <S281066AbRKLW3C>;
	Mon, 12 Nov 2001 17:29:02 -0500
Date: Tue, 13 Nov 2001 00:26:45 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>,
        Anton Blanchard <anton@samba.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch] arbitrary size memory allocator, memarea-2.4.15-D6
In-Reply-To: <3BF012BE.E82911C0@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0111130013510.21614-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 12 Nov 2001, Jeff Garzik wrote:

> What's wrong with bigphysarea patch or bootmem?  In the realm of frame
> grabbers this is a known and solved problem...

bootmem is a limited boot-time only thing, eg. it does not work from
modules. Nor is it generic enough to be eg. highmem-capable. It's not
really a fully capable allocator, i wrote bootmem.c rather as a simple
bootstap allocator, to be used to initialize the real allocator cleanly,
and to be used in some criticial subsystems that initialize before the
main allocator.

bigphysarea is a separate allocator, while alloc_memarea() shares the page
pool with the buddy allocator.

> With bootmem you know that (for example) 100GB of physically
> contiguous memory is likely to be available; and after boot, memory
> get fragmented and the likelihood of alloc_memarea success decreases
> drastically... just like bootmem.

the likelyhood of alloc_memarea() succeeding should be pretty good even on
loaded systems, once the two improvements i mentioned (zap clean pagecache
pages, reverse-flush & zap dirty pages) are added to it. Until then it's
indeed most effective at boot-time and deteriorates afterwards, so it
basically has bootmem's capabilities without most of the limitations of
bootmem.

	Ingo

