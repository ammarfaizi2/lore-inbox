Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283483AbRLEDVT>; Tue, 4 Dec 2001 22:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283708AbRLEDVJ>; Tue, 4 Dec 2001 22:21:09 -0500
Received: from e24.nc.us.ibm.com ([32.97.136.230]:30183 "EHLO
	e24.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S283483AbRLEDUv>; Tue, 4 Dec 2001 22:20:51 -0500
Message-ID: <3C0D928F.8080904@us.ibm.com>
Date: Tue, 04 Dec 2001 19:20:47 -0800
From: "David C. Hansen" <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Moving BKL from generic code into drivers
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As a first step toward removing the BKL from some block device drivers, 
I'm planning on moving the BKL out of the generic code and into the 
drivers themselves.

I plan on doing this indiscriminately.  All block devices will have a 
lock_kernel() at the top of their open() and an unlock_kernel() at the 
bottom.  Later on, we can remove it from individual drivers as we see fit.

Now the big question:
In block_dev.c:do_open(), the BKL is held in addition to bdev->bd_sem. 
Why is the BKL held here, other than to protect all of the drivers' open 
functions?  What doesn't the semaphore provide?

This kind of action, moving the BKL from generic code into drivers isn't 
a first:
http://marc.theaimsgroup.com/?l=linux-kernel&m=96346538231916&w=2
-- 
Dave Hansen
haveblue@us.ibm.com

