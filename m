Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311247AbSDDHTK>; Thu, 4 Apr 2002 02:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311269AbSDDHTB>; Thu, 4 Apr 2002 02:19:01 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22789 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S311247AbSDDHSp>;
	Thu, 4 Apr 2002 02:18:45 -0500
Message-ID: <3CABFE55.9@mandrakesoft.com>
Date: Thu, 04 Apr 2002 02:18:45 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: flaniganr@intel.co.jp
CC: linux-kernel@vger.kernel.org, jt@hpl.hp.com, dhinds@zen.stanford.edu
Subject: Re: [PATCH] 2.5.8-pre1 wavelan_cs
In-Reply-To: <87vgb8x8bt.fsf@hazuki.jp.intel.com>
Content-Type: multipart/mixed;
 boundary="------------060002050801010507000008"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060002050801010507000008
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

flaniganr@intel.co.jp wrote:
> not sure if i did this right, so if you 
> have any suggestions/comments please tell me.
> 
> Basically 2.5.8-pre1 fails to compile with:
> 
> In file included from wavelan_cs.c:59:
> wavelan_cs.p.h:495:33: warning: extra tokens at end of #undef directive
> wavelan_cs.c: In function `wv_pcmcia_config':
> wavelan_cs.c:4480: structure has no member named `rmem_start'
> wavelan_cs.c:4482: structure has no member named `rmem_end'
> make[3]: *** [wavelan_cs.o] Error 1

not needed, just delete the unused references to rmem_{start,end}.
(see attached patch)

	Jeff




--------------060002050801010507000008
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff -Nru a/drivers/net/wireless/wavelan_cs.c b/drivers/net/wireless/wavelan_cs.c
--- a/drivers/net/wireless/wavelan_cs.c	Thu Apr  4 02:17:38 2002
+++ b/drivers/net/wireless/wavelan_cs.c	Thu Apr  4 02:17:38 2002
@@ -4477,9 +4477,8 @@
 	  break;
 	}
 
-      dev->rmem_start = dev->mem_start =
-	  (u_long)ioremap(req.Base, req.Size);
-      dev->rmem_end = dev->mem_end = dev->mem_start + req.Size;
+      dev->mem_start = (u_long)ioremap(req.Base, req.Size);
+      dev->mem_end = dev->mem_start + req.Size;
 
       mem.CardOffset = 0; mem.Page = 0;
       i = CardServices(MapMemPage, link->win, &mem);

--------------060002050801010507000008--

