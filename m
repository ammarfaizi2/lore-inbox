Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261527AbSL2UeG>; Sun, 29 Dec 2002 15:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261599AbSL2UeG>; Sun, 29 Dec 2002 15:34:06 -0500
Received: from packet.digeo.com ([12.110.80.53]:16373 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261527AbSL2UeF>;
	Sun, 29 Dec 2002 15:34:05 -0500
Message-ID: <3E0F5E2C.70F7D112@digeo.com>
Date: Sun, 29 Dec 2002 12:42:20 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: khromy <khromy@lnuxlab.ath.cx>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.53-mm3: xmms: page allocation failure. order:5, mode:0x20
References: <20021229202610.GA24554@lnuxlab.ath.cx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Dec 2002 20:42:21.0077 (UTC) FILETIME=[C8DFB450:01C2AF7A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

khromy wrote:
> 
> Running 2.5.53-mm3, I found the following in dmesg.  I don't remember
> getting anything like this with 2.5.53-mm3.
> 
> xmms: page allocation failure. order:5, mode:0x20

gack.  Someone is requesting 128k of memory with GFP_ATOMIC.  It fell
afoul of the reduced memory reserves.  It deserved to.

Could you please add this patch, and make sure that you have set
CONFIG_KALLSYMS=y?  This will find the culprit.

Thanks.


--- 25/mm/page_alloc.c~a	Sun Dec 29 12:40:30 2002
+++ 25-akpm/mm/page_alloc.c	Sun Dec 29 12:40:36 2002
@@ -572,6 +572,7 @@ nopage:
 		printk("%s: page allocation failure."
 			" order:%d, mode:0x%x\n",
 			current->comm, order, gfp_mask);
+		dump_stack();
 	}
 	return NULL;
 }

_
