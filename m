Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129597AbRADJBN>; Thu, 4 Jan 2001 04:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129867AbRADJBE>; Thu, 4 Jan 2001 04:01:04 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:33285 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S129597AbRADJAz>; Thu, 4 Jan 2001 04:00:55 -0500
Date: Thu, 4 Jan 2001 09:00:50 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: ludovic fernandez <ludovic.fernandez@sun.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.0-prerelease: preemptive kernel.
In-Reply-To: <3A53D863.53203DF4@sun.com>
Message-ID: <Pine.LNX.4.30.0101040859030.10966-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jan 2001, ludovic fernandez wrote:

+#if 1
+    /*
+     * I got some problems with PCMCIA initialization and a
+     * preemptive kernel;
+     * init_pcmcia_ds() beeing called before the completion
+     * of pending scheduled tasks. I don't know if this is the
+     * right fix though.
+     */
+    flush_scheduled_tasks();
+#endif


Not really the right fix, but it'll do. The right fix is probably to
register the socket immediately in yenta_open() rather than doing it from
the queued task. We just weren't brave enough to make that change though,
when it was working anyway.

-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
