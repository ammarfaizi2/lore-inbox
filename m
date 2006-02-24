Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbWBXUqj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbWBXUqj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 15:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbWBXUqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 15:46:39 -0500
Received: from zproxy.gmail.com ([64.233.162.203]:8391 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751090AbWBXUqi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 15:46:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=PJWQFjQlrQLwJ4d2qJqbvt5g/XSVQPeU7wBj4QAoeIIkLiUZczBkHagemUScF92QUkmqeSKOA7rt5Kt9IL2ilRLflO8i5BXQFdH0JDMHJMoz7oqMDWJYxWAa0/vwnjx0nX0r/9mf7knFwKNmMfqetS2k2NchuADZDpjxRFRvCZ8=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 01/13] don't check vfree argument for NULL in vx_pcm
Date: Fri, 24 Feb 2006 21:46:57 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200602242146.57413.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It's pointless checking pointers about to be passed to vfree() for NULL.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 sound/drivers/vx/vx_pcm.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

--- linux-2.6.16-rc4-mm2-orig/sound/drivers/vx/vx_pcm.c	2006-02-18 02:09:11.000000000 +0100
+++ linux-2.6.16-rc4-mm2/sound/drivers/vx/vx_pcm.c	2006-02-24 19:50:19.000000000 +0100
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
 



