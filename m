Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266565AbRGYV6o>; Wed, 25 Jul 2001 17:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266967AbRGYV6e>; Wed, 25 Jul 2001 17:58:34 -0400
Received: from rj.sgi.com ([204.94.215.100]:24793 "EHLO rj.corp.sgi.com")
	by vger.kernel.org with ESMTP id <S266565AbRGYV6X>;
	Wed, 25 Jul 2001 17:58:23 -0400
Date: Wed, 25 Jul 2001 14:58:28 -0700
From: richard offer <offer@sgi.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: unitialized variable in 2.4.7 (sym53c8xx, dmi_scan)
Message-ID: <214590000.996098308@changeling.engr.sgi.com>
In-Reply-To: <E15PW9s-0002hY-00@the-village.bc.nu>
In-Reply-To: <E15PW9s-0002hY-00@the-village.bc.nu>
X-Mailer: Mulberry/2.1.0b2 (Linux/x86)
X-HomePage: http://www.whitequeen.com/users/richard/
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



* frm alan@lxorguk.ukuu.org.uk "07/25/01 22:25:32 +0100" | sed '1,$s/^/* /'
*
*>  static __init int disable_ide_dma(struct dmi_blacklist *d)
*>  {
*>  # ifdef CONFIG_BLK_DEV_IDE
*> @@ -169,6 +170,7 @@
*>  # endif
*>         return 0;
*>  }
*> +#endif
* 
* This just makes it harder to finish the merges

Huh ? Was it a bad patch ?

* 
*> makes that automatic.
*> ===== drivers/scsi/sym53c8xx.c 1.6 vs edited =====
*> --- 1.6/drivers/scsi/sym53c8xx.c        Thu Jul  5 04:28:16 2001
*> +++ edited/drivers/scsi/sym53c8xx.c     Wed Jul 25 13:37:10 2001
*> @@ -6991,7 +6991,7 @@
*>  
*>  static void ncr_soft_reset(ncb_p np)
*>  {
*> -       u_char istat;
*> +       u_char istat=0;
*>         int i;
*>  
*>         if (!(np->features & FE_ISTAT1) || !(INB (nc_istat1) & SRUN))
* 
* And this means when we get a real bug with istat not being assigned it
* wont be seen.
* 

Isn't the only way that istat could be unassigned would be for the for loop
never to be executed. An unlikely event, but the compiler sees it as a
warning and means its not possible to build the code with -Werror.


richard.

-----------------------------------------------------------------------
Richard Offer                     Technical Lead, Trust Technology, SGI
"Specialization is for insects"
_______________________________________________________________________

