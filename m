Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbVI0SQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbVI0SQe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 14:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbVI0SQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 14:16:34 -0400
Received: from mx.laposte.net ([81.255.54.11]:30692 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S1750729AbVI0SQe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 14:16:34 -0400
Message-ID: <43398D1B.4080103@laposte.net>
Date: Tue, 27 Sep 2005 20:19:07 +0200
From: Laurent Meunier <meunier.laurent@laposte.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gregor Jasny <gjasny@web.de>
CC: mmcclell@bigfoot.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ov511-2.28 patch for 2.6.12 kernel compat.
References: <43392BF9.30906@laposte.net> <43397FF8.4090902@web.de>
In-Reply-To: <43397FF8.4090902@web.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 12)
>>              usb_unlink_urb(ov->sbuf[n].urb);
>> +#else
>> +            usb_unlink_urb(ov->sbuf[n].urb);
>> +#endif
> 
> 
> This lines look suspicous to me. Do you meant usb_kill_urb in the >= 
> 2.6.12 case?
> 
> Gregor
> 

Yes, it should be usb_kill_urb in the >= 2.6.12 case. I made a mistake, 
sorry for that.

diff -rbup ov511-2.28-orig/ovfx2.c ov511-2.28-new/ovfx2.c
--- ov511-2.28-orig/ovfx2.c     2004-07-16 01:32:08.000000000 +0200
+++ ov511-2.28-new/ovfx2.c      2005-09-27 20:12:54.000000000 +0200
@@ -1678,7 +1678,11 @@ ovfx2_unlink_bulk(struct usb_ovfx2 *ov)
         /* Unschedule all of the bulk td's */
         for (n = OVFX2_NUMSBUF - 1; n >= 0; n--) {
                 if (ov->sbuf[n].urb) {
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 12)
+                       usb_kill_urb(ov->sbuf[n].urb);
+#else
                         usb_unlink_urb(ov->sbuf[n].urb);
+#endif


Laurent
