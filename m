Return-Path: <linux-kernel-owner+w=401wt.eu-S1754897AbXABRfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754897AbXABRfo (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 12:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754901AbXABRfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 12:35:44 -0500
Received: from rtr.ca ([64.26.128.89]:1024 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754897AbXABRfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 12:35:43 -0500
Message-ID: <459A97EC.8090903@rtr.ca>
Date: Tue, 02 Jan 2007 12:35:40 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
Cc: Jens Axboe <jens.axboe@oracle.com>, Rene Herman <rene.herman@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.20-rc2+: CFQ halving disk throughput.
References: <45893CAD.9050909@gmail.com> <45921E73.1080601@gmail.com> <4592B25A.4040906@gmail.com> <45932AF1.9040900@gmail.com> <45998F62.6010904@gmail.com> <4599992D.8000607@rtr.ca> <20070102083414.GQ2483@kernel.dk> <459A73CB.8010901@rtr.ca> <459A8E17.80601@gmail.com>
In-Reply-To: <459A8E17.80601@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
>
> OT but care to make -i and -I work equivalently?  Such that -i reports
> more detailed info and user can dump stored id block.

hdparm -I works just fine now.

hdparm -i requires the HDIO_GET_IDENTITY ioctl() from drivers/ide,
to retrieve the "boot time" copy of the identify block, before any
mods are made by the driver.  But in recent years, drivers/ide has
broken it, in that it tries to maintain the "boot time" copy in sync
with the on-drive copy.  Kinda makes -i pointless.

Is there a way to retrieve the libata cached copy of the ID block?
How?

>Support for IDENTIFY PACKET DEVICE would be nice too.

It already does that, using HDIO_DRIVE_CMD to retrieve it
in the same way as for regular IDENTIFY DEVICE commands.

In hdparm-7.0, I'll have it use ATA passthrough when possible
for most/all commands.

Cheers
