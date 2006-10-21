Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030385AbWJUKCB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030385AbWJUKCB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 06:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030387AbWJUKCB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 06:02:01 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:40910 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S1030385AbWJUKCA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 06:02:00 -0400
From: Ismail Donmez <ismail@pardus.org.tr>
Organization: TUBITAK/UEKAE
To: linux-kernel@vger.kernel.org
Subject: [PATCH] scsi/scsi.h protect scsi_to_u32 function by ifdef __KERNEL__
Date: Sat, 21 Oct 2006 13:02:07 +0300
User-Agent: KMail/1.9.5
Cc: David Woodhouse <dwmw2@infradead.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_gAfOFljaeEbWs+G"
Message-Id: <200610211302.08574.ismail@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_gAfOFljaeEbWs+G
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

include/scsi/scsi.h defines scsi_to_u32 function like this:

 static inline u32 scsi_to_u32(u8 *ptr)

But the definition of u8 is protected by ifdef __KERNEL__ in asm/types.h hence 
this whole function should be procted as well. This fixes compilation of 
cdrtools with latest kernel-headers GIT tree.

Signed-off-by: Ismail Donmez <ismail@pardus.org.tr>


--Boundary-00=_gAfOFljaeEbWs+G
Content-Type: text/x-diff;
  charset="utf-8";
  name="1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="1.patch"

diff --git a/include/scsi/scsi.h b/include/scsi/scsi.h
index 84a6d5f..0ce924a 100644
--- a/include/scsi/scsi.h
+++ b/include/scsi/scsi.h
@@ -429,10 +429,12 @@ #define SCSI_IOCTL_GET_BUS_NUMBER	0x5386
 /* Used to obtain the PCI location of a device */
 #define SCSI_IOCTL_GET_PCI		0x5387
 
+#ifdef __KERNEL__
 /* Pull a u32 out of a SCSI message (using BE SCSI conventions) */
 static inline u32 scsi_to_u32(u8 *ptr)
 {
 	return (ptr[0]<<24) + (ptr[1]<<16) + (ptr[2]<<8) + ptr[3];
 }
+#endif
 
 #endif /* _SCSI_SCSI_H */

--Boundary-00=_gAfOFljaeEbWs+G--
