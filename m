Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129752AbRB0Si7>; Tue, 27 Feb 2001 13:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129747AbRB0Sit>; Tue, 27 Feb 2001 13:38:49 -0500
Received: from host217-32-154-203.hg.mdip.bt.net ([217.32.154.203]:56580 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S129754AbRB0Sid>;
	Tue, 27 Feb 2001 13:38:33 -0500
Date: Tue, 27 Feb 2001 18:38:08 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: [patch-2.4.2] bugfix -- ENXIO for read/write beyond end of raw device
In-Reply-To: <Pine.LNX.4.21.0011021622210.2677-100000@saturn.homenet>
Message-ID: <Pine.LNX.4.21.0102271831540.751-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Yes, I know that Stephen had fixed this bug ages ago but, nevertheless, it
is still present in 2.4.2 and I don't know about his plans for resending
the patch -- but it is a part of the set I maintain so I just wanted to
bring it to your attention. Small bug, small obvious fix -- why not
consider it sooner rather than later?

Regards,
Tigran

diff -urN -X dontdiff linux/drivers/char/raw.c vmfs/drivers/char/raw.c
--- linux/drivers/char/raw.c	Mon Oct  2 04:35:15 2000
+++ vmfs/drivers/char/raw.c	Thu Feb 22 07:21:26 2001
@@ -277,8 +277,11 @@
 	
 	if ((*offp & sector_mask) || (size & sector_mask))
 		return -EINVAL;
-	if ((*offp >> sector_bits) > limit)
+	if ((*offp >> sector_bits) >= limit) {
+		if (size)
+			return -ENXIO;
 		return 0;
+	}
 
 	/* 
 	 * We'll just use one kiobuf

