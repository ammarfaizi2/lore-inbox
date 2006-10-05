Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751527AbWJEPUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527AbWJEPUJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 11:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbWJEPUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 11:20:08 -0400
Received: from xenotime.net ([66.160.160.81]:15028 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932114AbWJEPUG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 11:20:06 -0400
Date: Thu, 5 Oct 2006 08:21:31 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Eric Sesterhenn <snakebyte@gmx.de>
Cc: linux-kernel@vger.kernel.org, netwiz@crc.id.au
Subject: Re: [Patch] Dereference in drivers/usb/misc/adutux.c
Message-Id: <20061005082131.c9a0ecd0.rdunlap@xenotime.net>
In-Reply-To: <1160042489.3101.2.camel@alice>
References: <1160042489.3101.2.camel@alice>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Oct 2006 12:01:29 +0200 Eric Sesterhenn wrote:

> hi,
> 
> in two of the error cases, dev is still NULL,
> and we dereference it. Spotted by coverity (cid#1428, 1429)
> 
> Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
> 
> --- linux-2.6.19-rc1/drivers/usb/misc/adutux.c.orig	2006-10-05 11:57:52.000000000 +0200
> +++ linux-2.6.19-rc1/drivers/usb/misc/adutux.c	2006-10-05 11:58:19.000000000 +0200
> @@ -370,7 +370,8 @@ static int adu_release(struct inode *ino
>  	retval = adu_release_internal(dev);
>  
>  exit:
> -	up(&dev->sem);
> +	if(dev)
> +		up(&dev->sem);
>  	dbg(2," %s : leave, return value %d", __FUNCTION__, retval);
>  	return retval;
>  }

	if (dev)

space after if, for, while, etc.  No space after function names.

---
~Randy
