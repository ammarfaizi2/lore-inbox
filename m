Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284263AbRLBSRw>; Sun, 2 Dec 2001 13:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284259AbRLBSRg>; Sun, 2 Dec 2001 13:17:36 -0500
Received: from camus.xss.co.at ([194.152.162.19]:8720 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id <S284270AbRLBSRH>;
	Sun, 2 Dec 2001 13:17:07 -0500
Message-ID: <3C0A7020.C177BEA8@xss.co.at>
Date: Sun, 02 Dec 2001 19:17:04 +0100
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: arrays@compaq.com
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] missing gendisk initialization in cpqarray.c (Linux-2.2.20)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

The following patch adds code to initialize gendisk.fops
in cpqarray.c. It's needed to avoid a kernel warning message
when using devfs with the Compaq RAID Controller.

--- linux-2.2.20/drivers/block/cpqarray.c       Fri Nov  2 17:39:06
2001
+++ linux/drivers/block/cpqarray.c      Sun Dec  2 19:05:11 2001
@@ -513,6 +513,7 @@
                ida_gendisk[i].init = ida_geninit;
                ida_gendisk[i].part = ida + (i*256);
                ida_gendisk[i].sizes = ida_sizes + (i*256);
+               ida_gendisk[i].fops = &ida_fops;
                /* ida_gendisk[i].nr_real is handled by getgeometry */

                blk_dev[MAJOR_NR+i].request_fn = request_fns[i];


HTH

- andreas

-- 
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
