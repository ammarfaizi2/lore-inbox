Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751392AbWERUa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbWERUa0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 16:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbWERUa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 16:30:26 -0400
Received: from hera.kernel.org ([140.211.167.34]:14977 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751392AbWERUaZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 16:30:25 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] rtc subsystem, use ENOIOCTLCMD where appropriate
Date: Thu, 18 May 2006 13:30:03 -0700 (PDT)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <e4ilgb$f10$1@terminus.zytor.com>
References: <20060517013033.10d08a8f@inspiron> <20060517142510.b3fcfb7d.rdunlap@xenotime.net> <20060517232742.2ac4ccaa@inspiron>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1147984203 15394 127.0.0.1 (18 May 2006 20:30:03 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Thu, 18 May 2006 20:30:03 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20060517232742.2ac4ccaa@inspiron>
By author:    Alessandro Zummo <alessandro.zummo@towertech.it>
In newsgroup: linux.dev.kernel
> > 
> > and ENOTTY is the return value for "Inappropriate ioctl for device":
> >
> 
>  you're right. I'll go for ENOTTY. thanks.
> 

ENOIOCTLCMD is right here, *except* in the very last hunk, because
it's a request to the upper layers to emulate the operation:

> --- linux-rtc.orig/drivers/rtc/rtc-dev.c	2006-05-17 01:18:19.000000000 +0200
> +++ linux-rtc/drivers/rtc/rtc-dev.c	2006-05-17 01:26:01.000000000 +0200
> @@ -141,13 +141,13 @@ static int rtc_dev_ioctl(struct inode *i
>  	/* try the driver's ioctl interface */
>  	if (ops->ioctl) {
>  		err = ops->ioctl(class_dev->dev, cmd, arg);
> -		if (err != -EINVAL)
> +		if (err != -ENOIOCTLCMD)
>  			return err;
>  	}
>  
>  	/* if the driver does not provide the ioctl interface
>  	 * or if that particular ioctl was not implemented
> -	 * (-EINVAL), we will try to emulate here.
> +	 * (-ENOIOCTLCMD), we will try to emulate here.
>  	 */
>  
>  	switch (cmd) {
> @@ -233,7 +233,7 @@ static int rtc_dev_ioctl(struct inode *i
>  		break;
>  
>  	default:
> -		err = -EINVAL;
> +		err = -ENOIOCTLCMD;
>  		break;
>  	}
>  

The last hunk should be ENOTTY.

	-hpa


---
~Randy
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



