Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbTE2KJP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 06:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbTE2KJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 06:09:15 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:50386 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262098AbTE2KJO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 06:09:14 -0400
Date: Thu, 29 May 2003 15:55:10 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: axobe@in.ibm.com, Rusty <rusty@rustcorp.com.au>
Subject: rd.o module refcount problem
Message-ID: <20030529102510.GA1251@in.ibm.com>
Reply-To: maneesh@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The module ref count for rd.o module is not adjusted and remains 1 while doing 
the following things. 

[root@llm01 mod]# insmod /sdb/linux-2.5.70/drivers/block/rd.o
[root@llm01 mod]# lsmod
Module                  Size  Used by
rd                      5568  0 - Live 0xf88b5000
[root@llm01 mod]# mkfs -t ext2 /dev/ram0
.
.
[root@llm01 mod]# lsmod
Module                  Size  Used by
rd                      5568  1 - Live 0xf88b5000

mount/umount of /dev/ram0 does not change the rd.o module ref count. 

So, who is supposed to release the rd.o module gracefully? 
Also mount /dev/ram0 should hold a ref and umount should release the same.

Same test on 2.4.20 looks correct and mount increments the ref count and
umount decrements the ref count.

Regards,
Maneesh

-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/
