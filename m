Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbVHQUGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbVHQUGH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 16:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbVHQUGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 16:06:07 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:39216 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751212AbVHQUGG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 16:06:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Sam5KW4aWKbFPHgsyqaXbCFBz+SPjfpP3EpGeiJtpwZRH4KVOxDy8pSF3pPV5kysteBT/kJAGSChzJziaBhvS0262X2QvKASzYnUqT+UBOd1Ho3rUE6eSvnESKef4tJRYxAnytgqGlXbB0gC+I41j2RGx5LOymaFA7IVkprB2lE=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH] small cleanup; remove check for NULL before kfree() in driver core
Date: Wed, 17 Aug 2005 22:06:34 +0200
User-Agent: KMail/1.8.2
Cc: Maneesh Soni <maneesh@in.ibm.com>, lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508172206.34913.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove needless checking of variable for NULL before calling kfree() on it.
Applies to 2.6.13-rc6-git9

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/base/class.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

--- linux-2.6.13-rc6-git9-orig/drivers/base/class.c	2005-08-17 21:53:53.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/base/class.c	2005-08-17 21:57:26.000000000 +0200
@@ -299,10 +299,8 @@ static void class_dev_release(struct kob
 
 	pr_debug("device class '%s': release.\n", cd->class_id);
 
-	if (cd->devt_attr) {
-		kfree(cd->devt_attr);
-		cd->devt_attr = NULL;
-	}
+	kfree(cd->devt_attr);
+	cd->devt_attr = NULL;
 
 	if (cls->release)
 		cls->release(cd);



