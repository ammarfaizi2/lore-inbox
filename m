Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262498AbTE0BNI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 21:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbTE0BJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 21:09:16 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:13260
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262426AbTE0BIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 21:08:14 -0400
Subject: Re: [BK PATCHES] add ata scsi driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0305252236400.10183-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0305252236400.10183-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053994974.17129.32.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 May 2003 01:22:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-05-26 at 06:40, Linus Torvalds wrote:
> > And for specifically Intel SATA, drivers/ide flat out doesn't work (even 
> > though it claims to).
> 
> Well, I don't think it claimed to, until today. Still doesn't work?

Even if it did it would at best be a toy. The core IDE layer doesn't
handle SCSI errors properly (needed for ATAPI) except using ide-scsi. It
doesn't handle hot plugging of devices, it doesn't handle tagged
queueing very well, it hasn't the slightest idea about multipath (SATA2
can do), it doesn't know a lot of other things either.

SATA and especially SATA2 is basically SCSI with some slightly odd ways
of issuing READ10/WRITE10 to disk devices. A "native" driver would
basically be a copy of most of drivers/scsi.

I actually think thats a positive thing. It means 2.5 drivers/scsi is
now very close to being the "native queueing driver" with some
additional default plugins for doing scsi scanning, scsi error recovery 
and a few other scsi bits.


