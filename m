Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129367AbRAYXJz>; Thu, 25 Jan 2001 18:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129393AbRAYXJp>; Thu, 25 Jan 2001 18:09:45 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:48394 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S129367AbRAYXJb>; Thu, 25 Jan 2001 18:09:31 -0500
Date: Thu, 25 Jan 2001 23:09:23 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Ookhoi <ookhoi@dds.nl>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: pcmcia delay causes bootp not to work
In-Reply-To: <20010126000007.U21704@ookhoi.dds.nl>
Message-ID: <Pine.LNX.4.30.0101252307360.2734-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jan 2001, Ookhoi wrote:

> And unfortunately, the guy who mailed me didn't respond at my cry
> for help, so now I try the list again. :-)

Sorry, try this patch.

Index: drivers/pcmcia/yenta.c
===================================================================
RCS file: /inst/cvs/linux/drivers/pcmcia/Attic/yenta.c,v
retrieving revision 1.1.2.23
diff -u -r1.1.2.23 yenta.c
--- drivers/pcmcia/yenta.c	2000/12/05 13:30:42	1.1.2.23
+++ drivers/pcmcia/yenta.c	2001/01/25 23:07:35
@@ -855,11 +855,12 @@
 	   initialisation later. We can't do this here,
 	   because, er, because Linus says so :)
 	*/
-	socket->tq_task.routine = yenta_open_bh;
-	socket->tq_task.data = socket;
+	//	socket->tq_task.routine = yenta_open_bh;
+	//	socket->tq_task.data = socket;
 
 	MOD_INC_USE_COUNT;
-	schedule_task(&socket->tq_task);
+	//	schedule_task(&socket->tq_task);
+	yenta_open_bh(socket);
 
 	return 0;
 }

-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
