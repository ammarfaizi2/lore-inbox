Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129187AbQKTUsY>; Mon, 20 Nov 2000 15:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129189AbQKTUsP>; Mon, 20 Nov 2000 15:48:15 -0500
Received: from nat-su-33.valinux.com ([198.186.202.33]:61562 "EHLO
	phenoxide.engr.valinux.com") by vger.kernel.org with ESMTP
	id <S129187AbQKTUr7>; Mon, 20 Nov 2000 15:47:59 -0500
Date: Mon, 20 Nov 2000 12:17:46 -0800
From: Johannes Erdfelt <jerdfelt@valinux.com>
To: Oleg Drokin <green@ixcelerator.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hardcoded HZ in hub.c
Message-ID: <20001120121746.F895@valinux.com>
In-Reply-To: <20001117125441.A28208@iXcelerator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001117125441.A28208@iXcelerator.com>; from green@ixcelerator.com on Fri, Nov 17, 2000 at 12:54:41PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2000, Oleg Drokin <green@ixcelerator.com> wrote:
>     hub.c in 2.4.0-test10 and above contains hardcoded HZ value,
>     which is wrong. Here is the patch:
> 
> 
> --- drivers/usb/hub.c.orig	Fri Nov 17 12:51:34 2000
> +++ drivers/usb/hub.c	Fri Nov 17 12:51:59 2000
> @@ -813,7 +813,7 @@
>  	ret = kill_proc(khubd_pid, SIGTERM, 1);
>  	if (!ret) {
>  		/* Wait 10 seconds */
> -		int count = 10 * 100;
> +		int count = 10 * HZ;
>  
>  		while (khubd_running && --count) {
>  			current->state = TASK_INTERRUPTIBLE;

We applied a slightly different patch which is would not remove the pages
out from under the thread, using semaphores instead.

This patch isn't needed anymore. Thanks anyway.

JE

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
