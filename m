Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131363AbRAOWM5>; Mon, 15 Jan 2001 17:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131773AbRAOWMu>; Mon, 15 Jan 2001 17:12:50 -0500
Received: from d-dialin-1772.addcom.de ([62.96.166.92]:18926 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S131617AbRAOWMf>; Mon, 15 Jan 2001 17:12:35 -0500
Date: Mon, 15 Jan 2001 23:13:35 +0100 (CET)
From: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>
To: Ronny Buchmann <rbla@gmx.de>
cc: <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: bug (isdn-subsystem?) in 2.4.0
In-Reply-To: <3A63469D.9010403@gmx.de>
Message-ID: <Pine.LNX.4.30.0101152306480.2419-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jan 2001, Ronny Buchmann wrote:

> i have the following problem with kernel 2.4.0 (also with -ac6):
>
> kernel BUG at slab.c:1095!
> invalid operand: 0000
> CPU: 0

I could reproduce the problem, the appended patch fixes it here. Linus,
could you please apply this for 2.4.1?

> ......
>
> (if you need the other numbers or anything else, ask me, i can reproduce
> it easily)

A decoded oops would be nice the next time, see

	<your linux kernel source>/REPORTING-BUGS

However, you gave enough information for me to reproduce the problem, so
it's fine this time.

Thanks,
--Kai

--- linux-2.4.1-pre2/drivers/isdn/isdn_v110.c%	Sun Aug  6 21:43:42 2000
+++ linux-2.4.1-pre2/drivers/isdn/isdn_v110.c	Mon Jan 15 22:31:43 2001
@@ -102,7 +102,7 @@
 	int i;
 	isdn_v110_stream *v;

-	if ((v = kmalloc(sizeof(isdn_v110_stream), GFP_KERNEL)) == NULL)
+	if ((v = kmalloc(sizeof(isdn_v110_stream), GFP_ATOMIC)) == NULL)
 		return NULL;
 	memset(v, 0, sizeof(isdn_v110_stream));
 	v->key = key;
@@ -134,7 +134,7 @@
 	v->b = 0;
 	v->skbres = hdrlen;
 	v->maxsize = maxsize - hdrlen;
-	if ((v->encodebuf = kmalloc(maxsize, GFP_KERNEL)) == NULL) {
+	if ((v->encodebuf = kmalloc(maxsize, GFP_ATOMIC)) == NULL) {
 		kfree(v);
 		return NULL;
 	}


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
