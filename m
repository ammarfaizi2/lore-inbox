Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314330AbSDRMTe>; Thu, 18 Apr 2002 08:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314331AbSDRMTd>; Thu, 18 Apr 2002 08:19:33 -0400
Received: from mail.gmx.de ([213.165.64.20]:11374 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S314330AbSDRMTc>;
	Thu, 18 Apr 2002 08:19:32 -0400
Date: Thu, 18 Apr 2002 14:17:46 +0200
From: Sebastian Droege <sebastian.droege@gmx.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IDE TCQ #4
Message-Id: <20020418141746.2df4a948.sebastian.droege@gmx.de>
In-Reply-To: <3CBD519F.7080207@evision-ventures.com>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=..)So9GM?b(.J8t"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=..)So9GM?b(.J8t
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Apr 2002 12:42:39 +0200
Martin Dalecki <dalecki@evision-ventures.com> wrote:

> > 2.
> > when I cat /proc/ide/ide1/hdc/identify I get 2 unexpected interrupts
> > hdc and hdd are both cdrom drives (accessed via scsi-emulation if relevant) 
>  > but the problem shows up only with hdc
> 
> Duh oh... This is actually a good hint. I will look after
> this.
> 
> > 
> > and maybe a third problem ;)
> > in /proc/ide/ide0/hda/tcq there is written:
> > DMA status: not running
> 
> This is harmless it just shows that there was no DMA transfer in flight the
> time you have cat-ed this file.
> 
> > but DMA is explicitly enabled by hdparm and shows up in /proc/ide/ide0/hda/settings
> > 
> > I'll do some more testings later the day
Hi again,
after some playing with hdparm I found something bad :(

ide_tcq_intr_timeout: timeout waiting for interrupt
ide_tcq_intr_timeout: hwgroup not busy
hda: invalidating pending queue
ide_tcq_invalidate_queue: done

and then... nothing works anymore -> total lockup of the IDE system
This happens only (?) when I put hdparm -qa1 -qA1 -qc1 -qd1 -qm16 -qu1 -qW1 /dev/hda (the same with hdb) in my bootscripts
When I start hdparm later everything works fine first, but after a while (and when I'm under X) the IDE system is crashed

I have enabled following options:
CONFIG_BLK_DEV_IDE_TCQ=y
CONFIG_BLK_DEV_IDE_TCQ_FULL=y
CONFIG_BLK_DEV_IDE_TCQ_DEFAULT=y
CONFIG_BLK_DEV_IDE_TCQ_DEPTH=32

I hope this helps somehow but I don't know what further informations I can provide

BTW: I think we should create devfs entries for ide-scsi devices (because hdparm doesn't take scdX ;) )

Bye
--=..)So9GM?b(.J8t
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8vrlve9FFpVVDScsRAsINAJ0T8YBGshJpRQocfaP3ObcCpyvq8wCdHo6R
C+dYhCqo/DobwGGsNMCBkh4=
=Kwcw
-----END PGP SIGNATURE-----

--=..)So9GM?b(.J8t--

