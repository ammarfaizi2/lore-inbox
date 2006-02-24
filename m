Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932477AbWBXUsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbWBXUsu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 15:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbWBXUst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 15:48:49 -0500
Received: from pproxy.gmail.com ([64.233.166.181]:64541 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932487AbWBXUsj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 15:48:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=MacMKDgweVeV8+KplAOVdHepoZB10PdQZJKiGyoH1GNEktI66/tw6Gd1Nx5MCYOOU2xuzNxDUAq8lHWiYEAx9ECf2d/hl25fy0KFv3Kgjttn7h5bI5EpNciDKMwGpnvpYi6ciJW1w8yslhCSbbxs8lb2Oct8k5iBbVc0hwtXJ1U=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 09/13] no need to check vfree arg for null in oss/sequencer
Date: Fri, 24 Feb 2006 21:48:53 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Hannu Savolainen <hannu@opensound.com>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200602242148.53534.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There's no need to check pointers for NULL before handing them to vfree().


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 sound/oss/sequencer.c |   13 +++----------
 1 files changed, 3 insertions(+), 10 deletions(-)

--- linux-2.6.16-rc4-mm2-orig/sound/oss/sequencer.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.16-rc4-mm2/sound/oss/sequencer.c	2006-02-24 21:04:46.000000000 +0100
@@ -1671,14 +1671,7 @@ void sequencer_init(void)
 
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



