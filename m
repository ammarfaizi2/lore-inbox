Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130645AbRANFMX>; Sun, 14 Jan 2001 00:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130812AbRANFMO>; Sun, 14 Jan 2001 00:12:14 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:43535 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130645AbRANFMA>; Sun, 14 Jan 2001 00:12:00 -0500
Date: Sun, 14 Jan 2001 01:21:22 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: set_page_dirty/page_launder deadlock
Message-ID: <Pine.LNX.4.21.0101140108430.11917-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

While taking a look at page_launder()...

                 /* And re-start the thing.. */
                 spin_lock(&pagemap_lru_lock); 	<----------
                 if (result != 1)
                 	continue;
                 /* writepage refused to do anything */
                 set_page_dirty(page);
	      	 ^^^^^^^^^^^^^^^^^^^^
       		 goto page_active;
            }


set_page_dirty() may lock the pagecache_lock which means potential
deadlock since we have the pagemap_lru_lock locked.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
