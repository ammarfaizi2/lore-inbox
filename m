Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271702AbRH0LQ4>; Mon, 27 Aug 2001 07:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271703AbRH0LQq>; Mon, 27 Aug 2001 07:16:46 -0400
Received: from t2.redhat.com ([199.183.24.243]:40440 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S271702AbRH0LQa>; Mon, 27 Aug 2001 07:16:30 -0400
Message-ID: <3B8A2C1F.63AF4AE7@redhat.com>
Date: Mon, 27 Aug 2001 12:16:47 +0100
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-2.9smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Per Niva <pna@mendosus.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Added devfs support for i386 msr/cpuid driver
In-Reply-To: <Pine.LNX.4.33.0108271031010.12684-102000@subcentral.mendosus.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
>  int __init msr_init(void)
>  {
> +#ifdef CONFIG_DEVFS_FS
> +    devfs_handle = devfs_register(NULL, "cpu/msr", DEVFS_FL_DEFAULT, 0, 0,
> +                                  S_IFREG | S_IRUGO | S_IWUSR,
> +                                  &msr_fops, NULL);
> +#else
>    if (register_chrdev(MSR_MAJOR, "cpu/msr", &msr_fops)) {
>      printk(KERN_ERR "msr: unable to get major %d for msr\n",
>            MSR_MAJOR);
>      return -EBUSY;
>    }
> +#endif

this must be wrong as you don't check for devfs_register failures...



Also why devfs can't just use register_chrdev and not touch ALL drivers 
is beyond me, but it has been like that for a while now...
