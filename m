Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbVKUWBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbVKUWBN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 17:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbVKUWBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 17:01:13 -0500
Received: from [205.233.219.253] ([205.233.219.253]:32698 "EHLO
	conifer.conscoop.ottawa.on.ca") by vger.kernel.org with ESMTP
	id S1751087AbVKUWBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 17:01:10 -0500
Date: Mon, 21 Nov 2005 16:55:18 -0500
From: Jody McIntyre <scjody@steamballoon.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Dave Jones <davej@redhat.com>, bcollins@debian.org, dan@dennedy.org,
       linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       stable@kernel.org
Subject: Re: [2.6 patch] drivers/ieee1394/raw1394.c: fix a NULL pointer dereference
Message-ID: <20051121215518.GO20781@conscoop.ottawa.on.ca>
References: <20051120232009.GH16060@stusta.de> <20051120234055.GF28918@redhat.com> <20051120235242.GR16060@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051120235242.GR16060@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2005 at 12:52:42AM +0100, Adrian Bunk wrote:

> The coverity checker spotted that this was a NULL pointer dereference in 
> the "if (copy_from_user(...))" case since the next step is to 
> kfree(cache->filled_head).
> 
> There's no need to free cache at this point, and it's getting free'd 
> later.

Applied.

Cheers,
Jody

> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.15-rc1-mm2-full/drivers/ieee1394/raw1394.c.old	2005-11-20 22:08:57.000000000 +0100
> +++ linux-2.6.15-rc1-mm2-full/drivers/ieee1394/raw1394.c	2005-11-21 00:49:38.000000000 +0100
> @@ -2131,7 +2131,6 @@
>  			   req->req.length)) {
>  		csr1212_release_keyval(fi->csr1212_dirs[dr]);
>  		fi->csr1212_dirs[dr] = NULL;
> -		CSR1212_FREE(cache);
>  		ret = -EFAULT;
>  	} else {
>  		cache->len = req->req.length;
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
> Register for a JBoss Training Course.  Free Certification Exam
> for All Training Attendees Through End of 2005. For more info visit:
> http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
> _______________________________________________
> mailing list linux1394-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux1394-devel

-- 
