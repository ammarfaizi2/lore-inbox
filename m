Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266078AbUALIQI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 03:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266080AbUALIQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 03:16:08 -0500
Received: from AGrenoble-101-1-2-83.w193-253.abo.wanadoo.fr ([193.253.227.83]:13997
	"EHLO awak.dyndns.org") by vger.kernel.org with ESMTP
	id S266078AbUALIQG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 03:16:06 -0500
Subject: Re: 2.6.0: blkdev_get() oopses on floppy
From: Xavier Bestel <xavier.bestel@free.fr>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1073894153.950.19.camel@nomade>
References: <1073861431.5014.85.camel@bip.parateam.prv>
	 <20040112015238.GH30321@parcelfarce.linux.theplanet.co.uk>
	 <1073894153.950.19.camel@nomade>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1073895358.950.38.camel@nomade>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 12 Jan 2004 09:16:00 +0100
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le lun 12/01/2004 à 08:55, Xavier Bestel a écrit :
> > *NOTE*:  unless you are really forced to, don't use that "open by device
> > number" crap at all - normal filp_open() will do nicely if you have the
> > pathname of device in question and it's _much_ better interface.
> 
> But that's exactely what raw.c does (although the userspace knows the
> dev pathname).

Aye, userspace doesn't always know it, and the ioctl for /dev/rawctl
only uses major:minor.
That's too bad, because raw.c is one of the few users of blkdev_get() in
the kernel (the others being drivers/s390/block/dasd_genhd.c,
partitions/check.c and fs/block_dev.c itself). Could have got rid of
this crap :)

	Xav

