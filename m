Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbTE2KWR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 06:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbTE2KWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 06:22:16 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9745 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262115AbTE2KWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 06:22:11 -0400
Date: Thu, 29 May 2003 11:35:19 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, axobe@in.ibm.com,
       Rusty <rusty@rustcorp.com.au>
Subject: Re: rd.o module refcount problem
Message-ID: <20030529113519.B18348@flint.arm.linux.org.uk>
Mail-Followup-To: Maneesh Soni <maneesh@in.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>, axobe@in.ibm.com,
	Rusty <rusty@rustcorp.com.au>
References: <20030529102510.GA1251@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030529102510.GA1251@in.ibm.com>; from maneesh@in.ibm.com on Thu, May 29, 2003 at 03:55:10PM +0530
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 29, 2003 at 03:55:10PM +0530, Maneesh Soni wrote:
> The module ref count for rd.o module is not adjusted and remains 1 while
> doing the following things. 
> 
> [root@llm01 mod]# insmod /sdb/linux-2.5.70/drivers/block/rd.o
> [root@llm01 mod]# lsmod
> Module                  Size  Used by
> rd                      5568  0 - Live 0xf88b5000
> [root@llm01 mod]# mkfs -t ext2 /dev/ram0
> .
> .
> [root@llm01 mod]# lsmod
> Module                  Size  Used by
> rd                      5568  1 - Live 0xf88b5000
> 
> mount/umount of /dev/ram0 does not change the rd.o module ref count. 
> 
> So, who is supposed to release the rd.o module gracefully? 
> Also mount /dev/ram0 should hold a ref and umount should release the same.
> 
> Same test on 2.4.20 looks correct and mount increments the ref count and
> umount decrements the ref count.

I think you'll find you have to tell the ramdisk to invalidate its contents
before the module count drops.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

