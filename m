Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315754AbSFYU3N>; Tue, 25 Jun 2002 16:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315806AbSFYU3M>; Tue, 25 Jun 2002 16:29:12 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:46085 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S315754AbSFYU3L>; Tue, 25 Jun 2002 16:29:11 -0400
Date: Tue, 25 Jun 2002 16:33:54 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: "Shen, JT" <JT.Shen@hp.com>
Cc: andre@linux-ide.org, <linux-kernel@vger.kernel.org>
Subject: Re: ide driver bug fix for the error message "hda: bad special flag
 0x03"
In-Reply-To: <5A96E87E2BA0714ABBEA2C8F3F3F667C0AA680@cceexc19.americas.cpqcorp.net>
Message-ID: <Pine.LNX.4.44.0206251633300.10350-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mind to explain the problem in detail/

On Tue, 25 Jun 2002, Shen, JT wrote:

> diff -Naur linux-2.4.19-10/drivers/ide/ide-probe.c linux-2.4.19-11/drivers/ide/ide-probe.c
> --- linux-2.4.19-10/drivers/ide/ide-probe.c	Fri Jun 21 15:14:46 2002
> +++ linux-2.4.19-11/drivers/ide/ide-probe.c	Mon Jun 24 15:19:15 2002
> @@ -131,6 +131,7 @@
>  				type = ide_cdrom;	/* Early cdrom models used zero */
>  			case ide_cdrom:
>  				drive->removable = 1;
> +				drive->special.all = 0;
>  #ifdef CONFIG_PPC
>  				/* kludge for Apple PowerBook internal zip */
>  				if (!strstr(id->model, "CD-ROM") && strstr(id->model, "ZIP")) {
>
>
>
>
>
>
>
>
> Andre,
>
> Above is the patch that will fix the bug that when a user issue the command:
>
>    cat /proc/ide/hda/identify
>
> the message "hda: bad special flag 0x03" gets written to the system log.  This will happen because the .config file that RedHat uses to create the kernel image has the flag CONFIG_BLK_DEV_IDECD=m.  Thus in ide.c code, it won't call ide_cdrom_reinit(). So for CDROM the special flag is left as 0x03.
>
>
> The solution is to set the special flags to 0 when it is discovered as cdrom in ide-probe.c.
>
> Let me know if you have any question.
>
> Thanks,
>
> JT
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

