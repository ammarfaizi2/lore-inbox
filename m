Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751037AbWCRVm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbWCRVm1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 16:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbWCRVm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 16:42:27 -0500
Received: from nproxy.gmail.com ([64.233.182.194]:49187 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751001AbWCRVm0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 16:42:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=OFGJ7iGyGu7Gt+beEEuLFUujZA8lns3h/vuhHF2O2YQk18ywMiWFrXH4QBduDjGwl1+h4WKAVs7wqcUeEd3DiEFQk16ZNWg08Xy7XWb4ivKcHr3NYW4d5JO0U508p36F05awiNgC2fqvGJIbflJvgESeWPbO9Kk1wiL0IUx02IY=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix potential return of uninitialized variable in scsi_scan   (resend)
Date: Sat, 18 Mar 2006 22:42:52 +0100
User-Agent: KMail/1.9.1
Cc: Eric Youngdale <eric@andante.org>,
       "James E. J. Bottomley" <James.Bottomley@hansenpartnership.com>,
       linux-scsi@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603182242.52507.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

( The patch below was already send on March 9, 2006. )
( This is a resend, re-diff'ed against 2.6.16-rc6    )


The coverity checker found out that we potentially return sdev uninitialized.
This should fix coverity #879

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/scsi/scsi_scan.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

--- linux-2.6.16-rc6-orig/drivers/scsi/scsi_scan.c	2006-03-12 14:19:00.000000000 +0100
+++ linux-2.6.16-rc6/drivers/scsi/scsi_scan.c	2006-03-18 22:37:53.000000000 +0100
@@ -1277,7 +1277,9 @@ struct scsi_device *__scsi_add_device(st
 					     hostdata);
 		if (res != SCSI_SCAN_LUN_PRESENT)
 			sdev = ERR_PTR(-ENODEV);
-	}
+	} else 
+		sdev = ERR_PTR(-EACCES);
+
 	mutex_unlock(&shost->scan_mutex);
 	scsi_target_reap(starget);
 	put_device(&starget->dev);


