Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262444AbTFXRfb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 13:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262383AbTFXRfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 13:35:31 -0400
Received: from wireless-216-222-127-29.reno.velocitus.net ([216.222.127.29]:45716
	"EHLO masterhub1.sncorp.intranet.com") by vger.kernel.org with ESMTP
	id S262568AbTFXRfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 13:35:21 -0400
Subject: Re: 2.5.73: eth1394.c: ptask might be used uninitialized
From: Steve Kinneberg <kinnebergsteve@acmsystems.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Ben Collins <bcollins@debian.org>,
       Linux1394dev <linux1394-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030624172254.GQ3710@fs.tum.de>
References: <20030624172254.GQ3710@fs.tum.de>
X-Mailer: Ximian Evolution 1.0.8 
Date: 24 Jun 2003 10:49:25 -0700
Message-Id: <1056476965.9714.7441.camel@stevek>
Mime-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SacMail1/ACMS/SNCorp(Release 5.0.11  |July 24, 2002) at
 06/24/2003 10:49:25 AM,
	Serialize by Router on masterhub1/SNCorp(Release 5.0.11  |July 24, 2002) at
 06/24/2003 10:54:39 AM,
	Serialize complete at 06/24/2003 10:54:39 AM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I believe this has been fixed in Linux1394 project's SVN revision 957. 
Hopefully, it'll be merged with the main kernel in the near future.

On Tue, 2003-06-24 at 10:22, Adrian Bunk wrote:
> In 2.5.73, gcc complains as follows:
> 
> <--  snip  -->
> 
> ...
>   CC      drivers/ieee1394/eth1394.o
> ...
> drivers/ieee1394/eth1394.c:1424: warning: `ptask' might be used 
> uninitialized in this function
> ...
> 
> <--  snip  -->
> 
> It seems something like the patch below might be needed (I didn't check 
> for 100% correctness, but it shows what might be needed to fix it).
> 
> cu
> Adrian
> 
> --- linux-2.5.73-not-full/drivers/ieee1394/eth1394.c.old	2003-06-23 23:11:01.000000000 +0200
> +++ linux-2.5.73-not-full/drivers/ieee1394/eth1394.c	2003-06-23 23:11:25.000000000 +0200
> @@ -1427,7 +1427,7 @@
>  	if (skb_is_nonlinear(skb)) {
>  		ret = skb_linearize(skb, kmflags);
>  		if(ret)
> -			goto fail;
> +			goto out;
>  	}
>  
>  	ptask = kmem_cache_alloc(packet_task_cache, kmflags);
> @@ -1555,6 +1555,7 @@
>  		ether1394_free_packet(ptask->packet);
>  	if(ptask)
>  		kmem_cache_free(packet_task_cache, ptask);
> +out:
>  	if(skb != NULL) {
>  		dev_kfree_skb(skb);
>  	}
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: INetU
> Attention Web Developers & Consultants: Become An INetU Hosting Partner.
> Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
> INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
> _______________________________________________
> mailing list linux1394-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux1394-devel
-- 
Steve Kinneberg
ACM Systems
3034 Gold Canal Drive
Rancho Cordova, CA  95670
Phone: (916) 463-7987
Email: kinnebergsteve at acmsystems dot com

