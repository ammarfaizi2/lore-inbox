Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423443AbWBBKVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423443AbWBBKVE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 05:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423444AbWBBKVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 05:21:04 -0500
Received: from mail.gmx.net ([213.165.64.21]:26852 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1423443AbWBBKVD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 05:21:03 -0500
X-Authenticated: #428038
Date: Thu, 2 Feb 2006 11:20:58 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: bzolnier@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060202102058.GB10554@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	bzolnier@gmail.com, linux-kernel@vger.kernel.org
References: <20060125230850.GA2137@merlin.emma.line.org> <43D8C04F.nailE1C2X9KNC@burner> <43DDFBFF.nail16Z3N3C0M@burner> <1138642683.7404.31.camel@juerg-pd.bitron.ch> <43DF3C3A.nail2RF112LAB@burner> <58cb370e0601310410r46210e8dvc66f631f208e9b8d@mail.gmail.com> <43DF678E.nail3B431CUWJ@burner> <58cb370e0601310623ic220d27q3bfd4642cd0538fb@mail.gmail.com> <Pine.LNX.4.61.0602011630440.22529@yvahk01.tjqt.qr> <43E1D5AD.nail4MI2R8NR2@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E1D5AD.nail4MI2R8NR2@burner>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2006-02-02:

> Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> 
> > Which unfortunately leads us back to one of the early questions.
> >
> > If ATAPI is some sort of SCSI [command set] over ATA, and ide-cd can be used
> > without the "Big Bad" SCSI layer (CONFIG_SCSI), don't we have redundant code
> > floating around?
> 
> CONFIG_SCSI???
> 
> Why not using fully dynamical loadable kernel modules as done with Solaris 
> since 1992? Since that time nobody cares because what you need is auto-loaded 
> on demand and there is absolutely no need for a manual configuration.

You mean:

Module                  Size  Used by
...
scsi_transport_spi     20864  1 sym53c8xx
scsi_mod              131304  7 st,sr_mod,sg,sym53c8xx,scsi_transport_spi,libata,sd_mod
...

autoloaded on boot, and scsi_mod has verbose sense strings built in
(call it bloat, but on a Peeceeh a few kB don't hurt).

libata is Linux's SATA driver, still under development but quite solid
for some chips, such as via 82*. Chances are that adding PATA to libata
(which is planned or in the works) obsoletes your whole ATAPI ide-* module
arguments, sym53c8xx - no surprise - the host adaptor driver, sr/sd_mod
the CD-ROM and disk block drivers, st and sg tape and generic drivers.

> BTW: Introducing an orthogonal SCSI based implementation would save a lot of
> code. The model currently used on Linux is duplicating a lot of unneeded code 
> in target drivers and the SCSI glue code is only a few KB (less than 30k on 
> Solaris). 

You've been stating this oft enough now. It won't change in a day even
if you post this every hour. Please cease posting the same stuff over
and over again.

-- 
Matthias Andree
