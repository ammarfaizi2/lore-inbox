Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262420AbVGLWwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262420AbVGLWwG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 18:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262503AbVGLWYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 18:24:20 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:48164 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262423AbVGLWX1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 18:23:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ryzcREAInVVdrgmXzBTJZ6/39yQ6Rp5nVPnbMDLJJ+7dWjp8yA8GYV5Mcmve+sqzRlrKnnOqGLgWQJf+lPfbiWQ9rE75UTicMGwg7eI18c0oy5hGg3nEDnd7HgMtvXaF1+v7Jxhl47wg52KyG0FW2mdKFi26dgXTDJoIzgysgTI=
Message-ID: <5a4c581d0507121523123d6ecf@mail.gmail.com>
Date: Wed, 13 Jul 2005 00:23:27 +0200
From: Alessandro Suardi <alessandro.suardi@gmail.com>
Reply-To: Alessandro Suardi <alessandro.suardi@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: SLAB_DEBUG oopses 2.6.13-rc2-git3 (and seems to make BitTorrent loop)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Non fatal, box is still up and bittorrenting/ed2king on and off
 due to my DSL ISP being flaky in the last couple of days...

[65544.518710] slab error in cache_free_debugcheck(): cache
`radix_tree_node': double free, or memory outside object was
overwritten
[65544.519577]  [<c01033d7>] dump_stack+0x17/0x20
[65544.519938]  [<c013d2d6>] __slab_error+0x26/0x30
[65544.520309]  [<c013eb6e>] cache_free_debugcheck+0x16e/0x240
[65544.520739]  [<c013f5a1>] kmem_cache_free+0x31/0x70
[65544.521118]  [<c021873d>] radix_tree_delete+0x14d/0x180
[65544.521528]  [<c014c987>] __delete_from_swap_cache+0x27/0x70
[65544.521970]  [<c0141c67>] shrink_list+0x407/0x480
[65544.522334]  [<c0141e92>] shrink_cache+0x102/0x320
[65544.522703]  [<c01425db>] shrink_zone+0xab/0xe0
[65544.523054]  [<c0142a66>] balance_pgdat+0x226/0x380
[65544.523429]  [<c0142c9e>] kswapd+0xde/0x110
[65544.523756]  [<c0100ed5>] kernel_thread_helper+0x5/0x10
[65544.524158] c8a52b74: redzone 1: 0x970fc2a5, redzone 2: 0x170fc2a5.

I also get (a byproduct of the CONFIG_SLAB_DEBUG kernel,
 I'd assume, as it never happened before) my BitTorrent curses
 sessions suddenly stop refreshing the download/upload stats,
 strace looks like this:

...
mremap(0xb3b39000, 5246976, 5246976, MREMAP_MAYMOVE) = 0xb3b39000
gettimeofday({1121206671, 812488}, NULL) = 0
futex(0x80ffce8, FUTEX_WAKE, 1)         = 0
futex(0x80ffce8, FUTEX_WAKE, 1)         = 0
mremap(0xb3b39000, 5246976, 5246976, MREMAP_MAYMOVE) = 0xb3b39000
gettimeofday({1121206671, 813010}, NULL) = 0
futex(0x80ffce8, FUTEX_WAKE, 1)         = 0
futex(0x80ffce8, FUTEX_WAKE, 1)         = 0
mremap(0xb3b39000, 5246976, 5246976, MREMAP_MAYMOVE) = 0xb3b39000
gettimeofday({1121206671, 813501}, NULL) = 0
futex(0x80ffce8, FUTEX_WAKE, 1)         = 0
futex(0x80ffce8, FUTEX_WAKE, 1)         = 0
mremap(0xb3b39000, 5246976, 5246976, MREMAP_MAYMOVE) = 0xb3b39000
...

 forever, and ever.

uptodate FC3, K7-800, 256MB RAM, kernel 2.6.13-rc2-git3.

Is this just my DIMMs finally giving up or may this actually
 be a legitimate kernel bug ?

Thanks in advance, ciao,

--alessandro

 "When it comes to luck / you make your own
  Tonight I've got dirt on my hands
  But I'm building me a new home"

    (Bruce Springsteen - "Lucky Town")
