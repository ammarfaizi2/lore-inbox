Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284970AbSBCAN2>; Sat, 2 Feb 2002 19:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284732AbSBCANS>; Sat, 2 Feb 2002 19:13:18 -0500
Received: from mailhost.cs.auc.dk ([130.225.194.6]:3580 "EHLO
	mailhost.cs.auc.dk") by vger.kernel.org with ESMTP
	id <S284300AbSBCANL>; Sat, 2 Feb 2002 19:13:11 -0500
Date: Sun, 3 Feb 2002 01:13:09 +0100 (MET)
From: Lars Christensen <larsch@cs.auc.dk>
To: <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@zip.com.au>
Subject: Re: 2.4.17 agpgart process hang on crash
In-Reply-To: <3C5C76F2.78BA9A54@zip.com.au>
Message-ID: <Pine.GSO.4.33.0202030104290.1223-100000@peta.cs.auc.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Feb 2002, Andrew Morton wrote:

> Lars Christensen wrote:
> >
> > No luck. Still hangs (e.g. with ./testgart & pkill -ABRT testgart), with
> > and without that patch and with and without 2.4.18-pre7. Does seem to
> > happen when dumping core--it doesn't happen with core dumping disabled.
> >
>
> This one, please:
>
> --- linux-2.4.18-pre7/drivers/char/agp/agpgart_fe.c	Sun Aug 12 10:38:48 2001
> +++ linux-akpm/drivers/char/agp/agpgart_fe.c	Sat Feb  2 15:29:49 2002
> @@ -605,19 +605,18 @@ static int agp_mmap(struct file *file, s

<snip>

> +	if (ret == 0)
> +		vma->vm_flags |= VM_IO;
>  	return -EPERM;
>  }

> Sorry - make the last statement `return ret;'

Better. The process dumps core now, but ps -ef hangs after printing a few
processes. Also, with a app runnig with a window open in X, the window
stays, so apparently, the process isn't gone.

-- 
Lars Christensen, larsch@cs.auc.dk


