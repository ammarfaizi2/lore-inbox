Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262057AbRENELM>; Mon, 14 May 2001 00:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262314AbRENELC>; Mon, 14 May 2001 00:11:02 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:54279 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S262247AbRENEKy>;
	Mon, 14 May 2001 00:10:54 -0400
Date: Mon, 14 May 2001 01:10:47 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] out_of_memory() fix
Message-ID: <Pine.LNX.4.21.0105140108380.4671-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

instead of walking the whole swap bitmap, out_of_memory()
might just as well check the nr_swap_pages variable which
is used by __get_swap_page() ...

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)


--- linux-2.4.5-pre1/mm/oom_kill.c.orig	Mon May 14 01:03:33 2001
+++ linux-2.4.5-pre1/mm/oom_kill.c	Mon May 14 01:06:56 2001
@@ -191,7 +191,6 @@
  */
 int out_of_memory(void)
 {
-	struct sysinfo swp_info;
 
 	/* Enough free memory?  Not OOM. */
 	if (nr_free_pages() > freepages.min)
@@ -201,8 +200,7 @@
 		return 0;
 
 	/* Enough swap space left?  Not OOM. */
-	si_swapinfo(&swp_info);
-	if (swp_info.freeswap > 0)
+	if (nr_swap_pages > 0)
 		return 0;
 
 	/* Else... */

