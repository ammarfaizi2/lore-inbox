Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932560AbWBDUV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932560AbWBDUV4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 15:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbWBDUV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 15:21:56 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:22863 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932560AbWBDUVz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 15:21:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=MO+NMTAI8tDx8XoD50fFSvzFN51dcDVKD5T1ufM1Nva60jeH8OFJDwNpyA34wtAQz28IN7oyAVrZr0ZWpDP5OsYyDV+yEMY/tS4whWhTESx0OJzUYUHUJtDiNPWkjXUu7iNfZ1brvW86IpLLpWv/yuq3PmFiEcZInKRv5XNqUgM=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH]no need to check pointers passed to vfree() for NULL in sound/usb/usbaudio.c
Date: Sat, 4 Feb 2006 21:22:03 +0100
User-Agent: KMail/1.9
Cc: Takashi Iwai <tiwai@suse.de>, Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602042122.03187.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to check pointers passed to vfree() for NULL.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 sound/usb/usbaudio.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

--- linux-2.6.16-rc2-git1-orig/sound/usb/usbaudio.c	2006-02-04 14:44:23.000000000 +0100
+++ linux-2.6.16-rc2-git1/sound/usb/usbaudio.c	2006-02-04 21:19:03.000000000 +0100
@@ -725,10 +725,9 @@ static int snd_pcm_alloc_vmalloc_buffer(
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
 
