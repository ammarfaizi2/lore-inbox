Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751656AbVJMT1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751656AbVJMT1y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 15:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751657AbVJMT1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 15:27:54 -0400
Received: from xproxy.gmail.com ([66.249.82.201]:50321 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751651AbVJMT1x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 15:27:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=U9RNuRm9rUZTqijUVt7K5rzDTcX0+2gEbHfsMJpgFKNjU6PsM3RKhqMZhpzRLT2zEmeh7vaCVWjd2YRAWsfvH2GOubbnFKqlEoVD4UOt5n7MHs2QxLDBxLW33/WksbzESsxy/1OK7LhafzgVd1xTCzm4IGKRfnTrpCUnlyhOQQ4=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [PATCH 13/14] Big kfree NULL check cleanup - sound
Date: Thu, 13 Oct 2005 21:30:43 +0200
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, Kyle McMartin <kyle@parisc-linux.org>,
       Thibaut Varene <varenet@parisc-linux.org>, perex@suse.cz,
       alsa-devel@alsa-project.org, Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200510132130.43423.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the sound/ part of the big kfree cleanup patch.

Remove pointless checks for NULL prior to calling kfree() in sound/.


Sorry about the long Cc: list, but I wanted to make sure I included everyone
who's code I've changed with this patch.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

Please see the initial announcement mail on LKML with subject
"[PATCH 00/14] Big kfree NULL check cleanup"
for additional details.

 sound/pci/ad1889.c        |    3 +--
 sound/pci/rme9652/hdspm.c |    3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

--- linux-2.6.14-rc4-orig/sound/pci/rme9652/hdspm.c	2005-10-11 22:41:41.000000000 +0200
+++ linux-2.6.14-rc4/sound/pci/rme9652/hdspm.c	2005-10-13 11:49:26.000000000 +0200
@@ -3563,8 +3563,7 @@ static int snd_hdspm_free(hdspm_t * hdsp
 		free_irq(hdspm->irq, (void *) hdspm);
 
 
-	if (hdspm->mixer)
-		kfree(hdspm->mixer);
+	kfree(hdspm->mixer);
 
 	if (hdspm->iobase)
 		iounmap(hdspm->iobase);
--- linux-2.6.14-rc4-orig/sound/pci/ad1889.c	2005-10-11 22:41:36.000000000 +0200
+++ linux-2.6.14-rc4/sound/pci/ad1889.c	2005-10-13 11:49:33.000000000 +0200
@@ -982,8 +982,7 @@ snd_ad1889_create(snd_card_t *card,
 	return 0;
 
 free_and_ret:
-	if (chip)
-		kfree(chip);
+	kfree(chip);
 	pci_disable_device(pci);
 
 	return err;



