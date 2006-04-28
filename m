Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751770AbWD1ASR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751770AbWD1ASR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 20:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751731AbWD1ASR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 20:18:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:12757 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751735AbWD1ASP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 20:18:15 -0400
Date: Thu, 27 Apr 2006 17:16:27 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       git-commits-head@vger.kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Arnaud MAZIN <arnaud.mazin@gmail.com>,
       Stelian Pop <stelian@poppies.net>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 01/24] sonypi: correct detection of new ICH7-based laptops
Message-ID: <20060428001627.GB18750@kroah.com>
References: <20060428001226.204293000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="sonypi-correct-detection-of-new-ich7-based-laptops.patch"
In-Reply-To: <20060428001557.GA18750@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Arnaud MAZIN <arnaud.mazin@gmail.com>

[PATCH] sonypi: correct detection of new ICH7-based laptops

Add a test to detect the ICH7 based Core Duo SONY laptops (such as the SZ1)
as type3 models.

Signed-off-by: Arnaud MAZIN <arnaud.mazin@gmail.com>
Acked-by: Stelian Pop <stelian@poppies.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/char/sonypi.c |    3 +++
 1 file changed, 3 insertions(+)

--- linux-2.6.16.11.orig/drivers/char/sonypi.c
+++ linux-2.6.16.11/drivers/char/sonypi.c
@@ -1341,6 +1341,9 @@ static int __devinit sonypi_probe(struct
 	else if ((pcidev = pci_get_device(PCI_VENDOR_ID_INTEL,
 					  PCI_DEVICE_ID_INTEL_ICH6_1, NULL)))
 		sonypi_device.model = SONYPI_DEVICE_MODEL_TYPE3;
+	else if ((pcidev = pci_get_device(PCI_VENDOR_ID_INTEL,
+					  PCI_DEVICE_ID_INTEL_ICH7_1, NULL)))
+		sonypi_device.model = SONYPI_DEVICE_MODEL_TYPE3;
 	else
 		sonypi_device.model = SONYPI_DEVICE_MODEL_TYPE2;
 

--
