Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751331AbWGJEyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbWGJEyN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 00:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbWGJEyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 00:54:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12936 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751331AbWGJEyL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 00:54:11 -0400
Date: Sun, 9 Jul 2006 21:54:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] Clean up old names in tty code to current names
Message-Id: <20060709215407.e6845228.akpm@osdl.org>
In-Reply-To: <9e4733910607092111i4c41c610u8b9df5b917cca02c@mail.gmail.com>
References: <9e4733910607092111i4c41c610u8b9df5b917cca02c@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2006 00:11:11 -0400
"Jon Smirl" <jonsmirl@gmail.com> wrote:

> Fix various places in the tty code to make it match the current naming system.
> 

eh?

> 
> diff --git a/drivers/char/pty.c b/drivers/char/pty.c
> index 34dd4c3..af43f37 100644
> --- a/drivers/char/pty.c
> +++ b/drivers/char/pty.c
> @@ -279,7 +279,7 @@ static void __init legacy_pty_init(void)
> 
>  	pty_slave_driver->owner = THIS_MODULE;
>  	pty_slave_driver->driver_name = "pty_slave";
> -	pty_slave_driver->name = "ttyp";
> +	pty_slave_driver->name = "pts";
>  	pty_slave_driver->major = PTY_SLAVE_MAJOR;
>  	pty_slave_driver->minor_start = 0;
>  	pty_slave_driver->type = TTY_DRIVER_TYPE_PTY;
> diff --git a/drivers/char/tty_io.c b/drivers/char/tty_io.c
> index bfdb902..4a83e94 100644
> --- a/drivers/char/tty_io.c
> +++ b/drivers/char/tty_io.c
> @@ -3245,7 +3245,7 @@ #endif
>  #ifdef CONFIG_VT
>  	cdev_init(&vc0_cdev, &console_fops);
>  	if (cdev_add(&vc0_cdev, MKDEV(TTY_MAJOR, 0), 1) ||
> -	    register_chrdev_region(MKDEV(TTY_MAJOR, 0), 1, "/dev/vc/0") < 0)
> +	    register_chrdev_region(MKDEV(TTY_MAJOR, 0), 1, "/dev/tty0") < 0)
>  		panic("Couldn't register /dev/tty0 driver\n");
>  	class_device_create(tty_class, NULL, MKDEV(TTY_MAJOR, 0), NULL, "tty0");
> 
> diff --git a/drivers/char/vt.c b/drivers/char/vt.c
> index da7e66a..a627e8b 100644
> --- a/drivers/char/vt.c
> +++ b/drivers/char/vt.c
> @@ -2662,6 +2662,7 @@ int __init vty_init(void)
>  	if (!console_driver)
>  		panic("Couldn't allocate console driver\n");
>  	console_driver->owner = THIS_MODULE;
> +	console_driver->driver_name = "vtconsole";
>  	console_driver->name = "tty";
>  	console_driver->name_base = 1;
>  	console_driver->major = TTY_MAJOR;
> diff --git a/fs/proc/proc_tty.c b/fs/proc/proc_tty.c
> index 15c4455..042aefe 100644
> --- a/fs/proc/proc_tty.c
> +++ b/fs/proc/proc_tty.c
> @@ -48,7 +48,7 @@ static void show_tty_range(struct seq_fi
>  			seq_printf(m, ":vtmaster");
>  		break;
>  	case TTY_DRIVER_TYPE_CONSOLE:
> -		seq_printf(m, "console");
> +		seq_printf(m, "vt:console");

This seems to be changing a whole pile of userspace-visible stuff.

Tell us more.  Much more.
