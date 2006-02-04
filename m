Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932555AbWBDTzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932555AbWBDTzm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 14:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932556AbWBDTzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 14:55:42 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:8540 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932555AbWBDTzm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 14:55:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=IrnQGKnEyPedrlNdJQz4DrBgrXzH/6cbsZKrHN1ihqHXeMHC5QTuEeJUOlqamBez6njOCaJb1JOkVMERkaVvP4hE4XG0EixH1aiN4yxxqGrRJiC7+WAoquCMd1oXXx30hMYM8Ud2aWAXAAc4dYk/Wt0lLBSeefg67ga2Cj0eKQ4=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][OSS] Don't check pointers about to be vfree()'d for NULL
Date: Sat, 4 Feb 2006 20:55:48 +0100
User-Agent: KMail/1.9
Cc: Hannu Savolainen <hannu@opensound.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602042055.49024.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to check pointers for NULL before handing them to vfree().


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 sound/oss/sequencer.c |   13 +++----------
 1 files changed, 3 insertions(+), 10 deletions(-)

--- linux-2.6.16-rc2-git1-orig/sound/oss/sequencer.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.16-rc2-git1/sound/oss/sequencer.c	2006-02-04 20:51:49.000000000 +0100
@@ -1671,14 +1671,7 @@
 
 void sequencer_unload(void)
 {
-	if(queue)
-	{
-		vfree(queue);
-		queue=NULL;
-	}
-	if(iqueue)
-	{
-		vfree(iqueue);
-		iqueue=NULL;
-	}
+	vfree(queue);
+	vfree(iqueue);
+	queue = iqueue = NULL;
 }


