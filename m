Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757015AbWK0FQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757015AbWK0FQZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 00:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757017AbWK0FQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 00:16:24 -0500
Received: from nz-out-0102.google.com ([64.233.162.205]:55103 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1757015AbWK0FQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 00:16:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=EN/tBpu4jQ4grkSJG/UfnNQmWFsBhXX7ubPWN2LCzC8Rdc++0u6FrhV2tNco1jhKdJUrEgbYur1EZk4nsAyJodYoRgo0e4z+QNEV7sIkRBUohLW4JOqcCSxVtEkff3xsaB05IKZUKm5J3nYwbmVcHz8vUYW1QK197tlqs5dy5C4=
Date: Mon, 27 Nov 2006 14:09:15 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: David Brownell <dbrownell@users.sourceforge.net>
Subject: [PATCH] spi: check platform_device_register_simple() error
Message-ID: <20061127050915.GH1231@APFDCB5C>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org,
	David Brownell <dbrownell@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch checks the return value of platform_device_register_simple().

Cc: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

---
 drivers/spi/spi_butterfly.c |    2 ++
 1 file changed, 2 insertions(+)

Index: work-fault-inject/drivers/spi/spi_butterfly.c
===================================================================
--- work-fault-inject.orig/drivers/spi/spi_butterfly.c
+++ work-fault-inject/drivers/spi/spi_butterfly.c
@@ -250,6 +250,8 @@ static void butterfly_attach(struct parp
 	 * setting up a platform device like this is an ugly kluge...
 	 */
 	pdev = platform_device_register_simple("butterfly", -1, NULL, 0);
+	if (IS_ERR(pdev))
+		return;
 
 	master = spi_alloc_master(&pdev->dev, sizeof *pp);
 	if (!master) {
