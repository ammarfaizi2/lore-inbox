Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130388AbRC0B5u>; Mon, 26 Mar 2001 20:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130432AbRC0B5k>; Mon, 26 Mar 2001 20:57:40 -0500
Received: from wilma.widomaker.com ([204.17.220.5]:43792 "EHLO
	wilma.widomaker.com") by vger.kernel.org with ESMTP
	id <S130388AbRC0B5V>; Mon, 26 Mar 2001 20:57:21 -0500
Message-ID: <3ABFF2C9.96BE799B@widomaker.com>
Date: Mon, 26 Mar 2001 20:54:17 -0500
From: "Anthony J. Battersby" <abatters@widomaker.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] one-line bugfix 2.4.2 iobuf.c
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Explanation:

The bufp pointer should be indexed rather than incremented because it is used
a few lines above as a base pointer to free successfully allocated items if
kmalloc fails.

-------- Begin Patch --------

--- fs/iobuf.c.orig     Wed Mar 21 10:12:36 2001
+++ fs/iobuf.c  Wed Mar 21 10:12:30 2001
@@ -55,7 +55,7 @@
                        return -ENOMEM;
                }
                kiobuf_init(iobuf);
-               *bufp++ = iobuf;
+               bufp[i] = iobuf;
        }
 
        return 0;

-------- End Patch --------

When replying, please CC me at abatters@widomaker.com since I am not subscribed to
the mailing list.

--Tony Battersby
