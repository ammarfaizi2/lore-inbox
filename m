Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263083AbREWNgZ>; Wed, 23 May 2001 09:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263084AbREWNgP>; Wed, 23 May 2001 09:36:15 -0400
Received: from mail1.uunet.ca ([209.167.141.3]:52673 "EHLO mail1.uunet.ca")
	by vger.kernel.org with ESMTP id <S263083AbREWNgB>;
	Wed, 23 May 2001 09:36:01 -0400
From: "David Mandelstam" <dm@sangoma.com>
To: "Akash Jain" <aki51@acura.stanford.edu>, <ncorbic@sangoma.com>,
        <torvalds@transmeta.com>, <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>, <su.class.cs99q@nntp.stanford.edu>
Subject: RE: [PATCH] net/wanrouter/wanproc.c
Date: Wed, 23 May 2001 12:29:40 -0400
Message-ID: <OHEGLGJAFGPLBABBMJCCOEKACCAA.dm@sangoma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Importance: Normal
In-Reply-To: <20010522230835.A17714@acura.stanford.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akash,

Thanks for this. Will get back to you.


David Mandelstam
Sangoma
Tel:      (905) 474-1990 x 106
          (800) 388-2475
FAX:      (905) 474-9223
email:    dm@sangoma.com
Web site: www.sangoma.com 
  

> -----Original Message-----
> From: Akash Jain [mailto:aki51@acura.stanford.edu]
> Sent: Tuesday, May 22, 2001 11:09 PM
> To: ncorbic@sangoma.com; dm@sangoma.com; torvalds@transmeta.com;
> alan@lxorguk.ukuu.org.uk
> Cc: linux-kernel@vger.kernel.org; su.class.cs99q@nntp.stanford.edu
> Subject: [PATCH] net/wanrouter/wanproc.c
> 
> 
> Hi All,
> I am working with Dawson Engler's meta-compillation group @ Stanford.
> 
> In net/wanrouter/wanproc.c the authors check for a bad copy_to_user and
> immediately return -EFAULT.  However, it is necessary to rollback some
> allocated memory.  This can leak memory over time, thus leading to
> system instability and lack of resources.
> 
> Thanks!
> -Akash Jain
> 
> --- net/wanrouter/wanproc.c.orig	Thu Apr 12 12:11:39 2001
> +++ net/wanrouter/wanproc.c	Thu May 17 12:52:05 2001
> @@ -267,8 +267,10 @@
>  		offs = file->f_pos;
>  		if (offs < pos) {
>  			len = min(pos - offs, count);
> -			if(copy_to_user(buf, (page + offs), len))
> -				return -EFAULT;
> +			if(copy_to_user(buf, (page + offs), len)){
> +			        kfree(page);
> +			        return -EFAULT;
> +			}
>  			file->f_pos += len;
>  		}
>  		else
> 
