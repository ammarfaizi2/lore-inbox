Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbWBXUq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbWBXUq4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 15:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWBXUq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 15:46:56 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:26573 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751092AbWBXUqz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 15:46:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=JaBjLbPzAKOowJOKCaAbYV7d8U5OTo2ApUhxIIHej3sQPpWmyuG1JRoUIWzrTD+slTgr6Lw6QlwB7bpP8ZrnUyGxVt049hk/0jE9UpQ0Q07USgD0uY0Y5XLGOt2ohnO3coEyKiV1/mpvpok7n0Z3WblaB4Pt/XaaS1BV/3/jOeQ=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 02/13] don't check vfree arg for NULL in usbaudio
Date: Fri, 24 Feb 2006 21:47:11 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200602242147.11738.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to check pointers passed to vfree() for NULL.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 sound/usb/usbaudio.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

--- linux-2.6.16-rc4-mm2-orig/sound/usb/usbaudio.c	2006-02-24 19:25:50.000000000 +0100
+++ linux-2.6.16-rc4-mm2/sound/usb/usbaudio.c	2006-02-24 19:53:49.000000000 +0100
@@ -720,10 +720,9 @@ static int snd_pcm_alloc_vmalloc_buffer(
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
 


