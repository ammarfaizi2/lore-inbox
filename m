Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261661AbULBQYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbULBQYK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 11:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbULBQYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 11:24:09 -0500
Received: from goliat.gorzow.mm.pl ([62.141.232.226]:48285 "EHLO gorzow.mm.pl")
	by vger.kernel.org with ESMTP id S261661AbULBQYB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 11:24:01 -0500
From: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
Reply-To: astralstorm@gorzow.mm.pl
To: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: Re: cdrecord dev=ATA cannont scanbus as non-root [u]
Date: Thu, 2 Dec 2004 17:23:48 +0100
User-Agent: KMail/1.7.1
Cc: Jens Axboe <axboe@suse.de>, "J.A. Magallon" <jamagallon@able.es>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Lista Linux-Kernel <linux-kernel@vger.kernel.org>
References: <1101763996l.13519l.0l@werewolf.able.es> <20041130071638.GC10450@suse.de> <1101935773.11949.86.camel@nosferatu.lan>
In-Reply-To: <1101935773.11949.86.camel@nosferatu.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412021723.48883.astralstorm@gorzow.mm.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 of December 2004 22:16, Martin Schlemmer [c] wrote:
> On Tue, 2004-11-30 at 08:16 +0100, Jens Axboe wrote:
> > On Mon, Nov 29 2004, J.A. Magallon wrote:
> > > dev=ATAPI uses ide-scsi interface, through /dev/sgX. And:
> > > > scsibus: -1 target: -1 lun: -1
> > > > Warning: Using ATA Packet interface.
> > > > Warning: The related Linux kernel interface code seems to be
> > > > unmaintained. Warning: There is absolutely NO DMA, operations thus
> > > > are slow.
> > >
> > > dev=ATA uses direct IDE burning. Try that as root. In my box, as root:
> >
> > Oh no, not this again... Please check the facts: the ATAPI method uses
> > the SG_IO ioctl, which is direct-to-device. It does _not_ go through
> > /dev/sgX, unless you actually give /dev/sgX as the device name. It has
> > nothing to do with ide-scsi. Period.
> >
> > ATA uses CDROM_SEND_PACKET. This has nothing to do with direct IDE
> > burning, it's a crippled interface from the CDROM layer that should not
> > be used for anything.  scsi-linux-ata.c should be ripped from the
> > cdrecord sources, or at least cdrecord should _never_ select that
> > transport for 2.6 kernels. For 2.4 you are far better off using
> > ide-scsi.
> >
> > > The scan through ATA lasts much less than with ATAPI, and you can burn
> > > with dev=ATA:1,0,0 or dev=/dev/burner, which is the new recommended
> > > way.
> >
> > No! ATAPI is the recommended way.
>
> Ok, so I am a bit confused here.  We basically have 3 ways to use
> cdrecord on linux-2.6 without ide-scsi:
>
> 1) cdrecord dev=/dev/hdx
> 2) cdrecord dev=ATA
> 3) cdrecord dev=ATAPI
>
> Now, if I run all three and grep for '^Warning', I get:
>
> -----
>  $ cdrecord dev=/dev/cdrw -scanbus 2>&1 | grep '^Warning'
> Warning: Open by 'devname' is unintentional and not supported.
>  $ cdrecord dev=ATA -scanbus 2>&1 | grep '^Warning'
> Warning: Using badly designed ATAPI via /dev/hd* interface.
>  $ cdrecord dev=ATAPI -scanbus 2>&1 | grep '^Warning'
> Warning: Using ATA Packet interface.
> Warning: The related Linux kernel interface code seems to be unmaintained.
> Warning: There is absolutely NO DMA, operations thus are slow.
>  $
> -----
>
> Which means:
>
> 1) dev=/dev/hdx - Open by 'devname' is unintentional and not supported.
> 2) dev=ATA - Using badly designed ATAPI via /dev/hd* interface.
> 3) dev=ATAPI - Using ATA Packet interface.
>                   (And some nice things about it not being maintained and
>                    slow)
>

Well, dev=ATA:nr,nr,nr will not produce any warning and works correctly with 
full performance.
dev=ATAPI:* gives bad performance and as stated above, shouldn't be used.
dev=/dev/hdx is just the same as dev=ATA:/dev/hdx, you can of course replace 
it with correct numbers if you know them or an alias 
in /etc/defaults/cdrecord.dfl (The path's from Gentoo, may be different 
elsewhere.)
