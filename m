Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129106AbRB1RiT>; Wed, 28 Feb 2001 12:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129116AbRB1RiJ>; Wed, 28 Feb 2001 12:38:09 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:59554 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S129106AbRB1Rh5>;
	Wed, 28 Feb 2001 12:37:57 -0500
Message-ID: <3A9D376A.18F4E6F0@mandrakesoft.com>
Date: Wed, 28 Feb 2001 12:37:46 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marek Michalkiewicz <marekm@amelek.gda.pl>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, marekm@linux.org.pl
Subject: Re: [patch] 2.4.2 Advantech WDT driver
In-Reply-To: <E14YAHv-0000Oq-00@mm.amelek.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marek Michalkiewicz wrote:
> +static int
> +advwdt_close(struct inode *inode, struct file *file)
> +{
> +       lock_kernel();
> +       if (MINOR(inode->i_rdev) == WATCHDOG_MINOR) {
> +               spin_lock(&advwdt_lock);
> +#ifndef CONFIG_WATCHDOG_NOWAYOUT
> +               inb_p(WDT_STOP);
> +#endif
> +               advwdt_is_open = 0;
> +               spin_unlock(&advwdt_lock);
> +       }
> +       unlock_kernel();
> +       return 0;
> +}

Why is lock_kernel necessary?


> +static int __init
> +advwdt_init(void)
> +{
> +       printk("WDT driver for Advantech single board computer initialising.\n");
> +
> +       spin_lock_init(&advwdt_lock);
> +       misc_register(&advwdt_miscdev);

check return code for error


> +#if WDT_START != WDT_STOP
> +       request_region(WDT_STOP, 1, "Advantech WDT");
> +#endif
> +       request_region(WDT_START, 1, "Advantech WDT");

check return..


> +       register_reboot_notifier(&advwdt_notifier);

ditto



-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
