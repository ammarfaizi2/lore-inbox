Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932346AbVIJWnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbVIJWnk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 18:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbVIJWnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 18:43:39 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:5013 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932350AbVIJWnS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 18:43:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=HETrQjWxCJt17J6itZoPZ8YWkzohm2FQRcNF17SYRuanWrYjz0+SQSMJiAtt4wtlYcgq8Tp8OM5TdGTulaEyKqM4kxqyXypXvaW7AfttWMSC0edJbkn/ELllgdRSN6lb6z5lSRz0zbjRcVVkmaZvIUpnm3Gut+KSAfz0NdEnUdc=
Date: Sun, 11 Sep 2005 02:53:07 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Antonino Daplas <adaplas@pol.net>, Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix breakage on ppc{,64} by "nvidiafb: Fallback to firmware EDID"
Message-ID: <20050910225307.GA7654@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix

drivers/video/nvidia/nv_of.c:34: error: conflicting types for 'nvidia_probe_i2c_connector'
drivers/video/nvidia/nv_proto.h:38: error: previous declaration of 'nvidia_probe_i2c_connector' was here

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/video/nvidia/nv_of.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

--- linux-vanilla/drivers/video/nvidia/nv_of.c
+++ linux-nvidia/drivers/video/nvidia/nv_of.c
@@ -30,8 +30,9 @@
 void nvidia_create_i2c_busses(struct nvidia_par *par) {}
 void nvidia_delete_i2c_busses(struct nvidia_par *par) {}
 
-int nvidia_probe_i2c_connector(struct nvidia_par *par, int conn, u8 **out_edid)
+int nvidia_probe_i2c_connector(struct fb_info *info, int conn, u8 **out_edid)
 {
+	struct nvidia_par *par = info->par;
 	struct device_node *dp;
 	unsigned char *pedid = NULL;
 	unsigned char *disptype = NULL;

