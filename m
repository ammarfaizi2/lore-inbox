Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266868AbSKKR6Y>; Mon, 11 Nov 2002 12:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266869AbSKKR6Y>; Mon, 11 Nov 2002 12:58:24 -0500
Received: from packet.digeo.com ([12.110.80.53]:56029 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266868AbSKKR6X>;
	Mon, 11 Nov 2002 12:58:23 -0500
Message-ID: <3DCFF14F.3BAB81A6@digeo.com>
Date: Mon, 11 Nov 2002 10:05:03 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
CC: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kraxel@bytesex.org
Subject: Re: 2.5.47: Uninitialized timer in bttv code
References: <20021111182641.104131b6.us15@os.inf.tu-dresden.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Nov 2002 18:05:03.0942 (UTC) FILETIME=[DC132E60:01C289AC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Udo A. Steinberg" wrote:
> 
> Hi,
> 
> The bttv code in 2.5.47 triggers the following warning about use of
> uninitialized timer here. If a patch exists for this issue, I'll happily
> test it.
> 

Here you go.

I need to do another full pass across the tree to pick up the dynamically
allocated timers.


--- 25/drivers/media/video/bttv-driver.c~bttv-timer	Mon Nov 11 10:02:49 2002
+++ 25-akpm/drivers/media/video/bttv-driver.c	Mon Nov 11 10:03:03 2002
@@ -3225,6 +3225,7 @@ static int __devinit bttv_probe(struct p
         INIT_LIST_HEAD(&btv->capture);
         INIT_LIST_HEAD(&btv->vcapture);
 
+	init_timer(&btv->timeout);
 	btv->timeout.function = bttv_irq_timeout;
 	btv->timeout.data     = (unsigned long)btv;
 	

_
