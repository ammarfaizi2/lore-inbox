Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261272AbULUSzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbULUSzN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 13:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbULUSzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 13:55:13 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3724 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261272AbULUSzC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 13:55:02 -0500
Date: Tue, 21 Dec 2004 08:37:50 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Horms <horms@verge.net.au>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       solar@openwall.com
Subject: Re: [PATCH] binfmt_elf force_sig arguments fix
Message-ID: <20041221103750.GB2088@logos.cnet>
References: <20041221123744.GA2294@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041221123744.GA2294@verge.net.au>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2004 at 09:37:47PM +0900, Horms wrote:
> Hi,
> 
> There appears to be a small error in the change that was recently
> applied to fs/binfmt_elf.c to fix error codes and eraly corrupt
> binary detection.
> 
> The patch includes changing a send_sig() call to a force_sig() call in
> load_elf_binary(). However force_sig() only accepts 2 arguments, and
> thus the patch causes the build to fail.
> 
> I propose the following patch to simply remove the extra argument to
> force_sig(), which I beleive will give a sensible result.  That or
> change the call back to send_sig(), though I assume it was changed to
> force_sig() for a reason.

Applied, thanks.

> -- 
> Horms
> 
> ===== fs/binfmt_elf.c 1.36 vs edited =====
> --- 1.36/fs/binfmt_elf.c	2004-12-18 03:17:46 +09:00
> +++ edited/fs/binfmt_elf.c	2004-12-21 21:21:25 +09:00
> @@ -806,7 +806,7 @@
>  		if (BAD_ADDR(elf_entry)) {
>  			printk(KERN_ERR "Unable to load interpreter %.128s\n",
>  				elf_interpreter);
> -			force_sig(SIGSEGV, current, 0);
> +			force_sig(SIGSEGV, current);
>  			retval = -ENOEXEC; /* Nobody gets to see this, but.. */
>  			goto out_free_dentry;
>  		}
