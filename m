Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262169AbSIZEWG>; Thu, 26 Sep 2002 00:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262170AbSIZEWG>; Thu, 26 Sep 2002 00:22:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42000 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262169AbSIZEWG>;
	Thu, 26 Sep 2002 00:22:06 -0400
Message-ID: <3D928C8B.5020609@pobox.com>
Date: Thu, 26 Sep 2002 00:26:51 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 4/4] increase traffic on linux-kernel
References: <3D928864.23666D93@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> --- 2.5.38/include/linux/kernel.h~might_sleep	Wed Sep 25 20:15:27 2002
> +++ 2.5.38-akpm/include/linux/kernel.h	Wed Sep 25 20:15:27 2002
> @@ -40,6 +40,13 @@
>  
>  struct completion;
>  
> +#ifdef CONFIG_DEBUG_KERNEL
> +void __might_sleep(char *file, int line);
> +#define might_sleep() __might_sleep(__FILE__, __LINE__)
> +#else
> +#define might_sleep() do {} while(0)
> +#endif


I disagree with this -- CONFIG_DEBUG_KERNEL should not enable any machinery.

Magic Sysrq should be enable-able without affecting any other parts of 
the kernel.

