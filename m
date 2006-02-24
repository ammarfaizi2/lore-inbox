Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbWBXUrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbWBXUrv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 15:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWBXUrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 15:47:35 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:40153 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751103AbWBXUrR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 15:47:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=e9BMxPWquCHdQH4ywNtbRKxFY2lbMgcZ4w8eUYDtz2Vf2clb4Tns/pYDMCLxa9mKm6NJl9k/t1LFq3IIY9b9t0aJXRa3PDFBJ/JP+WdaCbtCeKnH+qAQKqY57GrGURcsYIklfDkkR3mCRyOs2OcFzluwmdZhwCa4TXzjYq8T8n0=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 04/13] don't NULL-check vfree argument in pdaudiocf_pcm
Date: Fri, 24 Feb 2006 21:47:33 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@suse.cz>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200602242147.33636.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Don't check pointers passed to vfree for null in pdaudiocf_pcm.c


Signed-off-by: Jesper Juhl <Jesper.Juhl@Gmail.Com>
---

 sound/pcmcia/pdaudiocf/pdaudiocf_pcm.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

--- linux-2.6.16-rc4-mm2-orig/sound/pcmcia/pdaudiocf/pdaudiocf_pcm.c	2006-02-18 02:09:12.000000000 +0100
+++ linux-2.6.16-rc4-mm2/sound/pcmcia/pdaudiocf/pdaudiocf_pcm.c	2006-02-24 20:40:58.000000000 +0100
@@ -66,10 +66,9 @@ static int snd_pcm_alloc_vmalloc_buffer(
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
 


