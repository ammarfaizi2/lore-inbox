Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263663AbUFDOBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263663AbUFDOBZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 10:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265787AbUFDOBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 10:01:25 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:4224 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263663AbUFDOBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 10:01:19 -0400
Date: Fri, 4 Jun 2004 15:09:03 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200406041409.i54E93hx000153@81-2-122-30.bradfords.org.uk>
To: Rick Jansen <rick@rockingstone.nl>, linux-kernel@vger.kernel.org
In-Reply-To: <20040604095409.GL18885@web1.rockingstone.nl>
References: <20040604075448.GK18885@web1.rockingstone.nl>
 <200406040943.i549h2aG000175@81-2-122-30.bradfords.org.uk>
 <20040604095409.GL18885@web1.rockingstone.nl>
Subject: Re: DriveReady SeekComplete Error
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please don't trim the CC list.

Quote from Rick Jansen <rick@rockingstone.nl>:
> On Fri, Jun 04, 2004 at 10:43:02AM +0100, John Bradford wrote:
> > Please post more information.  First, what size is the disk?
> > 
> > The LBAsect number suggests an access around 108 Gb.  If the disk is smaller
> > than this, then it would appear that a request was made for a non-existant
> > sector.
> > 
> > Is the LBAsect number the same in each error?  What is the machine doing
> > when the errors occur?
> > 
> > John.
> 
> Here's some more information about the disk from the boot log.
> I also found some StatusErrors in there.
> 
> May 10 11:14:07 web3 kernel: hda: Maxtor 6Y120P0, ATA DISK drive
> May 10 11:14:07 web3 kernel: hda: max request size: 128KiB
> May 10 11:14:07 web3 kernel: hda: 240121728 sectors (122942 MB)
> w/7936KiB Cache, CHS=65535/16/63, UDMA(133)
> May 10 11:14:07 web3 kernel:  hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
> May 10 11:14:07 web3 kernel: hda: task_no_data_intr: status=0x51 {
> DriveReady SeekComplete Error }
> May 10 11:14:07 web3 kernel: hda: task_no_data_intr: error=0x04 {
> DriveStatusError }
> May 10 11:14:07 web3 kernel: hda: Write Cache FAILED Flushing!
> 
> Thats a different error then what it gives me occasionaly. Googling this
> error lead me to believe this is a bug in the ide driver, that my disk
> doesnt support some flush command.
> 
> After parsing the log with simple script, these sectors seem to give the
> errors:
> 
> 227270012
> 227270483
> 236708724
> 237757036
> 237757472
> 238018530
> 238020393
> 238279554
> 238804853
> 239066426
> 239328347
> 239590823
> 240116567
> 240121662
> 58619113
> 58619120
> 58619127
> 58619447
> 58619448
> 58619519
> 58620045
> 58620048
> 58620331

The lower ones are definitely within the capacity of the drive.  I suspect
it _may_ genuinuely be faulty after all.

Back up your data.

If practical, try overwriting the whole disk, with something like:

dd if=/dev/zero of=/dev/hda

and see if it makes the errors go away.

John.
