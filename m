Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278473AbRJOXb0>; Mon, 15 Oct 2001 19:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278475AbRJOXbH>; Mon, 15 Oct 2001 19:31:07 -0400
Received: from [207.21.185.24] ([207.21.185.24]:30480 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP
	id <S278474AbRJOXaz>; Mon, 15 Oct 2001 19:30:55 -0400
Message-ID: <3BCB70FA.5DA4CCEC@lnxw.com>
Date: Mon, 15 Oct 2001 16:27:54 -0700
From: Petko Manolov <pmanolov@Lnxw.COM>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.12 i686)
X-Accept-Language: en, bg
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [patch] page_alloc.c
In-Reply-To: <20011015234938.A14119@lightning.swansea.linux.org.uk>
Content-Type: multipart/mixed;
 boundary="------------B533999AC4575198E3C47AC6"
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------B533999AC4575198E3C47AC6
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

This micro patch removes redundant waitqueue_active() from
__alloc_pages()
It is not too much of a speedup, but still...


	Petko
--------------B533999AC4575198E3C47AC6
Content-Type: text/plain; charset=us-ascii;
 name="pagealloc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pagealloc.diff"

--- linux-2.4.12/mm/page_alloc.c.orig	Mon Oct 15 15:52:39 2001
+++ linux/mm/page_alloc.c	Mon Oct 15 15:53:45 2001
@@ -335,8 +335,7 @@
 
 	classzone->need_balance = 1;
 	mb();
-	if (waitqueue_active(&kswapd_wait))
-		wake_up_interruptible(&kswapd_wait);
+	wake_up_interruptible(&kswapd_wait);
 
 	zone = zonelist->zones;
 	for (;;) {

--------------B533999AC4575198E3C47AC6--

