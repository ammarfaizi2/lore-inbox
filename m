Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264717AbUD1Jwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264717AbUD1Jwz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 05:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264718AbUD1Jwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 05:52:55 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:11225 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S264717AbUD1Jww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 05:52:52 -0400
Date: Wed, 28 Apr 2004 11:52:45 +0200 (MEST)
From: Armin Schindler <armin@melware.de>
To: Florian Schirmer <jolt@tuxbox.org>
cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <i4ldeveloper@listserv.isdn4linux.de>
Subject: Re: Linux 2.6.6-rc3
In-Reply-To: <015701c42d01$70886260$9602010a@jingle>
Message-ID: <Pine.LNX.4.31.0404281151580.23611-100000@phoenix.one.melware.de>
Organization: Cytronics & Melware
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:4f0aeee4703bc17a8237042c4702a75a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Apr 2004, Florian Schirmer wrote:
> Hi,
>
> > Armin Schindler:
> >   o ISDN CAPI: add ncci list semaphore
>
> This looks broken for !CONFIG_ISDN_CAPI_MIDDLEWARE configs. Note the up()
> inside the #ifdef.
>
> @@ -904,13 +917,17 @@
>  			if (copy_from_user((void *)&ncci, (void *)arg,
>  					   sizeof(ncci)))
>  				return -EFAULT;
> -			nccip = capincci_find(cdev, (u32) ncci);
> -			if (!nccip)
> +
> +			down(&cdev->ncci_list_sem);
> +			if ((nccip = capincci_find(cdev, (u32) ncci)) == 0) {
> +				up(&cdev->ncci_list_sem);
>  				return 0;
> +			}
>  #ifdef CONFIG_ISDN_CAPI_MIDDLEWARE
>  			if ((mp = nccip->minorp) != 0) {
>  				count += atomic_read(&mp->ttyopencount);
>  			}
> +			up(&cdev->ncci_list_sem);
>  #endif /* CONFIG_ISDN_CAPI_MIDDLEWARE */
>  			return count;
>  		}

Yes, you are right !
Patch is on its way...

Thanks,
Armin

