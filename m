Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263232AbUB1BNZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 20:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263239AbUB1BNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 20:13:25 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:28643 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263232AbUB1BNW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 20:13:22 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: andersen@codepoet.org
Subject: Re: Errors on 2th ide channel of promise ultra100 tx2
Date: Sat, 28 Feb 2004 02:20:22 +0100
User-Agent: KMail/1.5.3
References: <403F2178.70806@vanE.nl> <200402272114.23108.bzolnier@elka.pw.edu.pl> <20040227224431.GB984@codepoet.org>
In-Reply-To: <20040227224431.GB984@codepoet.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       John Bradford <john@grabjohn.com>, Erik van Engelen <Info@vanE.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402280220.22324.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 of February 2004 23:44, you wrote:
> On Fri Feb 27, 2004 at 09:14:23PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > ide-disk.c sends WIN_READ_NATIVE_MAX_{EXT} without checking
> > if HPA feature set is supported, this is fixed in 2.6.x for a long time.
> >
> > We need 2.4<->2.6 IDE sync monkey... a really smart one...
>
> Dunno if I qualify as sufficiently 'really smart' enough but the
> last time I put in the considerable effort needed to re-sync the
> 2.4 and 2.6 IDE layers, and merge in the useful -ac bits that
> never made it into mainstream, nothing whatsoever came of my
> efforts...

Did you actually split and send out your patches? :)

> My 2.4.x patches are in daily use by a large group of people
> and they work fine, for what it is worth.  My IDE merging
> patches are the following:
>
>     http://codepoet.org/kernel/
>
>     020_ide_layer_2.4.22-ac4.bz2

Needs splitting and most of this stuff needs new re-sync with 2.6. :-(

>     021_ide_geom_hpa_capacity64.bz2

Now I remember why this wasn't applied.
It breaks braindamaged HDIO_GETGEO_BIG_RAW ioctl
(because changes way drive->cyls is calculated).
We workaround-ed it in 2.6 by removing this ioctl. :)
I think we really should do the same for 2.4.

>     022-extra-ide-drives.bz2

This hack to allow > 10 interfaces
is useless without additional major numbers.

>     025-cenatek.patch.bz2

IDE controller for solid state disks?  Cool.

Bartlomiej

