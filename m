Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbWEOXeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWEOXeR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 19:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbWEOXeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 19:34:17 -0400
Received: from pat.uio.no ([129.240.10.4]:53951 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1750773AbWEOXeR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 19:34:17 -0400
Subject: Re: umount error: device is busy after nfs + lock
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: wang dengyi <dy_wang@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060515185940.16459.qmail@web51912.mail.yahoo.com>
References: <20060515185940.16459.qmail@web51912.mail.yahoo.com>
Content-Type: text/plain
Date: Mon, 15 May 2006 18:32:30 -0500
Message-Id: <1147735950.8772.60.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-4.838, required 12,
	autolearn=disabled, AWL -0.03, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-15 at 11:59 -0700, wang dengyi wrote:
> Hello,
> 
> When I ran ltp test case:tlocklfs, I met a old problem
> with the kernel:2.6.9. I can not umount a file system
> after nfs and lock using it. Here is the steps.

Kernel 2.6.9 is almost 2 years old, and the NFS locking has changed a
_lot_ since then. Can you reproduce this with a recent kernel?

Cheers,
  Trond

>  1) mount /dev/sda3 /xyz
>  2) export /xyz
>  3) restart nfs
>  4) mount 127.0.0.1:/xyz /mnt/nfs_xyz
>  5) run the special lock test program: "tlocklfs -t 7
> /mnt/nfs_xyz
>  6) umount /mnt/nfs_xyz
>  7) stop nfs
>  8) umount /xyz
> Then I got the error: "umount /xyz: device is busy".
> And the error displays twice. 
> 
> If I run the different lock test case for the step 5,
> the umount works fine. It only failed on the test case
> 7 from tlocklfs. 
> 
> There are 2 processes in this special test case.
> First, the parent process "setlk" for a file from nfs
> file system. Then the child process "setlkw". At the
> end, the parent and the child process unlock the file.
> 
> 
> With some debug line in the code, I found the file
> system's "mnt_count" is 3 instead of 2 before
> umounting it. I traced back the problem and I'm lost
> in linux/net/sunrpc/sched.c. Could anyone give me some
> hint? Thank you very much.
> 
> Best regard
> 
> Dengyi Wang
>   
> 
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam
> protection around 
> http://mail.yahoo.com 
> 
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam protection around 
> http://mail.yahoo.com 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

