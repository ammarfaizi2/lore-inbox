Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbWD2GgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWD2GgD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 02:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbWD2GgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 02:36:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47329 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750825AbWD2GgC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 02:36:02 -0400
Date: Fri, 28 Apr 2006 23:34:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genrtc: fix read on 64-bit platforms
Message-Id: <20060428233421.72e2faed.akpm@osdl.org>
In-Reply-To: <20060429.013857.37531336.anemo@mba.ocn.ne.jp>
References: <20060429.013857.37531336.anemo@mba.ocn.ne.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
>
> Fix genrtc's read() routine for 64-bit platforms.
> 

When fixing something, please provide a description of what the problem was
and also a description of how the patch fixes it (unless it's obvious, of
course).

Thanks.

> 
> diff --git a/drivers/char/genrtc.c b/drivers/char/genrtc.c
> index d3a2bc3..588fca5 100644
> --- a/drivers/char/genrtc.c
> +++ b/drivers/char/genrtc.c
> @@ -200,13 +200,13 @@ static ssize_t gen_rtc_read(struct file 
>  	/* first test allows optimizer to nuke this case for 32-bit machines */
>  	if (sizeof (int) != sizeof (long) && count == sizeof (unsigned int)) {
>  		unsigned int uidata = data;
> -		retval = put_user(uidata, (unsigned long __user *)buf);
> +		retval = put_user(uidata, (unsigned int __user *)buf) ?:
> +			sizeof(unsigned int);
>  	}
>  	else {
> -		retval = put_user(data, (unsigned long __user *)buf);
> +		retval = put_user(data, (unsigned long __user *)buf) ?:
> +			sizeof(unsigned long);
>  	}
> -	if (!retval)
> -		retval = sizeof(unsigned long);
>   out:
>  	current->state = TASK_RUNNING;
>  	remove_wait_queue(&gen_rtc_wait, &wait);
