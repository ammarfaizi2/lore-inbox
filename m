Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265379AbRGGSWl>; Sat, 7 Jul 2001 14:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266519AbRGGSWc>; Sat, 7 Jul 2001 14:22:32 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:6412 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S265379AbRGGSWZ>; Sat, 7 Jul 2001 14:22:25 -0400
Date: Sat, 7 Jul 2001 15:22:23 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [RFC-PATCH] split cache and swapcache statistics
Message-ID: <Pine.LNX.4.33L.0107071521240.17825-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

maybe we'll want to end the confusion and split the cached
and swap-cached statistics ...

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/



--- linux-2.4.6/fs/proc/proc_misc.c.orig	Sat Jul  7 15:17:42 2001
+++ linux-2.4.6/fs/proc/proc_misc.c	Sat Jul  7 15:19:31 2001
@@ -165,7 +165,8 @@
                 "MemFree:      %8lu kB\n"
                 "MemShared:    %8lu kB\n"
                 "Buffers:      %8lu kB\n"
-                "Cached:       %8u kB\n"
+                "Cached:       %8lu kB\n"
+		"SwapCached:   %8lu kB\n"
 		"Active:       %8u kB\n"
 		"Inact_dirty:  %8u kB\n"
 		"Inact_clean:  %8u kB\n"
@@ -180,7 +181,8 @@
                 K(i.freeram),
                 K(i.sharedram),
                 K(i.bufferram),
-                K(atomic_read(&page_cache_size)),
+                K(atomic_read(&page_cache_size) - swapper_space.nrpages),
+		K(swapper_space.nrpages),
 		K(nr_active_pages),
 		K(nr_inactive_dirty_pages),
 		K(nr_inactive_clean_pages()),

