Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263271AbUDGNZz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 09:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263365AbUDGNZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 09:25:55 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:54659 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263271AbUDGNYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 09:24:32 -0400
Subject: Re: 2.6.5-mm2
From: James Bottomley <James.Bottomley@steeleye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Brice Goglin <Brice.Goglin@ens-lyon.fr>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040407001004.0360a049.akpm@osdl.org>
References: <20040406223321.704682ed.akpm@osdl.org>
	<20040407065154.GG1139@ens-lyon.fr>  <20040407001004.0360a049.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 07 Apr 2004 08:24:17 -0500
Message-Id: <1081344258.10773.3.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-04-07 at 02:10, Andrew Morton wrote:
> It looks like Mr SCSI forgot to commit his changes to sr.h.

Hmm, I seem to be having a lot of source control fiasco's recently.

The attached is the missing header patch (which I've also put in
scsi-misc-2.6)

James

===== drivers/scsi/sr.h 1.10 vs edited =====
--- 1.10/drivers/scsi/sr.h	Mon May 26 04:50:43 2003
+++ edited/drivers/scsi/sr.h	Mon Apr  5 15:51:37 2004
@@ -36,6 +36,9 @@
 	unsigned readcd_known:1;	/* drive supports READ_CD (0xbe) */
 	unsigned readcd_cdda:1;	/* reading audio data using READ_CD */
 	struct cdrom_device_info cdi;
+	/* We hold gendisk and scsi_device references on probe and use
+	 * the refs on this kobj to decide when to release them */
+	struct kobject kobj;
 	struct gendisk *disk;
 } Scsi_CD;
 

