Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264478AbTIDAyt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 20:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264464AbTIDAyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 20:54:49 -0400
Received: from h008.c000.snv.cp.net ([209.228.32.72]:53380 "HELO
	c000.snv.cp.net") by vger.kernel.org with SMTP id S264478AbTIDAym
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 20:54:42 -0400
X-Sent: 4 Sep 2003 00:54:27 GMT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-kernel@vger.kernel.org
From: "Brien" <admin@brien.com>
Subject: Re: SATA probe delay on boot
X-Sent-From: admin@brien.com
Date: Wed, 03 Sep 2003 20:54:16 -0400 (EDT)
X-Mailer: Web Mail 5.5.0-3_sol28
Message-Id: <20030903175427.14172.h003.c000.wm@mail.brien.com.criticalpath.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej,

"ide3=noprobe" doesn't make a noticable difference, but
I'll tell what happens with the patch when I get home
and am able to try it 

(just so you know it may be several hours before I'm
able to reply again)

Thanks much,

Brien

On Thu, 4 Sep 2003 01:53:07 +0200, Bartlomiej
Zolnierkiewicz wrote:

> On Thursday 04 of September 2003 01:18,
admin@brien.com
> wrote:
> > Hi,
> 
> Hi,
> 
> > I have a Sil3112A SATA controller, which linux works
> OK
> > with. It supports RAID (up to 4 devices), but I'm
> using
> > BASE option -- only 1 hard drive.
> >
> > My question is regarding a 15-20 second delay which
> > normally occurs every time I boot, unless I pass the
> 
> Please try attached patch and send dmesg output (with
> patch applied).
> Patch is against current 2.6-bk tree, but should apply
> to any recent
> 2.4.x or 2.6.x kernels.
> 
> diff -puN drivers/ide/ide-probe.c~ide-siimage-wait
> drivers/ide/ide-probe.c
> ---
>
linux-2.6.0-test4-bk5/drivers/ide/ide-probe.c~ide-siimage-wait	2003-09-04 01:34:02.285489272 +0200
> +++
>
linux-2.6.0-test4-bk5-root/drivers/ide/ide-probe.c	2003-09-04 01:47:58.145419248 +0200
> @@ -56,6 +56,8 @@
>  #include <asm/uaccess.h>
>  #include <asm/io.h>
>  
> +#define DEBUG
> +
>  /**
>   *	generic_id		-	add a generic drive id
>   *	@drive:	drive to make an ID block for
> @@ -345,7 +347,16 @@ static int actual_try_to_identify
> (ide_d
>  		}
>  		/* give drive a breather */
>  		ide_delay_50ms();
> -	} while ((hwif->INB(hd_status)) & BUSY_STAT);
> +		s = hwif->INB(hd_status);
> +		if (s == 0xff) {
> +#ifdef DEBUG
> +			printk("%s: status == 0xff\n", drive->name);
> +#endif
> +			return 1;
> +		}
> +		if ((s & BUSY_STAT) == 0)
> +			break;
> +	} while (1);
>  
>  	/* wait for IRQ and DRQ_STAT */
>  	ide_delay_50ms();
> 
> _
> 
> > options ide3=0 - ide9=0 to fill up the device
table. I
> > think I have to do this because if I do only ide3=0
> > (where the device would be), it uses ide4, and so
on.
> I
> > have GRUB set up to do this automatically, but it's
> not
> > exactly adequate (,is it?). So I was wondering if
> > there're any other ways to get the same affect. Is
or
> > could there be an option to simply disable the
probing
> > of the one specific device/channel every time?
> 
> "ide3=noprobe" doesnt work?
> 
> --bartlomiej

Brien
