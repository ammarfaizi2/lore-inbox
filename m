Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287647AbSAELEB>; Sat, 5 Jan 2002 06:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287645AbSAELDw>; Sat, 5 Jan 2002 06:03:52 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:28902 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S287647AbSAELDk>; Sat, 5 Jan 2002 06:03:40 -0500
Date: Sat, 5 Jan 2002 03:03:37 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: elmer@ylenurme.ee, linux-kernel@vger.kernel.org
Subject: Patch: linux-2.5.2-pre8/drivers/net/aironet4500_core.c tried to return NODEV, should be -ENODEV
Message-ID: <20020105030337.A23630@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


	linux-2.5.2-pre8/drivers/net/aironet4500_core.c
contains contains a routine that tried to return NODEV as
an error code where the author's intention was apparently
-ENODEV.  That is the second error of this type that the
change in kdev_t has exposed (the other one was in
drivers/isdn/sc/command.c).

	Here is the patch.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="aeronet.diff"

--- linux-2.5.2-pre8/drivers/net/aironet4500_core.c	Sun Sep 30 12:26:06 2001
+++ linux/drivers/net/aironet4500_core.c	Sat Jan  5 02:57:16 2002
@@ -2836,8 +2836,7 @@
  	return 0; 
    final:
    	printk(KERN_ERR "aironet init failed \n");
-   	return NODEV;
-   	
+   	return -ENODEV;
  };
 
 int awc_private_init(struct net_device * dev){

--45Z9DzgjV8m4Oswq--
