Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262646AbSI0XpC>; Fri, 27 Sep 2002 19:45:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262648AbSI0XpC>; Fri, 27 Sep 2002 19:45:02 -0400
Received: from packet.digeo.com ([12.110.80.53]:39822 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262646AbSI0XpB>;
	Fri, 27 Sep 2002 19:45:01 -0400
Message-ID: <3D94EEBF.D6328392@digeo.com>
Date: Fri, 27 Sep 2002 16:50:23 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Sleeping function called from illegal context...
References: <20020927233044.GA14234@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Sep 2002 23:50:15.0479 (UTC) FILETIME=[A0862C70:01C26680]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> 
> So I got bold and enabled CONFIG_PREEMPT in 2.5.39, and got the
> following message at boot time:
> 
> Sleeping function called from illegal context at slab.c:1374
> c12a5ea8 c0117a26 c0296260 c0298202 0000055e c1283060 c013ab4f c0298202
>        0000055e c03b668c 00000002 00000003 c01ff5ec c03b668c 00000042 c12838e0
>        c12838e0 c12838e0 00000246 cfdee214 c0207830 04000000 c03b65f0 c0109be2
> Call Trace:
>  [<c0117a26>]__might_sleep+0x56/0x5d
>  [<c013ab4f>]kmalloc+0x4f/0x330
>  [<c01ff5ec>]piix_tune_chipset+0x33c/0x350
>  [<c0207830>]ide_intr+0x0/0x320
>  [<c0109be2>]request_irq+0x52/0xa0
>  [<c0200a33>]init_irq+0x263/0x400
>  [<c0207830>]ide_intr+0x0/0x320
>  [<c0200edc>]hwif_init+0x10c/0x260
>  [<c02006ad>]probe_hwif_init+0x1d/0x70
>  [<c02121d1>]ide_setup_pci_device+0x41/0x70
>  [<c01ff7a5>]piix_init_one+0x35/0x40
>  [<c010511b>]init+0x8b/0x250
>  [<c0105090>]init+0x0/0x250
>  [<c01055f9>]kernel_thread_helper+0x5/0xc
> 

Everyone will get this.  It's IDE's init_irq() function doing
unsafe things inside ide_lock.

It'll be quite harmless at boot-time, but it'd be nice to get
it fixed up.
