Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261288AbTDATaS>; Tue, 1 Apr 2003 14:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262788AbTDATaS>; Tue, 1 Apr 2003 14:30:18 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:51144 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261288AbTDATaQ>; Tue, 1 Apr 2003 14:30:16 -0500
Message-ID: <3E89E94C.4040004@us.ibm.com>
Date: Tue, 01 Apr 2003 11:32:28 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (2.5.66-mm2) War on warnings
References: <19200000.1049210557@[10.10.2.4]> <20030401152703.GA21986@gtf.org> <25070000.1049213622@[10.10.2.4]>
Content-Type: multipart/mixed;
 boundary="------------060204050902040300020202"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060204050902040300020202
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

And whilst we're stomping warnings, here are a couple more I noticed in 
various compilations...

-Matt

--------------060204050902040300020202
Content-Type: text/plain;
 name="warning_fixes-2.5.66.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="warning_fixes-2.5.66.patch"

diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.66-vanilla/drivers/char/drm/r128_cce.c linux-2.5.66-warnings/drivers/char/drm/r128_cce.c
--- linux-2.5.66-vanilla/drivers/char/drm/r128_cce.c	Mon Mar 24 14:00:07 2003
+++ linux-2.5.66-warnings/drivers/char/drm/r128_cce.c	Mon Mar 31 11:55:16 2003
@@ -352,7 +352,7 @@
      			    entry->busaddr[page_ofs]);
 		DRM_DEBUG( "ring rptr: offset=0x%08x handle=0x%08lx\n",
 			   entry->busaddr[page_ofs],
-     			   entry->handle + tmp_ofs );
+     			   (unsigned long)entry->handle + tmp_ofs );
 	}
 
 	/* Set watermark control */
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.66-vanilla/drivers/net/tulip/interrupt.c linux-2.5.66-warnings/drivers/net/tulip/interrupt.c
--- linux-2.5.66-vanilla/drivers/net/tulip/interrupt.c	Mon Mar 24 14:00:10 2003
+++ linux-2.5.66-warnings/drivers/net/tulip/interrupt.c	Mon Mar 31 11:55:16 2003
@@ -198,7 +198,7 @@
 					       dev->name,
 					       le32_to_cpu(tp->rx_ring[entry].buffer1),
 					       tp->rx_buffers[entry].mapping,
-					       skb->head, temp);
+					       (unsigned long)skb->head, temp);
 				}
 #endif
 
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.66-vanilla/drivers/scsi/scsi_sysfs.c linux-2.5.66-warnings/drivers/scsi/scsi_sysfs.c
--- linux-2.5.66-vanilla/drivers/scsi/scsi_sysfs.c	Mon Mar 24 14:00:08 2003
+++ linux-2.5.66-warnings/drivers/scsi/scsi_sysfs.c	Mon Mar 31 11:56:02 2003
@@ -272,14 +272,17 @@
 	return 0; 
 }
 
+void scsi_rescan_device(struct scsi_device *);
 static ssize_t
 store_rescan_field (struct device *dev, const char *buf, size_t count) 
 {
 	int ret = ENODEV;
 	struct scsi_device *sdev;
 	sdev = to_scsi_device(dev);
-	if (sdev)
-		ret = scsi_rescan_device(sdev);
+	if (sdev){
+		ret = 0;
+		scsi_rescan_device(sdev);
+	}
 	return ret;
 }
 

--------------060204050902040300020202--

