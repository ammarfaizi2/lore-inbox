Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287838AbSBHXfx>; Fri, 8 Feb 2002 18:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287841AbSBHXfn>; Fri, 8 Feb 2002 18:35:43 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:32145 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S287838AbSBHXf3>;
	Fri, 8 Feb 2002 18:35:29 -0500
Message-ID: <3C645F29.A11E5693@us.ibm.com>
Date: Fri, 08 Feb 2002 15:28:41 -0800
From: Mingming cao <cmm@us.ibm.com>
Organization: Linux Technology Center
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: davej@suse.de, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH]Size of raw_devices[]
Content-Type: multipart/mixed;
 boundary="------------D3ACA46F97535B5AFC18E7C6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------D3ACA46F97535B5AFC18E7C6
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi, 

While I was looking at the static arrays in the drivers, I found global
array raw_devices[] used for describing raw device infos is hard sized
by 256.  To better prepare for more minor bits in the future,  this
small patch is made to using MINORMASK to size raw_devices[] instead of
hardcoding.  Please consider it in 2.5.


-- 
Mingming Cao
--------------D3ACA46F97535B5AFC18E7C6
Content-Type: text/plain; charset=us-ascii;
 name="raw.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="raw.patch"

diff -urN -X dontdiff /usr/src/linux-2.5.3/drivers/char/raw.c 253.raw/drivers/char/raw.c
--- /usr/src/linux-2.5.3/drivers/char/raw.c	Tue Jan  1 11:40:34 2002
+++ 253.raw/drivers/char/raw.c	Fri Feb  8 14:17:03 2002
@@ -25,7 +25,7 @@
 	struct semaphore mutex;
 } raw_device_data_t;
 
-static raw_device_data_t raw_devices[256];
+static raw_device_data_t raw_devices[MINORMASK+1];
 
 static ssize_t rw_raw_dev(int rw, struct file *, char *, size_t, loff_t *);
 
@@ -53,7 +53,7 @@
 	int i;
 	register_chrdev(RAW_MAJOR, "raw", &raw_fops);
 
-	for (i = 0; i < 256; i++)
+	for (i = 0; i < MINORMASK+1; i++)
 		init_MUTEX(&raw_devices[i].mutex);
 
 	return 0;



--------------D3ACA46F97535B5AFC18E7C6--

