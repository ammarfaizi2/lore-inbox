Return-Path: <linux-kernel-owner+w=401wt.eu-S933223AbWLaWOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933223AbWLaWOV (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 17:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932790AbWLaWOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 17:14:21 -0500
Received: from wx-out-0506.google.com ([66.249.82.227]:63475 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933223AbWLaWOU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 17:14:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:organization:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=G1SaY0D5CgpGBA1biEH32dMq1xYaBDsm0Vj1W1wHFfcoPJxWtJrnHv7nMAGs5rxZf0KTMi3VOrR/VK466FmEUY3MUAoHvAbjf+w7XN2S3KmwwHDygAM8qqVuB0cWfMqraLgBkGcgeYey/Q/8D5/33agn7ZZe+e0jlDlfRAVvZ84=
Date: Sun, 31 Dec 2006 14:14:12 -0800
From: Amit Choudhary <amit2030@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.20-rc2] drivers/char/agp/sgi-agp.c: check kmalloc()
 return value.
Message-Id: <20061231141412.dd084d36.amit2030@gmail.com>
Organization: X
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.15; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: Check the return value of kmalloc() in function agp_sgi_init(), in file drivers/char/agp/sgi-agp.c.

Signed-off-by: Amit Choudhary <amit2030@gmail.com>

diff --git a/drivers/char/agp/sgi-agp.c b/drivers/char/agp/sgi-agp.c
index d73be4c..5897e6c 100644
--- a/drivers/char/agp/sgi-agp.c
+++ b/drivers/char/agp/sgi-agp.c
@@ -285,6 +285,8 @@ static int __devinit agp_sgi_init(void)
 	    (struct agp_bridge_data **)kmalloc(tioca_gart_found *
 					       sizeof(struct agp_bridge_data *),
 					       GFP_KERNEL);
+	if (!sgi_tioca_agp_bridges)
+		return -ENOMEM;
 
 	j = 0;
 	list_for_each_entry(info, &tioca_list, ca_list) {
