Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279781AbRJ0EXR>; Sat, 27 Oct 2001 00:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279782AbRJ0EXI>; Sat, 27 Oct 2001 00:23:08 -0400
Received: from mailgate5.cinetic.de ([217.72.192.165]:19095 "EHLO
	mailgate5.cinetic.de") by vger.kernel.org with ESMTP
	id <S279781AbRJ0EXA>; Sat, 27 Oct 2001 00:23:00 -0400
Message-Id: <m15xL0J-007qTxC@smtp.web.de>
Content-Type: text/plain;
  charset="iso-8859-15"
From: =?iso-8859-15?q?Ren=E9=20Scharfe?= <l.s.r@web.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] random.c bugfix
Date: Sat, 27 Oct 2001 06:21:59 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Linus Torvalds <torvalds@transmeta.com>, Alan Cox <alan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

there's a bug in random.c, I think. The third argument of
extract_entropy() is supposed to be the number of _bytes_ to extract,
while nwords contains the number of _bytes_ we want. This seems to lead
us to transfer n bytes of entropy and credit for n*4 bytes.

René



--- linux-2.4.14-pre2/drivers/char/random.c	Fri Oct 26 23:07:16 2001
+++ linux-2.4.14-pre2-rs/drivers/char/random.c	Sat Oct 27 05:36:23 2001
@@ -1253,7 +1253,7 @@
 			  r == sec_random_state ? "secondary" : "unknown",
 			  r->entropy_count, nbytes * 8);
 
-		extract_entropy(random_state, tmp, nwords, 0);
+		extract_entropy(random_state, tmp, nwords * 4, 0);
 		add_entropy_words(r, tmp, nwords);
 		credit_entropy_store(r, nwords * 32);
 	}

