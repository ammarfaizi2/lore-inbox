Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289855AbSAXAow>; Wed, 23 Jan 2002 19:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289866AbSAXAon>; Wed, 23 Jan 2002 19:44:43 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:30954 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S289855AbSAXAo2>; Wed, 23 Jan 2002 19:44:28 -0500
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200201240044.g0O0iOh24822@eng2.beaverton.ibm.com>
Subject: [PATCH] small bugfix for ll_rw_bio() for 2.5.3-pre3
To: axboe@suse.de (Jens Axboe), linux-kernel@vger.kernel.org
Date: Wed, 23 Jan 2002 16:44:24 -0800 (PST)
In-Reply-To: <20020115145549.M31878@suse.de> from "Jens Axboe" at Jan 15, 2002 01:55:49 PM PST
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a small bug fix for ll_rw_bio() for 2.5.3-pre3. 
kio->io_count can be safely incremented only after 
bio_alloc() success. 

Thanks,
Badari

--- linux-253pre3/fs/bio.c	Thu Dec 27 08:15:15 2001
+++ linux-253pre3.new/fs/bio.c	Wed Jan 23 17:32:59 2002
@@ -368,8 +368,6 @@
 	if (nr_pages > total_nr_pages)
 		nr_pages = total_nr_pages;
 
-	atomic_inc(&kio->io_count);
-
 	/*
 	 * allocate bio and do initial setup
 	 */
@@ -377,6 +375,8 @@
 		err = -ENOMEM;
 		goto out;
 	}
+
+	atomic_inc(&kio->io_count);
 
 	bio->bi_sector = sector;
 	bio->bi_dev = dev;

