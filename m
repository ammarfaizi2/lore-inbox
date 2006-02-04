Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932562AbWBDUZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932562AbWBDUZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 15:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932564AbWBDUZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 15:25:56 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:52121 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932562AbWBDUZ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 15:25:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=XtiegY2mUc6D64Oe+CuCEEWCmmrzkSUwazTPCENagrDMdSgDSZCFrUwvmzo2Pp6n8XCVoZv9earL+wiq/tdGreb2+6xHqRYcGo/FzYRaVpPzKuOIfb/i1raEyQwEoMsKokBAjPiW3eik/FETxAtRmQdxVu6nLeVOZAcwe31HmYM=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] no need to check pointers passed to vfree for NULL in sound/drivers/vx/vx_pcm.c
Date: Sat, 4 Feb 2006 21:26:03 +0100
User-Agent: KMail/1.9
Cc: Takashi Iwai <tiwai@suse.de>, Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602042126.03504.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's pointless checking pointers about to be passed to vfree() for NULL.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 sound/drivers/vx/vx_pcm.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

--- linux-2.6.16-rc2-git1-orig/sound/drivers/vx/vx_pcm.c	2006-02-04 14:44:23.000000000 +0100
+++ linux-2.6.16-rc2-git1/sound/drivers/vx/vx_pcm.c	2006-02-04 21:23:26.000000000 +0100
@@ -98,10 +98,9 @@ static int snd_pcm_alloc_vmalloc_buffer(
 static int snd_pcm_free_vmalloc_buffer(struct snd_pcm_substream *subs)
 {
 	struct snd_pcm_runtime *runtime = subs->runtime;
-	if (runtime->dma_area) {
-		vfree(runtime->dma_area);
-		runtime->dma_area = NULL;
-	}
+
+	vfree(runtime->dma_area);
+	runtime->dma_area = NULL;
 	return 0;
 }
 
