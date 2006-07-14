Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161280AbWGNROe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161280AbWGNROe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 13:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161276AbWGNROe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 13:14:34 -0400
Received: from rtr.ca ([64.26.128.89]:65211 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1161274AbWGNROd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 13:14:33 -0400
Message-ID: <44B7D0F7.6000302@rtr.ca>
Date: Fri, 14 Jul 2006 13:14:31 -0400
From: Mark Lord <liml@rtr.ca>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Sander <sander@humilis.net>, linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>
Subject: Re: Follow up? LibPATA code issues / 2.6.15.4 (found the opcode=0x35)!
References: <Pine.LNX.4.64.0602140439580.3567@p34>  <44AEB3CA.8080606@pobox.com>  <Pine.LNX.4.64.0607071520160.2643@p34.internal.lan>  <200607091224.31451.liml@rtr.ca>  <Pine.LNX.4.64.0607091327160.23992@p34.internal.lan>  <Pine.LNX.4.64.0607091612060.3886@p34.internal.lan>  <Pine.LNX.4.64.0607091638220.2696@p34.internal.lan>  <Pine.LNX.4.64.0607091645480.2696@p34.internal.lan>  <Pine.LNX.4.64.0607091704250.2696@p34.internal.lan>  <Pine.LNX.4.64.0607091802460.2696@p34.internal.lan>  <Pine.LNX.4.64.0607100958540.3591@p34.internal.lan> <1152545639.27368.137.camel@localhost.localdomain> <Pine.LNX.4.64.0607101145030.3591@p34.internal.lan>
In-Reply-To: <Pine.LNX.4.64.0607101145030.3591@p34.internal.lan>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Jeff/Mark, from these errors can we reach a consensus as to the cause
>of these errors and how to eliminate the problem? 

It is up to the current subsystem maintainer to help investigate this
and come up with a solution, in cooperation with eager testers such
as yourself.  I gave away my kernel subsystem maintainer's duties about
seven years ago, because it just takes too much time to do it really well.

In this case, I'm proving a tiny amount of help, simply because I don't
see anyone else even trying, and there is obviously something wrong here.

Now.. your hacked version of my simple patch is incorrect.  It is frequently
dumping out ata_op=0x51, which is obviously the ATA status value not the
original ATA command byte.

But ignoring that, we also see some valid output from where it does trip
the code from my original patches:  ata_op=0x35.

So, the drive is rejecting an LBA48 WRITE operation, which should happen
only if the drive does not have LBA48 support.  Now, I know you posted all
of this nice info months ago, but let's see it again now, for the exact
drive that is generating that specific message.  We need to see the output
from "hdparm --Istdout /dev/sdX" for that drive.

Thanks
