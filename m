Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264731AbSJUETE>; Mon, 21 Oct 2002 00:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264730AbSJUETE>; Mon, 21 Oct 2002 00:19:04 -0400
Received: from boo-mda02.boo.net ([216.200.67.22]:9488 "EHLO boo-mda02.boo.net")
	by vger.kernel.org with ESMTP id <S264731AbSJUETB>;
	Mon, 21 Oct 2002 00:19:01 -0400
Message-Id: <3.0.6.32.20021021003415.007e6c30@boo.net>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Mon, 21 Oct 2002 00:34:15 -0400
To: linux-mm@kvack.org
From: Jason Papadopoulos <jasonp@boo.net>
Subject: [PATCH] page coloring for 2.4.19 kernel
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello. This is a re-diff of the page coloring patch I've
been developing for the linux kernel. The actual changes
are very minor (small cleanups, added a license, small linked
list changes), and it works fine on my test box (at least it
passes all the tests that older patches passed).

www.boo.net/~jasonp/page_color-2.2.20-20020108.patch
www.boo.net/~jasonp/page_color-2.4.17-20020113.patch
www.boo.net/~jasonp/page_color-2.4.18-20020705.patch
www.boo.net/~jasonp/page_color-2.4.19-20021020.patch

At this point I'm getting a bit dissatisfied with the state of
the patch...the ideal for me would be to make it completely invisible.
Just type in the cache size as a kernel boot parameter and off it
goes; no starting or stopping, and no worries about moving all the 
free list pointers over to other data structures and then moving them
all back again when you don't want page coloring anymore. You should
*always* want page coloring :)

That unfortunately would require replacing lots of low-level MM code
that I barely understand (sorry, beginning kernel hacker). And you run
into a chicken-and-egg problem in that maximum cache efficiency requires
either 

1. Knowing the cache size early in the boot process, or 

2. Statically allocating a huge number of colors that may be overkill for
   your particular machine.

I also want to make some allowances for NUMA systems and systems with
discontiguous memory. What's a sensible way to allocate pages by color 
when there are possibly many different nodes? Should each zone have a 
round-robin counter of its own? Or should each process have its own 
counter like it does now, and grab consecutive colors from each zone
no matter how far away the physical memory is?

Where do you insert custom boot flags in the 2.4 kernel? The 2.2 kernel
interface for that stuff seems to have disappeared.

I'm not subscribed to LKML, so please cc responses to this email address.

Thanks,
jasonp
