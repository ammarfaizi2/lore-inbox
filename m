Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315859AbSEGP5p>; Tue, 7 May 2002 11:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315397AbSEGP5o>; Tue, 7 May 2002 11:57:44 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:29824 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S315859AbSEGP5m>;
	Tue, 7 May 2002 11:57:42 -0400
Date: Tue, 7 May 2002 17:57:27 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] NLS: Invalid koi8-ru return values
Message-ID: <20020507155727.GA15298@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
  during my lurking around NLS code I found that KOI8-RU returns
character code instead of length of character for two characters.
Please apply.
					Petr Vandrovec
					vandrove@vc.cvut.cz

diff -urdN linux/fs/nls/nls_koi8-ru.c linux/fs/nls/nls_koi8-ru.c
--- linux/fs/nls/nls_koi8-ru.c	Mon May  6 03:37:52 2002
+++ linux/fs/nls/nls_koi8-ru.c	Tue May  7 10:02:26 2002
@@ -22,13 +22,14 @@
 	if ((uni & 0xffaf) == 0x040e || (uni & 0xffce) == 0x254c) {
 		/* koi8-ru and koi8-u differ only on two characters */
 		if (uni == 0x040e)
-			return 0xbe;
+			out[0] = 0xbe;
 		else if (uni == 0x045e)
-			return 0xae;
+			out[0] = 0xae;
 		else if (uni == 0x255d || uni == 0x256c)
 			return 0;
 		else
 			return p_nls->uni2char(uni, out, boundlen);
+		return 1;
 	}
 	else
 		/* fast path */
