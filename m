Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261192AbVGUDjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVGUDjN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 23:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbVGUDjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 23:39:13 -0400
Received: from hulk.hostingexpert.com ([69.57.134.39]:29577 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S261192AbVGUDjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 23:39:11 -0400
Message-ID: <42DF18CD.6000003@m1k.net>
Date: Wed, 20 Jul 2005 23:38:53 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Johannes Stezenbach <js@linuxtv.org>, Graeme Christie <graeme@sx.net.au>,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>, manu@kromtek.com,
       Gerd Knorr <kraxel@bytesex.org>
Subject: [2.6.13 PATCH] v4l: fix regression modprobe bttv freezes the computer
References: <42DC902E.9030009@sx.net.au> <42DCEE30.2020909@m1k.net> <20050719145804.GA19766@linuxtv.org>
In-Reply-To: <20050719145804.GA19766@linuxtv.org>
Content-Type: multipart/mixed;
 boundary="------------010309050105090904000906"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010309050105090904000906
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Johannes Stezenbach wrote:

>>Graeme Christie wrote:
>>
>>>It seems to me as if this bug has resurfaced again.
>>>
>It probably got lost because it was
>applied to the kernel which v4l was maintainer- and CVS-less.
>http://groups-beta.google.com/group/linux.kernel/msg/6a27dd3dc46a5b5b?dmode=source&hl=en
>
>It would be cool if you could apply this patch to v4l CVS and
>send it to akpm for inclusion into 2.6.13 (hopefully), as
>the "hang at boot" issue is quite nasty.
>
Fix Bug 4395: modprobe bttv freezes the computer

http://bugme.osdl.org/show_bug.cgi?id=4395. (link is dead now)
Date: Wed, 13 Apr 2005 03:20:08
Patch by Manu Abraham and Gerd Knorr:


--------------010309050105090904000906
Content-Type: text/plain;
 name="fix-regression-modprobe-bttv-freezes-the-computer.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-regression-modprobe-bttv-freezes-the-computer.patch"

Remove redundant bttv_reset_audio() which caused the computer to
freeze with some bt8xx based DVB cards when loading the bttv driver.

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Michael Krufky <mkrufky@m1k.net>

 linux/drivers/media/video/bttv-cards.c |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)

diff -u linux-2.6.13-rc3-git3/drivers/media/video/bttv-cards.c linux/drivers/media/video/bttv-cards.c
--- linux-2.6.13-rc3-git3/drivers/media/video/bttv-cards.c	2005-07-16 15:25:34.000000000 +0000
+++ linux/drivers/media/video/bttv-cards.c	2005-07-20 22:00:26.000000000 +0000
@@ -1,5 +1,5 @@
 /*
-    $Id: bttv-cards.c,v 1.53 2005/07/05 17:37:35 nsh Exp $
+    $Id: bttv-cards.c,v 1.54 2005/07/19 18:26:46 mkrufky Exp $
 
     bttv-cards.c
 
@@ -2772,8 +2772,6 @@
         }
 	btv->pll.pll_current = -1;
 
-	bttv_reset_audio(btv);
-
 	/* tuner configuration (from card list / autodetect / insmod option) */
  	if (UNSET != bttv_tvcards[btv->c.type].tuner_type)
 		if(UNSET == btv->tuner_type)

--------------010309050105090904000906--
