Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129035AbRBAF1q>; Thu, 1 Feb 2001 00:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129047AbRBAF10>; Thu, 1 Feb 2001 00:27:26 -0500
Received: from freya.yggdrasil.com ([209.249.10.20]:23755 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S129035AbRBAF1Y>; Thu, 1 Feb 2001 00:27:24 -0500
Date: Wed, 31 Jan 2001 21:27:23 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: PATCH: linux-2.4.1/drivers/md.c unnecessarily referenced unexported symbol name_to_dev_t when md.c is built as module
Message-ID: <20010131212723.A1426@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

        md_setup() in linux-2.4.1/drivers/md.c references name_to_kdev_t.
Since name_to_kdev_t is not exported from the kenrel, this causes an
undefined symbol problem when md is built as a module.  However,
md_setup is not used when md is a module.  So, the correct fix
is to make sure that md_setup() is compiled only when md.c
is not a module.  Here is the patch.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="md.diff"

--- linux-2.4.1/drivers/md/md.c	Mon Jan 29 13:16:00 2001
+++ linux/drivers/md/md.c	Wed Jan 31 20:21:36 2001
@@ -3665,6 +3666,7 @@
  *             elements in device-list are read by name_to_kdev_t so can be
  *             a hex number or something like /dev/hda1 /dev/sdb
  */
+#ifndef MODULE
 extern kdev_t name_to_kdev_t(char *line) md__init;
 static int md__init md_setup(char *str)
 {
@@ -3740,6 +3742,7 @@
 	md_setup_args.device_set[minor] = 1;
 	return 1;
 }
+#endif /* !MODULE */
 
 void md__init md_setup_drive(void)
 {

--C7zPtVaVf+AK4Oqc--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
