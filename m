Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290796AbSBLGri>; Tue, 12 Feb 2002 01:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290797AbSBLGrT>; Tue, 12 Feb 2002 01:47:19 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17163 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S290796AbSBLGrH>;
	Tue, 12 Feb 2002 01:47:07 -0500
Message-ID: <3C68BA63.E30DDF51@mandrakesoft.com>
Date: Tue, 12 Feb 2002 01:46:59 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
CC: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        Kernel Janitors <kernel-janitor-discuss@lists.sourceforge.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] printk prefix cleanups.
In-Reply-To: <Pine.LNX.4.44.0202120823200.27768-100000@netfinity.realnet.co.sz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> 
> Here is a simple patch which reduces resultant binary size by 1.2k for
> this particular module (opl3sa2). Perhaps we should consider adding this
> on the janitor TODO list for cleaning up other printks.
> 
> Regards,
>         Zwane Mwaikambo
> 
> --- linux-2.4.18-pre8-zm1/drivers/sound/opl3sa2.c.orig  Mon Feb 11 02:25:50 2002
> +++ linux-2.4.18-pre8-zm1/drivers/sound/opl3sa2.c       Mon Feb 11 02:40:59 2002
> @@ -71,6 +71,7 @@
>  #include "mpu401.h"
> 
>  #define OPL3SA2_MODULE_NAME    "opl3sa2"
> +#define OPL3SA2_PFX            OPL3SA2_MODULE_NAME ": "
> 
>  /* Useful control port indexes: */
>  #define OPL3SA2_PM          0x01
> @@ -616,7 +617,7 @@
>                         AD1848_REROUTE(SOUND_MIXER_LINE3, SOUND_MIXER_LINE);
>                 }
>                 else {
> -                       printk(KERN_ERR "opl3sa2: MSS mixer not installed?\n");
> +                       printk(KERN_ERR OPL3SA2_PFX "MSS mixer not installed?\n");
>                 }
>         }
>  }
> @@ -639,7 +640,7 @@
>          * Try and allocate our I/O port range.
>          */
>         if(!request_region(hw_config->io_base, 2, OPL3SA2_MODULE_NAME)) {
> -               printk(KERN_ERR "opl3sa2: Control I/O port %#x not free\n",
> +               printk(KERN_ERR OPL3SA2_PFX "Control I/O port %#x not free\n",

This reduces -binary- size, as shown by /usr/bin/size?  Strings should
be merged, which makes this strange...

Anyway, I might be able to claim to be the first user of 'PFX'.  You
will note that it does not have a prefix... on purpose.  The idea is to
save typing a repetitive and changing-for-each-driver string.

Just use 'PFX' in the source code, like you find in other drivers.

	Jeff




-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
