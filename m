Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315628AbSFJSRi>; Mon, 10 Jun 2002 14:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315629AbSFJSRh>; Mon, 10 Jun 2002 14:17:37 -0400
Received: from chaos.analogic.com ([204.178.40.224]:41090 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S315628AbSFJSRh>; Mon, 10 Jun 2002 14:17:37 -0400
Date: Mon, 10 Jun 2002 14:17:35 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Joseph Cheek <joseph@cheek.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: procedure for creating new ioctl?
In-Reply-To: <3D04EB4F.4030107@cheek.com>
Message-ID: <Pine.LNX.3.95.1020610141444.17491A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jun 2002, Joseph Cheek wrote:

> hi all,
> 
> i'd like to create a new ioctl for use in my kernels [actually i already 
> have 8-)] but want to make sure that i follow any established procedure 
> for creating it before requesting it be included in the kernel. 
>  specifically, is there a way to ensure the ioctl number i use isn't in 
> use by anyone else?  is there a central registry?
> 
> so far i've just picked an arbitrary number:
> 
> sanfrancisco:/usr/src/linux-2.4.17/include/linux# diff -Naur kd.h{.orig,}
> --- kd.h.orig   Mon Jun 10 11:08:22 2002
> +++ kd.h        Thu Jun  6 16:00:33 2002
> @@ -177,4 +177,6 @@
>     don't reuse for the time being */
>  /* note: 0x4B60-0x4B6D, 0x4B70-0x4B72 used above */
> 
> +#define KDGETKEYDOWNSTATE      0x4B80  /* read kernel keydown bit */
> +
>  #endif /* _LINUX_KD_H */
> 
> any tips, pointers appreciated.
> 
> joe
> 

I use SIOCDEVPRIVATE as the starting value for new ioctls:

/*
 *   Interface to the private device functions. User API sees this only.
 */
#define CHEK_SEEPROM   SIOCDEVPRIVATE + 0x07
#define READ_SEEPROM   SIOCDEVPRIVATE + 0x08
#define WRITE_SEEPROM  SIOCDEVPRIVATE + 0x09


I've seen this in several drivers. I think this is the way to do it
so there is no interference with other ioctls.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

