Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314282AbSEMRCf>; Mon, 13 May 2002 13:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314325AbSEMRCe>; Mon, 13 May 2002 13:02:34 -0400
Received: from www.visioncare.co.sz ([196.28.7.66]:63105 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S314282AbSEMRCb>; Mon, 13 May 2002 13:02:31 -0400
Date: Mon, 13 May 2002 18:39:18 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Steve Kieu <haiquy@yahoo.com>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
        kernel <linux-kernel@vger.kernel.org>,
        William Lee Irwin III <wli@holomorphy.com>
Subject: Re: OOPS 2.4.19-pre7-ac4 (Was: strange things in kernel 2.4.19-pre7-ac4
 + preempt patch)
In-Reply-To: <Pine.LNX.4.44.0205131736240.353-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.4.44.0205131830080.353-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could you try this patch, Bill came across it in rmap testing.

Regards,
	Zwane

--- linux-2.4.19-pre-ac/drivers/char/drm/i810_dma.c.orig	Mon May 13 18:27:40 2002
+++ linux-2.4.19-pre-ac/drivers/char/drm/i810_dma.c	Mon May 13 18:28:37 2002
@@ -293,8 +293,8 @@
 {
 	if (page) {
 		struct page *p = virt_to_page(page);
-		put_page(p);
 		UnlockPage(p);
+		put_page(p);
 		free_page(page);
 	}
 }
--- linux-2.4.19-pre-ac/drivers/char/drm-4.0/i810_dma.c.orig	Mon May 13 18:37:37 2002
+++ linux-2.4.19-pre-ac/drivers/char/drm-4.0/i810_dma.c	Mon May 13 18:38:03 2002
@@ -291,9 +291,9 @@
 	struct page * p = virt_to_page(page);
 	if(page == 0UL) 
 		return;
-	
+
+	UnlockPage(p);	
 	put_page(p);
-	UnlockPage(p);
 	free_page(page);
 	return;
 }

-- 
http://function.linuxpower.ca
		


