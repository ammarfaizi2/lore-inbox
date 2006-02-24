Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbWBXUsB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbWBXUsB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 15:48:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWBXUsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 15:48:01 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:38379 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751103AbWBXUr7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 15:47:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=MUAYLkCafVxQtTcuQ3GZwA6w3rjkrNbuzdaNQpqh5Zae2Jh72pu0Ha8BCQN9r7VeWMQPF8dWOgcotURWrgYKS1DwbmGLfkrLMxn8JjdCXpUrOo25Y02w4RYChSZQGHc3LQRmOznWgSA8X69DwnW455nt+VXaeYrb+VvTeWa86ic=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 06/13] vfree NULL check fixup for sb_card
Date: Fri, 24 Feb 2006 21:48:17 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Paul Laufer <paul@laufernet.com>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200602242148.17525.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There's no need to check the vfree() argument for NULL.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 sound/oss/sb_card.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

--- linux-2.6.16-rc4-mm2-orig/sound/oss/sb_card.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.16-rc4-mm2/sound/oss/sb_card.c	2006-02-24 21:03:00.000000000 +0100
@@ -337,10 +337,8 @@ static void __exit sb_exit(void)
 	pnp_unregister_card_driver(&sb_pnp_driver);
 #endif
 
-	if (smw_free) {
-		vfree(smw_free);
-		smw_free = NULL;
-	}
+	vfree(smw_free);
+	smw_free = NULL;
 }
 
 module_init(sb_init);



