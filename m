Return-Path: <linux-kernel-owner+w=401wt.eu-S932692AbWLSI6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932692AbWLSI6H (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 03:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932697AbWLSI6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 03:58:07 -0500
Received: from nz-out-0506.google.com ([64.233.162.228]:45057 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932692AbWLSI6G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 03:58:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=IyeiYVg4hTKGbLmCPwLwfS2AzpGRAf10cnNymeog99regwf3U1RoUXO6H65Zofd2vRVIAATSOf+ZvvVrQ4H83AIFS5v24ALsc8ApeEb5HhiwaYnakvZ4D5w0LRjyHbOQo95ZaOUi3dS2oQEdYzLiZjakQLBpbFEp4gB8BhLDV6k=
Date: Tue, 19 Dec 2006 17:57:12 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Sebastien Bouchard <sebastien.bouchard@ca.kontron.com>,
       Mark Gross <mark.gross@intel.com>
Subject: [PATCH] tlclk: delete unnecessary sysfs_remove_group
Message-ID: <20061219085712.GM4049@APFDCB5C>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org,
	Sebastien Bouchard <sebastien.bouchard@ca.kontron.com>,
	Mark Gross <mark.gross@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is unnecessary and invalid to call sysfs_remove_group()
after sysfs_create_group() failure.

Cc: Sebastien Bouchard <sebastien.bouchard@ca.kontron.com>
Cc: Mark Gross <mark.gross@intel.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

---
 drivers/char/tlclk.c |    2 --
 1 file changed, 2 deletions(-)

Index: 2.6-mm/drivers/char/tlclk.c
===================================================================
--- 2.6-mm.orig/drivers/char/tlclk.c
+++ 2.6-mm/drivers/char/tlclk.c
@@ -807,8 +807,6 @@ static int __init tlclk_init(void)
 			&tlclk_attribute_group);
 	if (ret) {
 		printk(KERN_ERR "tlclk: failed to create sysfs device attributes.\n");
-		sysfs_remove_group(&tlclk_device->dev.kobj,
-			&tlclk_attribute_group);
 		goto out5;
 	}
 
