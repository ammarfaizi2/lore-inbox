Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264218AbUEXUhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264218AbUEXUhE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 16:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264373AbUEXUhD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 16:37:03 -0400
Received: from fw.osdl.org ([65.172.181.6]:55248 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264218AbUEXUg4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 16:36:56 -0400
Date: Mon, 24 May 2004 13:36:55 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: EAGAIN in do_mmap_pgoff() [2.6.7-rc1]
Message-ID: <20040524133655.L22989@build.pdx.osdl.net>
References: <20040524202121.GA28273@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040524202121.GA28273@MAIL.13thfloor.at>; from herbert@13thfloor.at on Mon, May 24, 2004 at 10:21:21PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Herbert Poetzl (herbert@13thfloor.at) wrote:
> 
> just a short question:
> 
> is -EAGAIN here really intentional? wouldn't -ENOMEM be better?
> 
> mm/mmap.c ~780 do_mmap_pgoff()
> 
>         /* mlock MCL_FUTURE? */
>         if (vm_flags & VM_LOCKED) {
>                 unsigned long locked = mm->locked_vm << PAGE_SHIFT;
>                 locked += len;
>                 if (locked > current->rlim[RLIMIT_MEMLOCK].rlim_cur)
>                         return -EAGAIN;
>         }

Standards require this one:

[EAGAIN]
	[ML] The mapping could not be locked in memory, if required by
	     mlockall(), due to a lack of resources.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
