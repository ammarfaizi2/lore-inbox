Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271149AbUJVAEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271149AbUJVAEr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 20:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271129AbUJVADn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 20:03:43 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:60164 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S271146AbUJVAAs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 20:00:48 -0400
Date: Fri, 22 Oct 2004 01:00:45 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: mikem@beardog.cca.cpqcorp.net
Cc: marcelo.tosatti@cyclades.com, axboe@suse.de, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [patch 1/2] cciss: cleans up warnings in the 32/64 bit conversions
In-Reply-To: <20041021211718.GA10462@beardog.cca.cpqcorp.net>
Message-ID: <Pine.LNX.4.58L.0410220054010.15504@blysk.ds.pg.gda.pl>
References: <20041021211718.GA10462@beardog.cca.cpqcorp.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2004 mike.miller@hp.com wrote:

> @@ -611,7 +610,7 @@ int cciss_ioctl32_passthru(unsigned int 
>  	err |= copy_from_user(&arg64.Request, &arg32->Request, sizeof(arg64.Request));
>  	err |= copy_from_user(&arg64.error_info, &arg32->error_info, sizeof(arg64.error_info));
>  	err |= get_user(arg64.buf_size, &arg32->buf_size);
> -	err |= get_user(arg64.buf, &arg32->buf);
> +	err |= get_user((__u64) arg64.buf, &arg32->buf);
>  	if (err) 
>  		return -EFAULT; 
>  
> @@ -641,7 +640,7 @@ int cciss_ioctl32_big_passthru(unsigned 
>  	err |= copy_from_user(&arg64.error_info, &arg32->error_info, sizeof(arg64.error_info));
>  	err |= get_user(arg64.buf_size, &arg32->buf_size);
>  	err |= get_user(arg64.malloc_size, &arg32->malloc_size);
> -	err |= get_user(arg64.buf, &arg32->buf);
> +	err |= get_user((__u64) arg64.buf, &arg32->buf);
>  	if (err) return -EFAULT; 
>  	old_fs = get_fs();
>  	set_fs(KERNEL_DS);

 These constructs (casts as lvalues) are deprecated with GCC 3.4 (a
warning is triggered) and no longer supported with 4.0.  Please consider
rewriting -- you'll probably need an auxiliary variable.

  Maciej
