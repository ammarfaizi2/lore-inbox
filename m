Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129187AbQKJFIq>; Fri, 10 Nov 2000 00:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129296AbQKJFIg>; Fri, 10 Nov 2000 00:08:36 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:19470 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129187AbQKJFI2>;
	Fri, 10 Nov 2000 00:08:28 -0500
Message-ID: <3A0B8295.7606DA1F@mandrakesoft.com>
Date: Fri, 10 Nov 2000 00:07:33 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: John Kacur <jkacur@home.com>, linux-kernel@vger.kernel.org
Subject: Re: test11-pre2 compile error undefined reference to `bust_spinlocks'
In-Reply-To: <23327.973832257@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> Index: 0-test11-pre2.1/arch/i386/kernel/traps.c
> --- 0-test11-pre2.1/arch/i386/kernel/traps.c Fri, 10 Nov 2000 13:10:37 +1100 kaos (linux-2.4/A/c/1_traps.c 1.1.2.2.1.1.2.1.2.3.1.2.3.1.1.2 644)
> +++ 0-test11-pre2.1(w)/arch/i386/kernel/traps.c Fri, 10 Nov 2000 15:56:54 +1100 kaos (linux-2.4/A/c/1_traps.c 1.1.2.2.1.1.2.1.2.3.1.2.3.1.1.2 644)
> @@ -382,6 +382,17 @@ static void unknown_nmi_error(unsigned c
>         printk("Do you have a strange power saving mode enabled?\n");
>  }
> 
> +/*
> + * Unlock any spinlocks which will prevent us from getting the
> + * message out (timerlist_lock is acquired through the
> + * console unblank code)
> + */
> +void bust_spinlocks(void)
> +{
> +       spin_lock_init(&console_lock);
> +       spin_lock_init(&timerlist_lock);
> +}
> +
>  #if CONFIG_X86_IO_APIC
> 
>  int nmi_watchdog = 1;
> @@ -396,17 +407,6 @@ __setup("nmi_watchdog=", setup_nmi_watch
> 
>  extern spinlock_t console_lock, timerlist_lock;
>  static spinlock_t nmi_print_lock = SPIN_LOCK_UNLOCKED;

Did you actually try this?  You are moving bust_spinlocks above the
'extern spinlock_t' declarations intended for it.

My solution was to move the 'extern spinlock_t ...' also :)

	Jeff


-- 
Jeff Garzik             |
Building 1024           | Would you like a Twinkie?
MandrakeSoft            |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
