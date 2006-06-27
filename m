Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932547AbWF0Trm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932547AbWF0Trm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 15:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbWF0Trm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 15:47:42 -0400
Received: from xenotime.net ([66.160.160.81]:24254 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932547AbWF0Trl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 15:47:41 -0400
Date: Tue, 27 Jun 2006 12:50:24 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Jon Smirl" <jonsmirl@gmail.com>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, adaplas@gmail.com
Subject: Re: [PATCH] move MAX_NR_CONSOLES from tty.h to vt.h
Message-Id: <20060627125024.45ad9f91.rdunlap@xenotime.net>
In-Reply-To: <9e4733910606271203w4ceb6216g92f5fefee654aaf3@mail.gmail.com>
References: <9e4733910606271203w4ceb6216g92f5fefee654aaf3@mail.gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jun 2006 15:03:50 -0400 Jon Smirl wrote:

> MAX_NR_CONSOLES is more of a function of the VT layer than the TTY
> one. Moving this to vt.h allows all of the framebuffer drivers to
> remove their dependency on tty.h. Note that console drivers in
> video/console still depend on tty.h but fbdev drivers should not
> depend on the tty layer.
> 
> Signed-off-by: Jon Smirl <jonsmir@gmail.com>

BTW, what are these other 2 added #includes about?

> diff --git a/drivers/video/vga16fb.c b/drivers/video/vga16fb.c
> index 4fd2a27..608fba0 100644
> --- a/drivers/video/vga16fb.c
> +++ b/drivers/video/vga16fb.c
> @@ -15,13 +15,13 @@ #include <linux/kernel.h>
>  #include <linux/errno.h>
>  #include <linux/string.h>
>  #include <linux/mm.h>
> -#include <linux/tty.h>
>  #include <linux/slab.h>
>  #include <linux/delay.h>
>  #include <linux/fb.h>
>  #include <linux/ioport.h>
>  #include <linux/init.h>
>  #include <linux/platform_device.h>
> +#include <linux/screen_info.h>
> 
>  #include <asm/io.h>
>  #include <video/vga.h>
> diff --git a/include/linux/console_struct.h b/include/linux/console_struct.h
> index f8e5587..25423f7 100644
> --- a/include/linux/console_struct.h
> +++ b/include/linux/console_struct.h
> @@ -9,6 +9,7 @@
>   * to achieve effects such as fast scrolling by changing the origin.
>   */
> 
> +#include <linux/wait.h>
>  #include <linux/vt.h>
> 
>  struct vt_struct;

---
~Randy
