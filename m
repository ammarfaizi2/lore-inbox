Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263598AbTK2MwM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 07:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263650AbTK2MwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 07:52:12 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:53252 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S263598AbTK2MwL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 07:52:11 -0500
Date: Sat, 29 Nov 2003 13:41:16 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Szakacsits Szabolcs <szaka@sienet.hu>, Andrew Clausen <clausen@gnu.org>,
       Apurva Mehta <apurva@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bug-parted@gnu.org
Subject: Re: Disk Geometries reported incorrectly on 2.6.0-testX
Message-ID: <20031129124116.GB5372@win.tue.nl>
References: <20031128045854.GA1353@home.woodlands> <20031128142452.GA4737@win.tue.nl> <20031129022221.GA516@gnu.org> <Pine.LNX.4.58.0311290550190.21441@ua178d119.elisa.omakaista.fi> <20031129091843.GA2430@iliana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031129091843.GA2430@iliana>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Also, can Parted save/restore the full and exact partition table a
> > scriptable way? I mean something like this:
> > 
> > 	sfdisk -d /dev/hda > hda.pt       # save
> > 	sfdisk /dev/hda < hda.pt          # restore
> > 
> > sfdisk can't recover geometry so apparently no one-liner, widely available,
> > partition table backup/recovery is possible at present on Linux :-o
> > dd if=/dev/hda of=hda.mbr bs=512 count=1 won't save the logical partitions.

sfdisk has a slightly different option: -O will save all sectors that
you change during an sfdisk operation, so that you can restore them later.

You see, saving the logical partitions is not enough - these sectors
are spread out over the disk, and there used to be something else
where these sectors are written. If the user makes a partitioning mistake
he destroys a sector worth of data. It is that data that sfdisk -O will save
(and -I will restore).

