Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbVCETZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbVCETZu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 14:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbVCETZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 14:25:37 -0500
Received: from [205.233.219.253] ([205.233.219.253]:36520 "EHLO
	conifer.conscoop.ottawa.on.ca") by vger.kernel.org with ESMTP
	id S261165AbVCESuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 13:50:37 -0500
Date: Sat, 5 Mar 2005 13:47:56 -0500
From: Jody McIntyre <scjody@modernduck.com>
To: Panagiotis Issaris <panagiotis.issaris@mech.kuleuven.ac.be>
Cc: dtor_core@ameritech.net, Anton Altaparmakov <aia21@cam.ac.uk>,
       lkml <linux-kernel@vger.kernel.org>,
       linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH] raw1394 missing failure handling
Message-ID: <20050305184756.GH1111@conscoop.ottawa.on.ca>
References: <20050303214843.GQ1111@conscoop.ottawa.on.ca> <20050303225509.GB7442@mech.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050303225509.GB7442@mech.kuleuven.ac.be>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2005 at 11:55:09PM +0100, Panagiotis Issaris wrote:

> Adds the missing failure handling for a __copy_to_user call.
> 
> 
> Signed-off-by: Panagiotis Issaris <takis@gna.org>

Sorry I didn't notice this sooner, but this was already fixed and has
been sent to Linus (hopefully to appear in 2.6.12.)

Jody

> 
> diff -pruN linux-2.6.11/drivers/ieee1394/raw1394.c linux-2.6.11-pi/drivers/ieee1394/raw1394.c
> --- linux-2.6.11/drivers/ieee1394/raw1394.c	2005-03-02 11:44:26.000000000 +0100
> +++ linux-2.6.11-pi/drivers/ieee1394/raw1394.c	2005-03-02 15:27:15.000000000 +0100
> @@ -443,7 +443,10 @@ static ssize_t raw1394_read(struct file 
>                          req->req.error = RAW1394_ERROR_MEMFAULT;
>                  }
>          }
> -        __copy_to_user(buffer, &req->req, sizeof(req->req));
> +        if (__copy_to_user(buffer, &req->req, sizeof(req->req))) {
> +                free_pending_request(req);
> +                return -EFAULT;
> +        }
>  
>          free_pending_request(req);
>          return sizeof(struct raw1394_request);
> 
> 
> -- 
>   K.U.Leuven, Mechanical Eng.,  Mechatronics & Robotics Research Group
>   http://people.mech.kuleuven.ac.be/~pissaris/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
