Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270677AbTHAU54 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 16:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270865AbTHAU54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 16:57:56 -0400
Received: from [217.157.19.70] ([217.157.19.70]:21261 "EHLO jehova.dsm.dk")
	by vger.kernel.org with ESMTP id S270677AbTHAU5y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 16:57:54 -0400
Date: Fri, 1 Aug 2003 22:57:53 +0200 (CEST)
From: Thomas Horsten <thomas@horsten.com>
X-X-Sender: thomas@jehova.dsm.dk
To: linux-kernel@vger.kernel.org
cc: Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [PATCH] (2.4.2x) Driver for Medley software RAID (Silicon Image
 3112 SATARaid, CMD680, etc?) for testing (fwd)
Message-ID: <Pine.LNX.4.40.0308012253320.29551-100000@jehova.dsm.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Aug 2003, Arjan van de Ven wrote:

> On Fri, Aug 01, 2003 at 10:24:13PM +0200, Thomas Horsten wrote:
> > I have written a driver for Medley software RAID as used by Silicon Image
> > 3112 SATA IDE controller, and also other IDE RAID controllers like CMD680
> > based ones (and possibly others). Currently it's only for 2.4.2X.
> >
> > This driver uses the ATA RAID driver framework and is based on code from
> > Arjan van de Ven's silraid.c and hptraid.c (it replaces the invalid
> > silraid.c driver).
>
> I'm curious. What makes you thnk silraid.c is invalid? And wouldn't it
> have been easier to just fix whatever you were missing in silraid ??

The superblock has a different format from what is in silraid.c, and it
does not detect the Medley RAID at all in a normal case (e.g. my array is
undetected).

I would have changed silraid.c, but I thought it was more appropriate to
call it Medley since the RAID BIOS was really developed by CMD for the
680(A) based RAID controllers (and possibly others who might license it),
so is not only used for Silicon Image controllers (but it is called Medley
RAID in any case).

The detection code now follows the specification from CMD/Silicon Image (I
did have access to some documentation ;-) - and the Silicon Image brand
continues alongside the CMD stuff so I thought it was more appropriate to
give the driver a neutral name (it's not like I didn't give you credit in
the source, of course I appreciate your ataraid framework without which
writing this driver would have been an order of magnitude harder).

The superblock is different, although your version had the most important
fields (however, it would break for Version 1 arrays), but the detection
was not correct (e.g. it didn't detect my array), also Silicon Image
doesn't do the cut-off magic like hptraid does, but use the size of the
smallest drive.

The whole detection of the arrays is different, the "make_request"
obviously isn't that different since the principle remains the same (but
you will notice it's implemented a bit differently).

I have written at least 2-3 mails to you and the list more than a month
ago aboout this, and I didn't get any response, that's the reason I
decided to take things into "my own hands" and research and write this
driver. Not to piss you off, which I hope I haven't done.

Cheers,
Thomas

[2 mails sent off-list by mistake, repeated and edited]


