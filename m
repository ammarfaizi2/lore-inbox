Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261244AbRELNki>; Sat, 12 May 2001 09:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261245AbRELNk2>; Sat, 12 May 2001 09:40:28 -0400
Received: from mhw.ulib.iupui.edu ([134.68.164.123]:7928 "EHLO
	mhw.ULib.IUPUI.Edu") by vger.kernel.org with ESMTP
	id <S261244AbRELNkT>; Sat, 12 May 2001 09:40:19 -0400
Date: Sat, 12 May 2001 08:40:18 -0500 (EST)
From: "Mark H. Wood" <mwood@IUPUI.Edu>
X-X-Sender: <mwood@mhw.ULib.IUPUI.Edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: ENOIOCTLCMD?
In-Reply-To: <E14yXNZ-000447-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0105120831340.11432-100000@mhw.ULib.IUPUI.Edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 May 2001, Alan Cox wrote:
> > Can somebody explain the use of ENOIOCTLCMD? There are order of 170
> > uses in the kernel, but I don't see any guidelines for that use (nor
> > what prevents it from being seen by user programs).
>
> It should never be seen by apps. If it can be then it is wrong code.
> Basically you use it in things like
>
>
>
> 	int err = dev->ioctlfunc(dev, op, arg);
> 	if( err != -ENOIOCTLCMD)
> 		return err;
>
> 	/* Driver specific code does not support this ioctl */
>
> 	switch(op)
> 	{
>
> 			...
> 		default:
> 			return -ENOTTY;
> 	}
>
> Its a way of passing back 'you handle it'

Okay, but another way of looking at it is as an instance of the classic
joke:

Husband:  What have I done wrong this time?
Wife:     If you don't know, I'm not going to tell you!

IOW instead of getting back "this file doesn't know what that IOCTL
means", you get "error somewhere".  It certainly would be nice to know
*which* parameter was invalid and *why* it was invalid.  Changing this
would be against the lore, but I would rather throw away excess
information than never have received it in the first place. *sigh*

-- 
Mark H. Wood, Lead System Programmer   mwood@IUPUI.Edu
Make a good day.

