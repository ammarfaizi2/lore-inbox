Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273213AbRIYTum>; Tue, 25 Sep 2001 15:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273455AbRIYTuc>; Tue, 25 Sep 2001 15:50:32 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:6917 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S273213AbRIYTuW>; Tue, 25 Sep 2001 15:50:22 -0400
Date: Tue, 25 Sep 2001 14:49:40 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>, Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Locking comment on shrink_caches()
Message-ID: <Pine.LNX.4.21.0109251446210.1495-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrea, 


Do you really need to do this ? 

                if (unlikely(!spin_trylock(&pagecache_lock))) {
                        /* we hold the page lock so the page cannot go away from under us */
                        spin_unlock(&pagemap_lru_lock);

                        spin_lock(&pagecache_lock);
                        spin_lock(&pagemap_lru_lock);
                }

Have you actually seen bad hold times of pagecache_lock by
shrink_caches() ? 

Its just that I prefer clear locking without those "tricks". (easier to
understand and harder to miss subtle details)

