Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132304AbRAYXLf>; Thu, 25 Jan 2001 18:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135339AbRAYXLP>; Thu, 25 Jan 2001 18:11:15 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:48906 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S129393AbRAYXLM>; Thu, 25 Jan 2001 18:11:12 -0500
Date: Thu, 25 Jan 2001 23:11:09 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Ookhoi <ookhoi@dds.nl>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: pcmcia delay causes bootp not to work
In-Reply-To: <20010126000007.U21704@ookhoi.dds.nl>
Message-ID: <Pine.LNX.4.30.0101252310370.2734-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Er... no, don't try that patch. It'll oops. Try this instead.

--- drivers/pcmcia/yenta.c	2000/12/05 13:30:42	1.1.2.23
+++ drivers/pcmcia/yenta.c	2001/01/25 23:10:35
@@ -859,7 +859,8 @@
 	socket->tq_task.data = socket;
 
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
