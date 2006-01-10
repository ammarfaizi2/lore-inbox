Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751000AbWAJNME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbWAJNME (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 08:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbWAJNMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 08:12:03 -0500
Received: from xproxy.gmail.com ([66.249.82.207]:31524 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751022AbWAJNL7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 08:11:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=AOcsWt+El+DbZX851BwONA1aLjpSoUabm+7elTPedAkp2LJKFZ+B2x8rccpfUyY3+3+FDwp+k3JxBB8nNR/EnmsEFUf/dI/nIO4g0z2GSKIDBjqFPJgo2Jl15zIrzjoQUPonHFbvqeg2DWUI/ZvFrLOOg4U8VzyBU+B2EYxU1B8=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-scsi@vger.kernel.org
Subject: [PATCH]Add scsi_add_host() failure handling for nsp32
Date: Tue, 10 Jan 2006 14:11:52 +0100
User-Agent: KMail/1.9
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Andrew Morton <akpm@osdl.org>,
       YOKOTA Hiroshi <yokota@netlab.is.tsukuba.ac.jp>,
       GOTO Masanori <gotom@debian.or.jp>, gotom@debian.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601101411.52585.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesper Juhl <jesper.juhl@gmail.com>

Add scsi_add_host() failure handling for nsp32
and silence warning.
  drivers/scsi/nsp32.c:2888: warning: ignoring return value of csi_add_host', declared with attribute warn_unused_result

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/scsi/nsp32.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

--- linux-2.6.15-mm2-orig/drivers/scsi/nsp32.c	2006-01-07 14:46:18.000000000 +0100
+++ linux-2.6.15-mm2/drivers/scsi/nsp32.c	2006-01-10 14:07:00.000000000 +0100
@@ -2885,7 +2885,12 @@ static int nsp32_detect(struct scsi_host
         }
 
 #if (LINUX_VERSION_CODE > KERNEL_VERSION(2,5,73))
-	scsi_add_host (host, &PCIDEV->dev);
+	ret = scsi_add_host (host, &PCIDEV->dev);
+	if (ret) {
+		printk(KERN_WARNING "nsp32: scsi_add_host failed\n");
+		scsi_host_put(host);
+		return ret;
+	}
 	scsi_scan_host(host);
 #endif
 	pci_set_drvdata(PCIDEV, host);





PS. Please CC me on replies from linux-scsi since I'm not subscribed there.

-- 
Jesper Juhl

