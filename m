Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267384AbRGYVYu>; Wed, 25 Jul 2001 17:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268107AbRGYVYk>; Wed, 25 Jul 2001 17:24:40 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:29703 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267384AbRGYVYW>; Wed, 25 Jul 2001 17:24:22 -0400
Subject: Re: unitialized variable in 2.4.7 (sym53c8xx, dmi_scan)
To: offer@sgi.com (richard offer)
Date: Wed, 25 Jul 2001 22:25:32 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <177030000.996093821@changeling.engr.sgi.com> from "richard offer" at Jul 25, 2001 01:43:41 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15PW9s-0002hY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

>  static __init int disable_ide_dma(struct dmi_blacklist *d)
>  {
>  #ifdef CONFIG_BLK_DEV_IDE
> @@ -169,6 +170,7 @@
>  #endif
>         return 0;
>  }
> +#endif

This just makes it harder to finish the merges

> makes that automatic.
> ===== drivers/scsi/sym53c8xx.c 1.6 vs edited =====
> --- 1.6/drivers/scsi/sym53c8xx.c        Thu Jul  5 04:28:16 2001
> +++ edited/drivers/scsi/sym53c8xx.c     Wed Jul 25 13:37:10 2001
> @@ -6991,7 +6991,7 @@
>  
>  static void ncr_soft_reset(ncb_p np)
>  {
> -       u_char istat;
> +       u_char istat=0;
>         int i;
>  
>         if (!(np->features & FE_ISTAT1) || !(INB (nc_istat1) & SRUN))

And this means when we get a real bug with istat not being assigned it
wont be seen.

