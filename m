Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284277AbRLBSUZ>; Sun, 2 Dec 2001 13:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281739AbRLBSRd>; Sun, 2 Dec 2001 13:17:33 -0500
Received: from camus.xss.co.at ([194.152.162.19]:7952 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id <S284269AbRLBSRA>;
	Sun, 2 Dec 2001 13:17:00 -0500
Message-ID: <3C0A7018.F6D17C84@xss.co.at>
Date: Sun, 02 Dec 2001 19:16:56 +0100
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: arrays@compaq.com
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] missing gendisk initialization in cciss.c (Linux-2.2.20)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

The following patch adds code to initialize gendisk.fops
in cciss.c. It's needed to avoid a kernel warning message
when using devfs with the Compaq RAID Controller.

--- linux-2.2.20/drivers/block/cciss.c  Fri Nov  2 17:39:06 2001
+++ linux/drivers/block/cciss.c Sun Dec  2 19:04:20 2001
@@ -1901,6 +1901,7 @@
                hba[i]->gendisk.max_p = MAX_PART;
                hba[i]->gendisk.max_nr = NWD;
                hba[i]->gendisk.init = cciss_geninit;
+               hba[i]->gendisk.fops = &cciss_fops;
                hba[i]->gendisk.part = hba[i]->hd;
                hba[i]->gendisk.sizes = hba[i]->sizes;
                hba[i]->gendisk.nr_real = hba[i]->num_luns;

HTH

- andreas

-- 
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
