Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132555AbRDKLXO>; Wed, 11 Apr 2001 07:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132556AbRDKLXF>; Wed, 11 Apr 2001 07:23:05 -0400
Received: from cr502987-a.rchrd1.on.wave.home.com ([24.42.47.5]:6917 "EHLO
	the.jukie.net") by vger.kernel.org with ESMTP id <S132555AbRDKLWy>;
	Wed, 11 Apr 2001 07:22:54 -0400
Date: Wed, 11 Apr 2001 07:22:44 -0400 (EDT)
From: Bart Trojanowski <bart@jukie.net>
To: <antonpoon@hongkong.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: How can I add a function to the kernel initialization
In-Reply-To: <Eq989588839292.22828@mail2.hongkong.com>
Message-ID: <Pine.LNX.4.30.0104110718010.31213-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


First it does not work because you do not have access to libc in the
kernel.  Secondly your LCD driver is not available at the time of
start_kernel so there is no one to listen to the /dev/lcd.

The quickest hack would be to find your lcd driver and modify it to spit
out the Loading Kernel, after it initializes.

B.

On Wed, 11 Apr 2001, antonpoon@hongkong.com wrote:

> I have written a driver for a character set LCD module using parallel port. I want to display a message when the kernel is initialized.
>
> I added the following to start_kernel() in init/main.c
>
> #include <stdio.h>
>
> {
>   int i;
>   char line = "Loading Kernel";
>   FILE *ptr;
>   ptr = fopen("/dev/lcd","w");
>
>   for (i=0;i<10;i++)
>   {
>   	fprintf(ptr, "%s\n", line);
>   }
>   fclose(ptr);
> }
>
> Error was found, it looks like that it can not include stdio.h in the initialization.
> How can I do that?
>
> I wish to be personally CC'ed the answers/comments posted to the list in response to my posting. Thank you.
>
> Best Regards,
> Anton
>
>
>
> ---------------------------------------------
>  歡迎使用HongKong.com郵件系統
>  Thank you for using hongkong.com Email system
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
	WebSig: http://www.jukie.net/~bart/sig/


