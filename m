Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263129AbTKETmw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 14:42:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263130AbTKETmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 14:42:51 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:2813 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263129AbTKETmV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 14:42:21 -0500
Date: Wed, 5 Nov 2003 20:41:58 +0100 (MET)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Flavio Bruno Leitner <fbl@conectiva.com.br>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: IDE disk information changed from 2.4 to 2.6
In-Reply-To: <20031105184203.GG5304@conectiva.com.br>
Message-ID: <Pine.SOL.4.30.0311052031510.1988-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 5 Nov 2003, Flavio Bruno Leitner wrote:

> On Wed, Nov 05, 2003 at 06:29:07PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > On Wed, 5 Nov 2003, Flavio Bruno Leitner wrote:
> > > Using 2.4:
> > > hda: 12594960 sectors (6449 MB) w/2048KiB Cache, CHS=784/255/63, UDMA (33)
> > >
> > > Using 2.6:
> > > hda: 12594960 sectors (6449 MB) w/2048KiB Cache, CHS=13328/15/63, UDMA (33)
>
> The line with CHS=784/255/63 is LBA and CHS=13328/15/63 is NORMAL.
>
> Where kernel check to see if is LBA or NORMAL? BIOS? Which line is correct?

Nowhere, kernel uses LBA whenever possible.

In 2.6.x it doesn't even read BIOS info (which is wrong IMO, it should
do this but only as last resort - if partition can't be mounted).

Difference in CHS translation should matter only if you have some old DOS
partitions created using CHS information.  Then you can force geometry
using boot parameter "hd?=".  Unfortunately I've seen recently bugreport
when 2.4.20 (?) works and 2.6.x fails even with forced geometry.

--bartlomiej

