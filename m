Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268289AbTBMVAV>; Thu, 13 Feb 2003 16:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268291AbTBMVAV>; Thu, 13 Feb 2003 16:00:21 -0500
Received: from f137.pav2.hotmail.com ([64.4.37.137]:62984 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S268289AbTBMVAU>;
	Thu, 13 Feb 2003 16:00:20 -0500
X-Originating-IP: [129.219.25.77]
From: "shesha bhushan" <bhushan_vadulas@hotmail.com>
To: rddunlap@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Exporting Kernel Symbols
Date: Thu, 13 Feb 2003 21:10:07 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F137l6ds7s07Bj89Nwv0002e18c@hotmail.com>
X-OriginalArrivalTime: 13 Feb 2003 21:10:07.0444 (UTC) FILETIME=[491BA140:01C2D3A4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK I got this working. It was a very silly thing.
linux/fs/read_write.c had not included <linux/module.h> But the kernel 
compilation was not complaining about the useage of EXPORT_SYMBOL without 
including <linux/module.
Now its working fine.

Thanks
-Shesha


>From: "Randy.Dunlap" <rddunlap@osdl.org>
>To: "shesha bhushan" <bhushan_vadulas@hotmail.com>
>CC: linux-kernel@vger.kernel.org
>Subject: Re: Exporting Kernel Symbols
>Date: Thu, 13 Feb 2003 12:26:10 -0800
>
>On Thu, 13 Feb 2003 20:22:48 +0000
>"shesha bhushan" <bhushan_vadulas@hotmail.com> wrote:
>
>| Hi,
>|   I have written a new function in linux/fs/read_write.c and I want to 
>make
>| the function avaliable to other kernel modules loaded using insmod.
>| He is what I did:
>| 1. Wrore the func my_func() in linux/fs/read_write.c
>| 2. Used the macro EXPORT_SYMBOL(my_func) inside linux/fs/read_write.c
>| 3. Have a signature of my_func in my_func.h
>| 4. Include my_func.h in linux/fs/read_write.c and my_driver.c
>| 5. Recompiled the kernel
>| 6. Compiler my_driver as loadable module.
>| 7. Brought my new kernel Up.
>| 8 . Insmod my_driver.o
>| Here I get the error "Unresolved symbol my_func"
>| Can any one clarify this.
>
>For what kernel version?
>
>In 2.4.20, e.g., in linux/fs/Makefile, change the following line:
>
>export-objs := filesystems.o open.o dcache.o buffer.o
>
>to include read_write.o
>
>--
>~Randy
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

_________________________________________________________________
The new MSN 8: smart spam protection and 2 months FREE*  
http://join.msn.com/?page=features/junkmail

