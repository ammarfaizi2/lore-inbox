Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315946AbSHXMec>; Sat, 24 Aug 2002 08:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315988AbSHXMec>; Sat, 24 Aug 2002 08:34:32 -0400
Received: from ns2.sea.interquest.net ([66.135.144.2]:7341 "EHLO ns2.sea")
	by vger.kernel.org with ESMTP id <S315946AbSHXMeb>;
	Sat, 24 Aug 2002 08:34:31 -0400
Date: Sat, 24 Aug 2002 05:44:16 -0700
From: silvio@qualys.com
To: linux-kernel@vger.kernel.org
Subject: [PATCH] linux-2.4.19/drivers/ieee1394/video1394.c
Message-ID: <20020824054416.A3582@hamsec.aurora.sfo.interquest.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

avoid possible integer overflow

(also change the <= to just != since its using unsigned types anyway making
the sign test invalid here *shrug*)

--
Silvio

--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch.video1394"

--- linux-2.4.19/drivers/ieee1394/video1394.c	Sat Aug 24 05:37:15 2002
+++ linux-2.4.19-dev/drivers/ieee1394/video1394.c	Sat Aug 24 05:40:22 2002
@@ -871,13 +871,13 @@
 		}
 		ohci->ISO_channel_usage |= mask;
 
-		if (v.buf_size<=0) {
+		if (v.buf_size == 0 || v.buf_size > VIDEO1394_MAX_SIZE) {
 			PRINT(KERN_ERR, ohci->id,
 			      "Invalid %d length buffer requested",v.buf_size);
 			return -EFAULT;
 		}
 
-		if (v.nb_buffers<=0) {
+		if (v.nb_buffers == 0 || v.nb_buffers > VIDEO1394_MAX_SIZE) {
 			PRINT(KERN_ERR, ohci->id,
 			      "Invalid %d buffers requested",v.nb_buffers);
 			return -EFAULT;

--ReaqsoxgOBHFXBhH--
