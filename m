Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266088AbRF2OSr>; Fri, 29 Jun 2001 10:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266089AbRF2OSd>; Fri, 29 Jun 2001 10:18:33 -0400
Received: from tsukuba.m17n.org ([192.47.44.130]:35207 "EHLO tsukuba.m17n.org")
	by vger.kernel.org with ESMTP id <S266088AbRF2OSU>;
	Fri, 29 Jun 2001 10:18:20 -0400
Date: Fri, 29 Jun 2001 23:18:00 +0900 (JST)
Message-Id: <200106291418.f5TEI0i09541@mule.m17n.org>
From: NIIBE Yutaka <gniibe@m17n.org>
To: "David S. Miller" <davem@redhat.com>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] swapin flush cache bug
In-Reply-To: <200106280104.f5S14XA05644@mule.m17n.org>
In-Reply-To: <200106270051.f5R0pkl19282@mule.m17n.org>
	<Pine.LNX.4.21.0106270710050.1291-100000@freak.distro.conectiva>
	<200106280007.f5S07qQ04446@mule.m17n.org>
	<20010628012349.L1554@redhat.com>
	<200106280041.f5S0fDr05278@mule.m17n.org>
	<15162.32433.598824.599520@pizda.ninka.net>
	<200106280104.f5S14XA05644@mule.m17n.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NIIBE Yutaka wrote:
 > I'll close the entry for MM bugzilla, it's not MM bug.

I've closed the entry.  It is SuperH cache flushing issue at I/O.

Then, thinking again, I think that my argument for do_swap_page() is
still valid.

	When the page is swapped in, the cache for the page is flushed
	__only if__ it's not found in swap cache.

I don't see any reason why we need to flush the cache here.

--- v2.4.6-pre5/mm/memory.c	Mon Jun 25 18:48:10 2001
+++ kernel/mm/memory.c	Tue Jun 26 14:48:15 2001
@@ -1109,8 +1109,6 @@ static int do_swap_page(struct mm_struct
 			return -1;
 		}
 		wait_on_page(page);
-		flush_page_to_ram(page);
-		flush_icache_page(vma, page);
 	}
 
 	/*
-- 
