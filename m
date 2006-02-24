Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932482AbWBXUst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbWBXUst (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 15:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbWBXUs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 15:48:29 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:63068 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932479AbWBXUsJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 15:48:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=MChp3hOl3ps1GsAl9Em+MNDZ90BLoZlpCb+XkwnAcs1/kr5nz5s1VcneJyU+jbmq9w69PfCeoLTzwivUT2ZAXd2APFmnN7pfw6ZH/X/YYq4Cu0/BjqMeyRqZxkt0+L4p4w94wGJar7pR0OqiDyF5vn6uwX655jacydmawwYNHMs=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 07/13] maestro3 vfree NULL check fixup
Date: Fri, 24 Feb 2006 21:48:27 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Zach Brown <zab@zabbo.net>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200602242148.27855.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


vfree() checks for NULL, no need to do it explicitly.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com
---

 sound/oss/maestro3.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.16-rc4-mm2-orig/sound/oss/maestro3.c	2006-02-24 19:25:49.000000000 +0100
+++ linux-2.6.16-rc4-mm2/sound/oss/maestro3.c	2006-02-24 20:59:19.000000000 +0100
@@ -2582,10 +2582,10 @@ static int alloc_dsp_suspendmem(struct m
 
     return 0;
 }
+
 static void free_dsp_suspendmem(struct m3_card *card)
 {
-   if(card->suspend_mem)
-       vfree(card->suspend_mem);
+    vfree(card->suspend_mem);
 }
 
 #else



