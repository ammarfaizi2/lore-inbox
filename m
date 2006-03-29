Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbWC2H0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWC2H0O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 02:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbWC2H0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 02:26:14 -0500
Received: from 220-130-178-143.HINET-IP.hinet.net ([220.130.178.143]:8161 "EHLO
	areca.com.tw") by vger.kernel.org with ESMTP id S1751142AbWC2H0N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 02:26:13 -0500
Message-ID: <001d01c65302$0fee8e10$b100a8c0@erich2003>
From: "erich" <erich@areca.com.tw>
To: "Jens Axboe" <axboe@suse.de>
Cc: =?big5?B?KLxzpnes7KfeKaZ3pWlP?= <billion.wu@areca.com.tw>,
       "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <dax@gurulabs.com>, <ccaputo@alt.net>,
       "Matti Aarnio" <matti.aarnio@zmailer.org>
Subject: about ll_rw_blk.c of void generic_make_request(struct bio *bio)
Date: Wed, 29 Mar 2006 15:26:11 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="big5";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.3790.1830
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.1830
X-OriginalArrivalTime: 29 Mar 2006 07:21:20.0562 (UTC) FILETIME=[607E9920:01C65301]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Jens Axboe,

I am an engineer of Areca (SATA RAID controller producer).
I have coding linux driver for kernel.org "arcmsr".
I have got dump message %s: rw=%ld, want=%Lu, limit=%Lu message from ext2 
file system.
But I am do well at Ext3 and all linux files system.
This issue only occur at read command.
Could you give me some info how to fix this bug in my linux scsi raid 
driver?

About the code ll_rw_blk.c mention that "it may well happen - the kernel 
calls bread() without checking the size of the device, e.g., when mounting a 
device."

I hope that you have more experience with it and knew what's wrong I am 
doing in my driver.


generic_make_request(struct bio *bio)

 if (maxsector)
 {
  sector_t sector = bio->bi_sector;

  if (maxsector < nr_sectors || maxsector - nr_sectors < sector)
  {
   /*
    * This may well happen - the kernel calls bread()
    * without checking the size of the device, e.g., when
    * mounting a device.
    */
   handle_bad_sector(bio);
   goto end_io;
  }
 }
Best Regards
Erich Chen 

