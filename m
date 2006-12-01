Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162274AbWLAX2D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162274AbWLAX2D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 18:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162258AbWLAXXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 18:23:49 -0500
Received: from cantor2.suse.de ([195.135.220.15]:34029 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1162259AbWLAXXO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 18:23:14 -0500
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 18/36] Driver core: convert PPP code to use struct device
Date: Fri,  1 Dec 2006 15:21:48 -0800
Message-Id: <11650153833896-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <11650153792132-git-send-email-greg@kroah.com>
References: <20061201231620.GA7560@kroah.com> <11650153262399-git-send-email-greg@kroah.com> <11650153293531-git-send-email-greg@kroah.com> <1165015333344-git-send-email-greg@kroah.com> <11650153362310-git-send-email-greg@kroah.com> <11650153392022-git-send-email-greg@kroah.com> <11650153432284-git-send-email-greg@kroah.com> <11650153463092-git-send-email-greg@kroah.com> <1165015349830-git-send-email-greg@kroah.com> <11650153522862-git-send-email-greg@kroah.com> <116501535622-git-send-email-greg@kroah.com> <11650153591876-git-send-email-greg@kroah.com> <11650153631070-git-send-email-greg@kroah.com> <1165015366759-git-send-email-greg@kroah.com> <11650153704007-git-send-email-greg@kroah.com> <11650153733277-git-send-email-greg@kroah.com> <11650153763330-git-send-email-greg@kroah.com> <11650153792132-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

Converts from using struct "class_device" to "struct device" making
everything show up properly in /sys/devices/ with symlinks from the
/sys/class directory.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/net/ppp_generic.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ppp_generic.c b/drivers/net/ppp_generic.c
index f5802e7..c6de566 100644
--- a/drivers/net/ppp_generic.c
+++ b/drivers/net/ppp_generic.c
@@ -860,7 +860,7 @@ static int __init ppp_init(void)
 			err = PTR_ERR(ppp_class);
 			goto out_chrdev;
 		}
-		class_device_create(ppp_class, NULL, MKDEV(PPP_MAJOR, 0), NULL, "ppp");
+		device_create(ppp_class, NULL, MKDEV(PPP_MAJOR, 0), "ppp");
 	}
 
 out:
@@ -2675,7 +2675,7 @@ static void __exit ppp_cleanup(void)
 	cardmap_destroy(&all_ppp_units);
 	if (unregister_chrdev(PPP_MAJOR, "ppp") != 0)
 		printk(KERN_ERR "PPP: failed to unregister PPP device\n");
-	class_device_destroy(ppp_class, MKDEV(PPP_MAJOR, 0));
+	device_destroy(ppp_class, MKDEV(PPP_MAJOR, 0));
 	class_destroy(ppp_class);
 }
 
-- 
1.4.4.1

