Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132493AbRDNRl0>; Sat, 14 Apr 2001 13:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132496AbRDNRlQ>; Sat, 14 Apr 2001 13:41:16 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:23568 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S132493AbRDNRlB>; Sat, 14 Apr 2001 13:41:01 -0400
Date: Sat, 14 Apr 2001 12:59:40 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Christoph Rohland <cr@sap.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: shmem_getpage_locked() / swapin_readahead() race in 2.4.4-pre3
Message-ID: <Pine.LNX.4.21.0104141244510.1786-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

There is a nasty race between shmem_getpage_locked() and
swapin_readahead() with the new shmem code (introduced in 2.4.3-ac3 and
merged in the main tree in 2.4.4-pre3): 

shmem_getpage_locked() finds a page in the swapcache and moves it to the
pagecache as an shmem page, freeing the swapcache and the swap map entry
for this page. (which causes a BUG() in mm/shmem.c:353 since the swap
map entry is being used) 

In the meanwhile, swapin_readahead() is allocating a page and adding it to
the swapcache.

I don't see any clean fix for this one.

Suggestions ? 



