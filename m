Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264984AbSJVWaH>; Tue, 22 Oct 2002 18:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264987AbSJVWaH>; Tue, 22 Oct 2002 18:30:07 -0400
Received: from smtp2.mail.be.easynet.net ([212.100.160.76]:27352 "EHLO
	koshin.mail.be.easynet.net") by vger.kernel.org with ESMTP
	id <S264984AbSJVWaG>; Tue, 22 Oct 2002 18:30:06 -0400
Message-ID: <3DB5D415.4010604@easynet.be>
Date: Wed, 23 Oct 2002 00:41:25 +0200
From: Luc Van Oostenryck <luc.vanoostenryck@easynet.be>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Oops in 2.5.44's fs/block_dev.c:do_open() when trying to mount a
 badly formated floppy
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Offending code is:
     663                 if (bdev->bd_invalidated)
     664                         rescan_partitions(disk, bdev);
     665         } else {
     666                 down(&bdev->bd_contains->bd_sem);
     667                 bdev->bd_contains->bd_part_count++;
     668                 if (!bdev->bd_openers) {
     669                         struct hd_struct *p;
     670                         p = disk->part + part - 1;
                                     ^^^^^^^^^^

                         this is NULL when the floppy is badly formatted

The problem is not present in 2.5.43, but is also present in 2.5.44-ac1


Luc Van Oostenryck

