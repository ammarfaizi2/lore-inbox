Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265740AbUBKTtX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 14:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265744AbUBKTtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 14:49:23 -0500
Received: from wacom-nt2.wacom.com ([204.119.25.126]:22030 "EHLO
	wacom_nt2.WACOM.COM") by vger.kernel.org with ESMTP id S265740AbUBKTtQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 14:49:16 -0500
Message-ID: <28E6D16EC4CCD71196610060CF213AEB065BC2@wacom-nt2.wacom.com>
From: Ping Cheng <pingc@wacom.com>
To: "'Pete Zaitcev'" <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: RE: Wacom USB driver patch
Date: Wed, 11 Feb 2004 11:47:19 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nice catch, Pete. The Two "return"s should be replaced by "goto exit". 

Vojtech, should I make another patch or you can handle it with my previous
one?

Thanks, both of you!

Ping

-----Original Message-----
From: Pete Zaitcev [mailto:zaitcev@redhat.com] 
Sent: Wednesday, February 11, 2004 11:05 AM
To: Ping Cheng
Cc: linux-kernel@vger.kernel.org; vojtech@suse.cz
Subject: Re: Wacom USB driver patch


On Tue, 10 Feb 2004 17:23:11 -0800
Ping Cheng <pingc@wacom.com> wrote:

>  <<linuxwacom.patch>>

This looks much better, it's not line-wrapped.

I have one question though, about this part:

@@ -152,15 +150,103 @@ static void wacom_pl_irq(struct urb *urb

+                       /* was entered with stylus2 pressed */
+                       if (wacom->tool[1] == BTN_TOOL_RUBBER && !(data[4] &
0x20) ) {
+                               /* report out proximity for previous tool */
+                               input_report_key(dev, wacom->tool[1], 0);
+                               input_sync(dev);
+                               wacom->tool[1] = BTN_TOOL_PEN;
+                               return;
+                       }

Is it safe to just return without resubmitting the urb here?

@@ -231,8 +317,12 @@ static void wacom_graphire_irq(struct ur
+       /* check if we can handle the data */
+       if (data[0] == 99)
+               return;
+
        if (data[0] != 2)

Same here.

Also, please add the path to the patch, e.g. always use recursive diff.

-- Pete
