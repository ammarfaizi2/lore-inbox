Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314333AbSDRM2R>; Thu, 18 Apr 2002 08:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314334AbSDRM2Q>; Thu, 18 Apr 2002 08:28:16 -0400
Received: from pop.gmx.net ([213.165.64.20]:38288 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S314333AbSDRM2Q>;
	Thu, 18 Apr 2002 08:28:16 -0400
Date: Thu, 18 Apr 2002 14:26:36 +0200
From: Sebastian Droege <sebastian.droege@gmx.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IDE TCQ #4
Message-Id: <20020418142636.10201a7f.sebastian.droege@gmx.de>
In-Reply-To: <3CBEABEF.1030009@evision-ventures.com>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="GQft+bLfO/T=.nme"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--GQft+bLfO/T=.nme
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Apr 2002 13:20:15 +0200
Martin Dalecki <dalecki@evision-ventures.com> wrote:

> Sebastian Droege wrote:
> > On Wed, 17 Apr 2002 12:42:39 +0200
> > Martin Dalecki <dalecki@evision-ventures.com> wrote:
> > 
> > 
> >>>2.
> >>>when I cat /proc/ide/ide1/hdc/identify I get 2 unexpected interrupts
> >>>hdc and hdd are both cdrom drives (accessed via scsi-emulation if relevant) 
> >>
> >> > but the problem shows up only with hdc
> >>
> >>Duh oh... This is actually a good hint. I will look after
> >>this.
> >>
> >>
> >>>and maybe a third problem ;)
> >>>in /proc/ide/ide0/hda/tcq there is written:
> >>>DMA status: not running
> >>
> >>This is harmless it just shows that there was no DMA transfer in flight the
> >>time you have cat-ed this file.
> >>
> >>
> >>>but DMA is explicitly enabled by hdparm and shows up in /proc/ide/ide0/hda/settings
> >>>
> >>>I'll do some more testings later the day
> >>
> > Hi again,
> > after some playing with hdparm I found something bad :(
> > 
> > ide_tcq_intr_timeout: timeout waiting for interrupt
> > ide_tcq_intr_timeout: hwgroup not busy
> > hda: invalidating pending queue
> > ide_tcq_invalidate_queue: done
> > 
> > and then... nothing works anymore -> total lockup of the IDE system
> > This happens only (?) when I put hdparm -qa1 -qA1 -qc1 -qd1 -qm16 -qu1 -qW1 /dev/hda (the same with hdb) in my bootscripts
> > When I start hdparm later everything works fine first, but after a while (and when I'm under X) the IDE system is crashed
> > 
> > I have enabled following options:
> > CONFIG_BLK_DEV_IDE_TCQ=y
> > CONFIG_BLK_DEV_IDE_TCQ_FULL=y
> > CONFIG_BLK_DEV_IDE_TCQ_DEFAULT=y
> > CONFIG_BLK_DEV_IDE_TCQ_DEPTH=32
> > 
> > I hope this helps somehow but I don't know what further informations I can provide
> > 
> > BTW: I think we should create devfs entries for ide-scsi devices (because hdparm doesn't take scdX ;) )
> > 
> > Bye
> 
> I don't know whatever you have already tryed the recend patches for 2.5.8.
> The problem in place is presumably fixed there (tough there are still
> problems with ide-cd remaining which I'm working on right now.)
> 
This problem exists also with your newest ide patches (I think 39 is the newest)
And again: I don't see how ide-cd can cause this problem... I access my cdroms via scsi-emulation and ide-cd isn't compiled into the kernel

Bye
--GQft+bLfO/T=.nme
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8vrt/e9FFpVVDScsRApRAAKDI9rEabdtg9OhBA30QSE3icxMB/wCg34aX
XJS4ccgzWvNGKm3mi8r0P30=
=c/7Z
-----END PGP SIGNATURE-----

--GQft+bLfO/T=.nme--

