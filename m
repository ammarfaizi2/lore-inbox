Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278503AbRJPCW7>; Mon, 15 Oct 2001 22:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278504AbRJPCWt>; Mon, 15 Oct 2001 22:22:49 -0400
Received: from patan.Sun.COM ([192.18.98.43]:17046 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S278503AbRJPCWh>;
	Mon, 15 Oct 2001 22:22:37 -0400
Message-ID: <3BCB994E.B443301C@sun.com>
Date: Mon, 15 Oct 2001 19:19:58 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alan@redhat.com,
        torvalds@transmeta.com
Subject: [PATCH] misc minor SCSI fixes
Content-Type: multipart/mixed;
 boundary="------------D0E2ACAD4026F1495059810D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------D0E2ACAD4026F1495059810D
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

All,

Attached are a couple minor fixes to the SCSI subsystem.  They're all
minor, and pretty obvious.

Please apply, or let me know whats wrong with them.

Thanks
Tim

-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
--------------D0E2ACAD4026F1495059810D
Content-Type: text/plain; charset=us-ascii;
 name="scsi-misc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="scsi-misc.diff"

diff -ruN dist-2.4.12+patches/drivers/scsi/scsi.c cvs-2.4.12+patches/drivers/scsi/scsi.c
--- dist-2.4.12+patches/drivers/scsi/scsi.c	Mon Oct 15 10:22:41 2001
+++ cvs-2.4.12+patches/drivers/scsi/scsi.c	Mon Oct 15 10:22:41 2001
@@ -1836,6 +1837,8 @@
 
 	pcount = next_scsi_host;
 
+	MOD_INC_USE_COUNT;
+
 	/* The detect routine must carefully spinunlock/spinlock if 
 	   it enables interrupts, since all interrupt handlers do 
 	   spinlock as well.
@@ -1966,8 +1968,6 @@
 	       (scsi_init_memory_start - scsi_memory_lower_value) / 1024,
 	       (scsi_memory_upper_value - scsi_init_memory_start) / 1024);
 #endif
-
-	MOD_INC_USE_COUNT;
 
 	if (out_of_space) {
 		scsi_unregister_host(tpnt);	/* easiest way to clean up?? */
diff -ruN dist-2.4.12+patches/drivers/scsi/sd.c cvs-2.4.12+patches/drivers/scsi/sd.c
--- dist-2.4.12+patches/drivers/scsi/sd.c	Mon Oct 15 10:22:41 2001
+++ cvs-2.4.12+patches/drivers/scsi/sd.c	Mon Oct 15 10:22:41 2001
@@ -152,6 +158,9 @@
 	int diskinfo[4];
     
 	SDev = rscsi_disks[DEVICE_NR(dev)].device;
+	if (!SDev)
+		return -ENODEV;
+
 	/*
 	 * If we are in the middle of error recovery, don't let anyone
 	 * else try and use this device.  Also, if error recovery fails, it
@@ -533,6 +546,8 @@
 
 	target = DEVICE_NR(inode->i_rdev);
 	SDev = rscsi_disks[target].device;
+	if (!SDev)
+		return -ENODEV;
 
 	SDev->access_count--;
 

--------------D0E2ACAD4026F1495059810D--

