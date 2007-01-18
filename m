Return-Path: <linux-kernel-owner+w=401wt.eu-S1751987AbXARGce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751987AbXARGce (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 01:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751984AbXARGce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 01:32:34 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:38379 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980AbXARGcd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 01:32:33 -0500
Date: Thu, 18 Jan 2007 01:30:19 -0500
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Cc: Jens Axboe <jens.axboe@oracle.com>,
       JFS Discussion <jfs-discussion@lists.sourceforge.net>,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH: 2.6.20-rc4-mm1] JFS: Avoid deadlock introduced by explicit I/O plugging
Message-ID: <20070118063019.GA31164@filer.fsl.cs.sunysb.edu>
References: <1169074549.10560.10.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1169074549.10560.10.camel@kleikamp.austin.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 17, 2007 at 04:55:49PM -0600, Dave Kleikamp wrote:
...
> diff -Nurp linux-2.6.20-rc4-mm1/fs/jfs/jfs_lock.h linux/fs/jfs/jfs_lock.h
> --- linux-2.6.20-rc4-mm1/fs/jfs/jfs_lock.h	2006-11-29 15:57:37.000000000 -0600
> +++ linux/fs/jfs/jfs_lock.h	2007-01-17 15:30:19.000000000 -0600
> @@ -22,6 +22,7 @@
>  #include <linux/spinlock.h>
>  #include <linux/mutex.h>
>  #include <linux/sched.h>
> +#include <linux/blkdev.h>
>  
>  /*
>   *	jfs_lock.h
> @@ -42,6 +43,7 @@ do {							\
>  		if (cond)				\
>  			break;				\
>  		unlock_cmd;				\
> +		blk_replug_current_nested();		\
>  		schedule();				\
>  		lock_cmd;				\
>  	}						\

Is {,un}lock_cmd a macro? ...

Jeff.

-- 
Keyboard not found!
Press F1 to enter Setup
