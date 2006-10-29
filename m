Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965029AbWJ2F6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965029AbWJ2F6g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 01:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965030AbWJ2F6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 01:58:36 -0400
Received: from smtp-out.google.com ([216.239.45.12]:55680 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S965029AbWJ2F6f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 01:58:35 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:mime-version:to:cc:
	subject:content-type:content-transfer-encoding;
	b=PpUFo2cuJLYNgezENyt89QxaF9jHfvTFKYU8IvGeu+O2N3JJzRL5/Lxavxrt5hqSa
	RIUbUEqXmyV6hNZI4QkNA==
Message-ID: <454442DC.9050703@google.com>
Date: Sat, 28 Oct 2006 22:57:48 -0700
From: "Martin J. Bligh" <mbligh@google.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: linux-mm <linux-mm@kvack.org>, Andy Whitcroft <apw@shadowen.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Slab panic on 2.6.19-rc3-git5 (-git4 was OK)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-git4 was fine. -git5 is broken (on PPC64 blade)

As -rc2-mm2 seemed fine on this box, I'm guessing it's something
that didn't go via Andrew ;-( Looks like it might be something
JFS or slab specific. Bigger PPC64 box with different config
was OK though.

Full log is here: http://test.kernel.org/abat/59046/debug/console.log
Good -git4 run: http://test.kernel.org/abat/58997/debug/console.log

kernel BUG in cache_grow at mm/slab.c:2705!
cpu 0x1: Vector: 700 (Program Check) at [c0000000fffb7710]
     pc: c0000000000c8ad4: .cache_grow+0x64/0x4f0
     lr: c0000000000c91a8: .cache_alloc_refill+0x248/0x2cc
     sp: c0000000fffb7990
    msr: 8000000000021032
   current = 0xc0000000fffab800
   paca    = 0xc00000000047e780
     pid   = 1, comm = swapper
kernel BUG in cache_grow at mm/slab.c:2705!
enter ? for help
[c0000000fffb7a60] c0000000000c91a8 .cache_alloc_refill+0x248/0x2cc
[c0000000fffb7b20] c0000000000c9708 .kmem_cache_alloc_node+0xd0/0x10c
[c0000000fffb7bc0] c0000000000b69cc .__get_vm_area_node+0xcc/0x230
[c0000000fffb7c70] c0000000000b7640 .__vmalloc_node+0x60/0xc0
[c0000000fffb7d10] c0000000001ad4c8 .txInit+0x2a0/0x3a8
[c0000000fffb7e20] c00000000044c1ec .init_jfs_fs+0x78/0x27c
[c0000000fffb7ec0] c0000000000094c0 .init+0x1f4/0x3e4
[c0000000fffb7f90] c000000000027270 .kernel_thread+0x4c/0x68
