Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265200AbUBCARE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 19:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265258AbUBCARE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 19:17:04 -0500
Received: from fw.osdl.org ([65.172.181.6]:29653 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265200AbUBCAQy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 19:16:54 -0500
Subject: Re: ide taskfile and cdrom hang
From: Mark Haverkamp <markh@osdl.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Cliff White <cliffw@osdl.org>
In-Reply-To: <200402030113.49852.bzolnier@elka.pw.edu.pl>
References: <1075502193.26342.61.camel@markh1.pdx.osdl.net>
	 <200402030037.32701.bzolnier@elka.pw.edu.pl>
	 <1075765927.13805.3.camel@markh1.pdx.osdl.net>
	 <200402030113.49852.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain
Message-Id: <1075767384.13805.9.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 02 Feb 2004 16:16:24 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-02-02 at 16:13, Bartlomiej Zolnierkiewicz wrote:
> On Tuesday 03 of February 2004 00:52, Mark Haverkamp wrote:
> > On Mon, 2004-02-02 at 15:37, Bartlomiej Zolnierkiewicz wrote:
> > > On Monday 02 of February 2004 22:44, Mark Haverkamp wrote:
> > > > On Mon, 2004-02-02 at 13:35, Bartlomiej Zolnierkiewicz wrote:
> > > > > On Monday 02 of February 2004 21:45, Mark Haverkamp wrote:
> > > > > > On Mon, 2004-02-02 at 11:45, Bartlomiej Zolnierkiewicz wrote:
> > > > > > > On Monday 02 of February 2004 19:46, Mark Haverkamp wrote:
> > > > > > > > On Sun, 2004-02-01 at 12:48, Bartlomiej Zolnierkiewicz wrote:
> >
> > [ ... ]
> >
> > > Now, can you comment out "(UDELAY(10))" printk and add printk for
> > > "retries" variable after while {} loop.  I thought there will be more
> > > "(UDELAY(10))" messages - but I forgot about delay introduced by printk()
> > > call :-).
> > >
> > > --bart
> >
> > I ran twice, got the same results:
> >
> > 1)
> > hda: (WAIT_NOT_BUSY) status=0x50 retry 94
> > hda: (CHECK_STATUS) status=0x50
> > hda: (WAIT_NOT_BUSY) status=0x50 retry 94
> > hda: (CHECK_STATUS) status=0x50
> 
> Is this output for single 'cat /proc/ide/hda/identify' run?
> There should be only one WAIT_NOT_BUSY and one CHECK_STATUS.

I see two for each cat.  Also, the 94 is the leftover number. So there
were probably about 6 retries.
> 
> > 2)
> > hda: (WAIT_NOT_BUSY) status=0x50 retry 94
> > hda: (CHECK_STATUS) status=0x50
> > hda: (WAIT_NOT_BUSY) status=0x50 retry 94
> > hda: (CHECK_STATUS) status=0x50
> 
> Wow, 94 retries vs. limit of 5 previously.

The 94 is the leftover number. Retry started at 100 and was decremented
in the status check loop. So there were probably about 6 retries.


> 
> Please also check if  'hdparm -Istdin</proc/ide/hda/identify'
> returns correct information now.

# hdparm  -Istdin</proc/ide/hda/identify
 
ATAPI CD-ROM, with removable media
        Model Number:       CD-224E
        Serial Number:
        Firmware Revision:  1.5A
Standards:
        Likely used CD-ROM ATAPI-1
Configuration:
        DRQ response: 50us.
        Packet size: 12 bytes
Capabilities:
        Cmd overlap, LBA, IORDY(can be disabled)
        Buffer size: 128.0kB
        Overlap support: 896us to release bus. 115us to clear BSY after SERVICE
cmd.
        DMA: sdma0 sdma1 sdma2 mdma0 mdma1 *mdma2
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=120ns  IORDY flow control=120ns


Plus:

hda: (WAIT_NOT_BUSY) status=0x50 retry 94
hda: (CHECK_STATUS) status=0x50

on the console.


> 
> Thanks,
> --bart

I see two for each cat.  Also, the 94 is the leftover number. So there
were probably about 6 retries.

Mark.
-- 
Mark Haverkamp <markh@osdl.org>

