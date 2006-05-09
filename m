Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbWEIMS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbWEIMS6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 08:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbWEIMS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 08:18:58 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:17091 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932401AbWEIMS5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 08:18:57 -0400
Subject: Re: libata PATA patch update
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <445FD8D4.9030106@keyaccess.nl>
References: <1147104400.3172.7.camel@localhost.localdomain>
	 <445FD8D4.9030106@keyaccess.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 09 May 2006 13:30:57 +0100
Message-Id: <1147177857.3172.70.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-05-09 at 01:48 +0200, Rene Herman wrote:
> The "couldn't disable kernel command translation layer" bit is probably
> expected?

I think so yes.

> In any case, it seems that this driver is also not using DMA for CDDA? I 

It should use whatever the sr.c SCSI CD driver code uses when doing
CDDA, and it isn't directly a part of the driver (although there are
hooks so drivers can filter/control what ATAPI can be done with DMA).

> am using slackware 10.2 (vanilla) "cdparanoia III release 9.8 (March 23, 
> 2001)". A while ago someone on this list pointed to some patches for 
> SG_IO use with cdparanoia but this made my machine highly unstable. 
> Would you like me to retest with this new driver? If so, any specific 
> version of cdparanoia?

I would be interested to know what happens if you try this, version
doesn't matter.

> DVD is fine. UDMA33 though, although the drive is capable of UDMA66:

The core code sets both drives to the same speed on the cable. The old
-ac code fixed this but I've not pushed that change over (in part
because it will naturally happen now as other changes go in).

Thus dev1 is pulling dev0 down to UDMA33 for now.

> The old IDE driver does set it to UDMA66 after an ide1=ata66, and after
> the recently merged patch to amd74xx to "only do disk side cable
> detection". I assumed it was that same problem, but I see that

That change is in the libata driver as well so should not be a problem.

> Hope this was a useful report...

Much appreciated,

Alan

