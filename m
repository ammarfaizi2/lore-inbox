Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270133AbRH1BzF>; Mon, 27 Aug 2001 21:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270135AbRH1Byy>; Mon, 27 Aug 2001 21:54:54 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:49934 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S270134AbRH1Byt>; Mon, 27 Aug 2001 21:54:49 -0400
Date: Mon, 27 Aug 2001 21:27:00 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Ingo Molnar <mingo@elte.hu>
Cc: Hugh Dickins <hugh@veritas.com>, lkml <linux-kernel@vger.kernel.org>
Subject: find_get_swapcache_page() question
Message-ID: <Pine.LNX.4.21.0108272123380.7385-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo,

Looking at find_get_swapcache_page(), I can't see _how_ we can find a
page on the swapper pagecache table that is not a swapcache page.

How that can happen ?

        spin_lock(&pagecache_lock);
        page = __find_page_nolock(mapping, offset, *hash);
        if (page) {
                spin_lock(&pagemap_lru_lock);
                if (PageSwapCache(page))
                        page_cache_get(page);
                else
                        page = NULL;   <-----
                spin_unlock(&pagemap_lru_lock);
        }
        spin_unlock(&pagecache_lock);

