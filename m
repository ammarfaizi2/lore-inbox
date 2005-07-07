Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261331AbVGGMCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbVGGMCz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 08:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbVGGLn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 07:43:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18925 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261311AbVGGLnl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 07:43:41 -0400
Date: Thu, 7 Jul 2005 04:42:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc2-mm1
Message-Id: <20050707044255.7f2aede2.akpm@osdl.org>
In-Reply-To: <42CD12C4.8010200@ens-lyon.org>
References: <20050707040037.04366e4e.akpm@osdl.org>
	<42CD12C4.8010200@ens-lyon.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brice Goglin <Brice.Goglin@ens-lyon.org> wrote:
>
> Le 07.07.2005 13:00, Andrew Morton a écrit :
>  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc2/2.6.13-rc2-mm1/
>  > 
>  > (kernel.org seems to be stuck again - there's a copy at
>  > http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.13-rc2-mm1.gz)
> 
>    CC      kernel/power/disk.o
>  kernel/power/disk.c: Dans la fonction « software_resume »:
>  kernel/power/disk.c:242: attention : implicit declaration of function
>  `name_to_dev_t'
> 
>  The attached patch adds an extern declaration in disk.c as it's
>  already done in swsusp.c
> 

Well both are wrong...  This should go in a header file.  I guess mount.h
is close enough.

>  --- linux-mm/kernel/power/disk.c.old	2005-07-07 13:28:52.000000000 +0200
>  +++ linux-mm/kernel/power/disk.c	2005-07-07 13:30:02.000000000 +0200
>  @@ -30,6 +30,7 @@ extern void swsusp_close(void);
>   extern int swsusp_resume(void);
>   extern int swsusp_free(void);
>   
>  +extern dev_t name_to_dev_t(const char *line);
>   
>   static int noresume = 0;
>   char resume_file[256] = CONFIG_PM_STD_PARTITION;
