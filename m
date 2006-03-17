Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751479AbWCQLJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbWCQLJb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 06:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWCQLJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 06:09:31 -0500
Received: from smtp2.wanadoo.fr ([193.252.22.29]:38648 "EHLO smtp2.wanadoo.fr")
	by vger.kernel.org with ESMTP id S1751394AbWCQLJb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 06:09:31 -0500
X-ME-UUID: 20060317110929920.E09501C0021B@mwinf0212.wanadoo.fr
From: Laurent Wandrebeck <l.wandrebeck@free.fr>
To: linux-kernel@vger.kernel.org
Subject: [patch 1/1] OSS gus_wave missing return check for request_region()
Date: Fri, 17 Mar 2006 12:13:35 +0100
User-Agent: KMail/1.8
Cc: akpm@osdl.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603171213.35891.l.wandrebeck@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
in sound/oss/gus_wave.c, request_region() is called without checking the return
value. Here is a simple patch to fix it.
Patch against 2.6.16-rc6-git8.
Please CC me on replies.
Regards.

Signed-off-by: Laurent Wandrebeck <l.wandrebeck@free.fr>

--- linux-2.6.16-rc6/sound/oss/gus_wave.c.ori   2006-03-17 11:33:36.000000000 +0100
+++ linux-2.6.16-rc6/sound/oss/gus_wave.c       2006-03-17 11:46:46.000000000 +0100
@@ -2938,7 +2938,11 @@ void __init gus_wave_init(struct address
                        model_num = "3.7";
                        gus_type = 0x37;
                        mixer_type = ICS2101;
-                       request_region(u_MixSelect, 1, "GUS mixer");
+                       if (!request_region(u_MixSelect, 1, "GUS mixer")) {
+                           printk(KERN_ERR "gus_card: unable to reserve region %d for mixer\n",
+                                            u_MixSelect);
+                           return;
+                       }
                }
                else
                {

