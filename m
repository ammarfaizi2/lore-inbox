Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285965AbRLYXgE>; Tue, 25 Dec 2001 18:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285972AbRLYXfx>; Tue, 25 Dec 2001 18:35:53 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:46605 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S285965AbRLYXfg>;
	Tue, 25 Dec 2001 18:35:36 -0500
Date: Tue, 25 Dec 2001 21:35:14 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: <linux-mm@kvack.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH *] rmap based VM version 8
Message-ID: <Pine.LNX.4.33L.0112252132510.12081-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The 8th version of the reverse mapping based VM is now available.
This is an attempt at making a more robust and flexible VM
subsystem, while cleaning up a lot of code at the time. The patch
is available from:

           http://surriel.com/patches/2.4/2.4.16-rmap-8
and        http://surriel.com/patches/2.4/2.4.17-rmap-8
and        http://linuxvm.bkbits.net/


Since William Lee Irwin has contributed a whole bunch of small
VM cleanups over the last few days and Ted T'so updated his
bitkeeper tree of the 2.4 kernel, I guess it was time to prepare
a little christmas present in the form of the rmap-8 patch, against
both 2.4.16 and 2.4.17.


My big TODO items for a next release are:
  - fix page_launder() so it doesn't submit the whole
    inactive_dirty list for writeout in one go
  - tune the balancing, under some strange loads I seem
    to be able to trigger a livelock

rmap 8:
  - add ANY_ZONE to the balancing functions to improve
    kswapd's balancing a bit                              (me)
  - regularize some of the maximum loop bounds in
    vmscan.c for cosmetic purposes                        (William Lee Irwin)
  - move page_address() to architecture-independent
    code, now the removal of page->virtual is portable    (William Lee Irwin)
  - speed up free_area_init_core() by doing a single
    pass over the pages and not using atomic ops          (William Lee Irwin)
  - documented the buddy allocator in page_alloc.c        (William Lee Irwin)
rmap 7:
  - clean up and document vmscan.c                        (me)
  - reduce size of page struct, part one                  (William Lee Irwin)
  - add rmap.h for other archs (untested, not for ARM)    (me)
rmap 6:
  - make the active and inactive_dirty list per zone,
    this is finally possible because we can free pages
    based on their physical address                       (William Lee Irwin)
  - cleaned up William's code a bit                       (me)
  - turn some defines into inlines and move those to
    mm_inline.h (the includes are a mess ...)             (me)
  - improve the VM balancing a bit                        (me)
  - add back inactive_target to /proc/meminfo             (me)
rmap 5:
  - fixed recursive buglet, introduced by directly
    editing the patch for making rmap 4 ;)))              (me)
rmap 4:
  - look at the referenced bits in page tables            (me)
rmap 3:
  - forgot one FASTCALL definition                        (me)
rmap 2:
  - teach try_to_unmap_one() about mremap()               (me)
  - don't assign swap space to pages with buffers         (me)
  - make the rmap.c functions FASTCALL / inline           (me)
rmap 1:
  - fix the swap leak in rmap 0                           (Dave McCracken)
rmap 0:
  - port of reverse mapping VM to 2.4.16                  (me)

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

