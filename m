Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030693AbWHKCUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030693AbWHKCUR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 22:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030692AbWHKCTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 22:19:55 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:44007 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030677AbWHKCTv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 22:19:51 -0400
Message-ID: <44DBE945.7070206@us.ibm.com>
Date: Thu, 10 Aug 2006 19:19:49 -0700
From: "Darrick J. Wong" <djwong@us.ibm.com>
Reply-To: "Darrick J. Wong" <djwong@us.ibm.com>
Organization: IBM LTC
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexis Bruemmer <alexisb@us.ibm.com>
Subject: [PATCH 2/2] Add SATA support to aic94xx
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make aic94xx call the functions that were added to libsas.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>

diff --git a/drivers/scsi/aic94xx/aic94xx_init.c b/drivers/scsi/aic94xx/aic94xx_init.c
index 3ec2e46..3a673fe 100644
--- a/drivers/scsi/aic94xx/aic94xx_init.c
+++ b/drivers/scsi/aic94xx/aic94xx_init.c
@@ -76,6 +77,9 @@ static struct scsi_host_template aic94xx
 	.sg_tablesize		= SG_ALL,
 	.max_sectors		= SCSI_DEFAULT_MAX_SECTORS,
 	.use_clustering		= ENABLE_CLUSTERING,
+	.slave_alloc		= sas_slave_alloc,
+	.target_destroy		= sas_target_destroy,
+	.ioctl			= sas_ioctl,
 };
