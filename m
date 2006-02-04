Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932563AbWBDU3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932563AbWBDU3Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 15:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932564AbWBDU3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 15:29:24 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:27861 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932563AbWBDU3Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 15:29:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=IEra5swDs99+1eDGlQCrHqqEUe98weLz9ytPFlpRsxHgBJw9d0znkJDkDKGxkqoa6g+IWgb7xu/46bwmIu8gH0C35k8MoZeGu185kQ8YuwY+Q+ihCpZPTeFO7r/eqg8c8TprfomRmXmETjRJ267XArNstHPZAmu14ZNWeaSklng=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Don't check pointers passed to vfree for null in pdaudiocf_pcm.c
Date: Sat, 4 Feb 2006 21:29:30 +0100
User-Agent: KMail/1.9
Cc: Jaroslav Kysela <perex@suse.cz>, Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602042129.30381.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't check pointers passed to vfree for null in pdaudiocf_pcm.c - it's pointless.


Signed-off-by: Jesper Juhl <Jesper.Juhl@Gmail.Com>
---

 sound/pcmcia/pdaudiocf/pdaudiocf_pcm.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

--- linux-2.6.16-rc2-git1-orig/sound/pcmcia/pdaudiocf/pdaudiocf_pcm.c	2006-02-04 14:44:23.000000000 +0100
+++ linux-2.6.16-rc2-git1/sound/pcmcia/pdaudiocf/pdaudiocf_pcm.c	2006-02-04 21:26:37.000000000 +0100
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
 



