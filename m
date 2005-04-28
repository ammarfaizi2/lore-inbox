Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262267AbVD1Vwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262267AbVD1Vwn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 17:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbVD1Vwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 17:52:43 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:23505 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262267AbVD1Vwk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 17:52:40 -0400
Subject: Re: IDE problems with rmmod ide-cd
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jens Axboe <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <58cb370e05042813466915eebb@mail.gmail.com>
References: <1114706653.18330.212.camel@localhost.localdomain>
	 <20050428172541.GN1876@suse.de> <58cb370e05042813466915eebb@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1114725062.18809.226.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 28 Apr 2005 22:51:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-04-28 at 21:46, Bartlomiej Zolnierkiewicz wrote:
> > The problem you are thinking of was also an ATAPI cache flush command,
> > so I'm not so sure I would call it harmless... I haven't changed
> > anything in there recently, Bart?
> 
> I don't remember changing anything there recently.
> Alan, please give more details of the issue.

Torvalds tree - head

Hardware is as follows
	Promise IDE controller on ide0/1 - no drives
	VIA IDE controller on ide2/3 - hdd is a DVD-ROM
	and hdg is a disk.

hdd: TOSHIBA DVD-ROM SD-M1212

I had some code logging the commands issued and I did rmmod ide-cd. At
that point it sent a cache flush to the drive which then errorred it.

The actual log entry is

hdd: packet command error
Gives status=0x51, error=0x50

Dumping the error in detail its

Error;Illegal Request (Sense 0x05)
Invalid command operation code (0x20, 0x00)
The failed "Flush cache" packet command was
"35 00 00 00 00 00 ... 00"


