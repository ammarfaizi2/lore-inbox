Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261261AbRELOxJ>; Sat, 12 May 2001 10:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261262AbRELOw7>; Sat, 12 May 2001 10:52:59 -0400
Received: from geos.coastside.net ([207.213.212.4]:46024 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S261261AbRELOwz>; Sat, 12 May 2001 10:52:55 -0400
Mime-Version: 1.0
Message-Id: <p05100305b722fde7cf26@[207.213.214.37]>
In-Reply-To: <E14yXNZ-000447-00@the-village.bc.nu>
In-Reply-To: <E14yXNZ-000447-00@the-village.bc.nu>
Date: Sat, 12 May 2001 07:52:28 -0700
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: ENOIOCTLCMD?
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:16 PM +0100 2001-05-12, Alan Cox wrote:
>  > Can somebody explain the use of ENOIOCTLCMD? There are order of 170
>>  uses in the kernel, but I don't see any guidelines for that use (nor
>>  what prevents it from being seen by user programs).
>
>It should never be seen by apps. If it can be then it is wrong code.
>Basically you use it in things like

I was surmising something like that, but in that case aren't 
ENOIOCTLCMD and ENOTTY redundant? That is, could not every occurrence 
of ENOIOCTLCMD be replaced by ENOTTY with no change in function? 
That's what's confusing me: why the distinction? It's true that the 
current scheme allows the dev->ioctlfunc() call below to force ENOTTY 
to be returned, bypassing the switch, but presumably that's not what 
one wants.

>	int err = dev->ioctlfunc(dev, op, arg);
>	if( err != -ENOIOCTLCMD)
>		return err;
>
>	/* Driver specific code does not support this ioctl */
>
>	switch(op)
>	{
>
>			...
>		default:
>			return -ENOTTY;
>	}
>
>Its a way of passing back 'you handle it'
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/


-- 
/Jonathan Lundell.
