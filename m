Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291701AbSBALUn>; Fri, 1 Feb 2002 06:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291704AbSBALUd>; Fri, 1 Feb 2002 06:20:33 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:47373
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S291701AbSBALUV>; Fri, 1 Feb 2002 06:20:21 -0500
Date: Fri, 1 Feb 2002 03:12:13 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Joerg Pommnitz <pommnitz@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: RE: false positives on disk change checks
In-Reply-To: <20020201102753.90799.qmail@web13308.mail.yahoo.com>
Message-ID: <Pine.LNX.4.10.10202010309090.22985-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Feb 2002, Joerg Pommnitz wrote:

> I wrote:
> 
> > I don't know the original posters problem, but I suspect I see something
> > similar. On a to be embedded system with a Geode (Cyrix) CPU and with a
> > ATA compatible CompactFlash drive I get the following messages on 
> > bootup:
> > 
> > invalidate: busy buffer
> > VFS: busy inodes on changed media.
> > 
> > This seems to happen while the system tries to remount the root fs rw.
> 
> The following patch works around the problem for me:
> 
> diff -ruN linux/drivers/ide/ide-probe.c
> linux-scorpio/drivers/ide/ide-probe.c
> --- linux/drivers/ide/ide-probe.c       Mon Nov 26 14:29:17 2001
> +++ linux-scorpio/drivers/ide/ide-probe.c       Fri Feb  1 12:06:59 2002
> @@ -154,11 +154,14 @@
>                 return;
>         }
> 
> +#if 0
>         /*
>          * Not an ATAPI device: looks like a "regular" hard disk
>          */
>         if (id->config & (1<<7))
>                 drive->removable = 1;
> +#endif
> +
>         /*
>          * Prevent long system lockup probing later for non-existant
>          * slave drive if the hwif is actually a flash memory card of some
> variety:
> 
> It's obviously not a general solution but I know for sure that
> the flashdisk is not removable in our setup.

REGARDLESS, it is removable media and this it reports so.
The driver will not change to create false reports, because CFA has its
own rules, and if you can figure them out great.

Removable media shall always report as Removable media.

If you purchase enough of the media, the OEM will allow you to alter the
identify page and this it will not longer report "Removable".

Regards,


Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

