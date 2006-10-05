Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751469AbWJEXkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbWJEXkw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 19:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751477AbWJEXkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 19:40:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30412 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751469AbWJEXkv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 19:40:51 -0400
Date: Thu, 5 Oct 2006 16:40:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH -fix] swsusp: Make userland suspend work on SMP again
Message-Id: <20061005164036.06237b30.akpm@osdl.org>
In-Reply-To: <200610042226.43833.rjw@sisk.pl>
References: <200610042226.43833.rjw@sisk.pl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Oct 2006 22:26:42 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> Unfortunately one of the recent changes in swsusp has broken the userland
> suspend on SMP.  Fix it.
> 

Which patch does this fix?

> ---
> ---
>  kernel/power/user.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-2.6.18-mm3/kernel/power/user.c

I'll assume from this that your patch is applicable to -mm and that mainline
doesn't have this bug.

I'll further assume that it's swsusp-add-ioctl-for-swap-files-support.patch
which added the bug.

> ===================================================================
> --- linux-2.6.18-mm3.orig/kernel/power/user.c
> +++ linux-2.6.18-mm3/kernel/power/user.c
> @@ -149,10 +149,10 @@ static int snapshot_ioctl(struct inode *
>  			error = freeze_processes();
>  			if (error) {
>  				thaw_processes();
> +				enable_nonboot_cpus();
>  				error = -EBUSY;
>  			}
>  		}
> -		enable_nonboot_cpus();
>  		up(&pm_sem);
>  		if (!error)
>  			data->frozen = 1;
