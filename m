Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261410AbREMPSc>; Sun, 13 May 2001 11:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261413AbREMPSM>; Sun, 13 May 2001 11:18:12 -0400
Received: from geos.coastside.net ([207.213.212.4]:18622 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S261412AbREMPSK>; Sun, 13 May 2001 11:18:10 -0400
Mime-Version: 1.0
Message-Id: <p0510030fb7245471f173@[207.213.214.37]>
In-Reply-To: <20010512152753.A21262@cm.nu>
In-Reply-To: <p05100302b7226d91e632@[207.213.214.37]>
 <E14yXNZ-000447-00@the-village.bc.nu> <20010512152753.A21262@cm.nu>
Date: Sun, 13 May 2001 08:17:30 -0700
To: Shane Wegner <shane@cm.nu>, Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: ENOIOCTLCMD?
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 3:27 PM -0700 2001-05-12, Shane Wegner wrote:
>  >	int err = dev->ioctlfunc(dev, op, arg);
>>	if( err != -ENOIOCTLCMD)
>>		return err;
>>
>>	/* Driver specific code does not support this ioctl */
>
>I noticed this return coming out of the watchdog driver a
>while ago when I was playing with it.  I have taken a quick
>look and it seems a few drivers do return this directly to
>userspace.  I'm not sure if this is complete but ...

Can't this be handled in sys_ioctl()? At the very end, replace

out:
	return error;

with

out:
	return (error == -ENOIOCTLCMD) ? -ENOTTY : error;


>diff -ur linux-2.4.4-ac8/drivers/block/swim3.c linux/drivers/block/swim3.c
>--- linux-2.4.4-ac8/drivers/block/swim3.c	Sat May 12 14:59:44 2001
>+++ linux/drivers/block/swim3.c	Sat May 12 15:22:30 2001
>@@ -848,7 +848,7 @@
>  				   sizeof(struct floppy_struct));
>  		return err;
>  	}
>-	return -ENOIOCTLCMD;
>+	return -ENOTTY;
>  }


-- 
/Jonathan Lundell.
