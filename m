Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265187AbSKVSMV>; Fri, 22 Nov 2002 13:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265191AbSKVSMV>; Fri, 22 Nov 2002 13:12:21 -0500
Received: from packet.digeo.com ([12.110.80.53]:13541 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265187AbSKVSMU>;
	Fri, 22 Nov 2002 13:12:20 -0500
Message-ID: <3DDE752A.EB4B7A49@digeo.com>
Date: Fri, 22 Nov 2002 10:19:22 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jochen Hein <jochen@jochen.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.5] pcnet_cs, uninitialized timer when removing
References: <87hee9u22k.fsf@gswi1164.jochen.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Nov 2002 18:19:22.0769 (UTC) FILETIME=[AE850810:01C29253]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jochen Hein wrote:
> 
> When I remove the card I get:
> 
> ...
> 
> Trace; c0121660 <check_timer_failed+40/4c>
> Trace; c6ab9e64 <[pcnet_cs]pcnet_release+0/74>

Thanks, I'll fix that up.


--- 25/drivers/net/pcmcia/pcnet_cs.c~timer-mopup	Fri Nov 22 10:16:49 2002
+++ 25-akpm/drivers/net/pcmcia/pcnet_cs.c	Fri Nov 22 10:17:09 2002
@@ -300,7 +300,8 @@ static dev_link_t *pcnet_attach(void)
     memset(info, 0, sizeof(*info));
     link = &info->link; dev = &info->dev;
     link->priv = info;
-    
+
+    init_timer(&link->release);
     link->release.function = &pcnet_release;
     link->release.data = (u_long)link;
     link->irq.Attributes = IRQ_TYPE_EXCLUSIVE;

_
