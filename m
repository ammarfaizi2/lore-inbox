Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131785AbRAWWcc>; Tue, 23 Jan 2001 17:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131784AbRAWWcW>; Tue, 23 Jan 2001 17:32:22 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:56661
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S131740AbRAWWcG>; Tue, 23 Jan 2001 17:32:06 -0500
Date: Tue, 23 Jan 2001 23:31:55 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: vantuyl@csc.smsu.edu, bryon@csc.smsu.edu
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] drivers/scsi/qlogicisp.c: return code from scsi_register (241p9)
Message-ID: <20010123233155.M607@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The following patch adds a check for scsi_register's return code to
drivers/scsi/qlogicisp.c. It applies cleanly against ac10 and 241p9.

Comments?


--- linux-ac10-clean/drivers/scsi/qlogicisp.c	Sat Jan 20 15:17:13 2001
+++ linux-ac10/drivers/scsi/qlogicisp.c	Sat Jan 20 23:05:47 2001
@@ -682,6 +682,9 @@
 			continue;
 
 		host = scsi_register(tmpt, sizeof(struct isp1020_hostdata));
+		if (!host)
+			continue;
+
 		hostdata = (struct isp1020_hostdata *) host->hostdata;
 
 		memset(hostdata, 0, sizeof(struct isp1020_hostdata));

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

If we do not succeed, then we run the risk of failure.
		-- Vice President Dan Quayle, to the Phoenix Republican
		   Forum, March 1990
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
