Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbUBCPWW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 10:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265856AbUBCPWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 10:22:22 -0500
Received: from chaos.analogic.com ([204.178.40.224]:36227 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263806AbUBCPWT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 10:22:19 -0500
Date: Tue, 3 Feb 2004 10:24:14 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Tomas Zvala <tomas@zvala.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0, cdrom still showing directories after being erased
In-Reply-To: <401FB78A.5010902@zvala.cz>
Message-ID: <Pine.LNX.4.53.0402031018170.31411@chaos>
References: <20040203131837.GF3967@aurora.fi.muni.cz> <Pine.LNX.4.53.0402030839380.31203@chaos>
 <401FB78A.5010902@zvala.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Feb 2004, Tomas Zvala wrote:

> Hi,
> I believe he meant to write he umounted it.
> The problem is that there is still some data left in CDRW's cache and it
> needs to be emptied. That happens when CDRW is ejected and reinserted
> (that is why windows burning software ie. Nero wants to eject the CDR/RW
> when it gets written or erased).
> Maybe kernel could flush the buffers/caches or whatever is there when
> CDROM gets mounted. But im afraid about compatibility with broken drives
> such as LG.
>
> Tomas Zvala

That's not what he said and, I assure you that if he unmounted
it there would not be any buffers to flush. Execute `man umount`.

The problem is that the cd-burner allowed the read-only file-system
to be modified while it was mounted. That is an applications problem
because the file-system is R/O, but the device is not. The kernel
will correctly prevent writes to the R/O file-system, and will
correctly allow writes to the underlying device. It is up to
the application (cdrecord) to prevent undesired operations.

>
> Richard B. Johnson wrote:
>
> >On Tue, 3 Feb 2004, Martin [iso-8859-2] Povolný wrote:
> >
> >
> >
> >>I have debian's 2.6.0-686-smp only with PNP BIOS disabled (fails to
> >>boot with enabled, as described by other people).
> >>
> >>I did
> >>
> >>$ mount /cdrom/
> >>$ ls /cdrom/
> >>
> >>got listing of files and directories on the cdrom
> >>then
> >>
> >>$ cdrecord dev=/dev/hdc -blank=fast -v
> >>...
> >>Blanking time:   21.570s
> >>$ mount /cdrom
> >>$ ls /cdrom
> >>
> >>
> >
> >Can you really initialize the CDROM while it's mounted? Although
> >the kernel doesn't care, cdrecord should. Suggest that you
> >contact the cdrecord author.
> >
> >Cheers,
> >Dick Johnson
> >Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
> >            Note 96.31% of all statistics are fiction.
> >
> >
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> >
> >
> >
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


