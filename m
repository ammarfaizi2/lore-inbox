Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbTIYAFK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 20:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbTIYAFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 20:05:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35714 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261613AbTIYAFE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 20:05:04 -0400
Date: Thu, 25 Sep 2003 01:05:03 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: rfc: test whether a device has a partition table
Message-ID: <20030925000503.GC7665@parcelfarce.linux.theplanet.co.uk>
References: <UTC200309242029.h8OKTo008219.aeb@smtp.cwi.nl> <bkt3qe$imh$1@build.pdx.osdl.net> <20030924235041.GA21416@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030924235041.GA21416@win.tue.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 25, 2003 at 01:50:41AM +0200, Andries Brouwer wrote:
> > On closer examination it seems to be the partition table
> > which is read ok (as one partition) on W2K and XP
> > but Linux (both 2.4 and 2.6) gets really confused and
> > thinks there are 4 malformed partitions.
> 
> and
> 
> > Linux probably needs to handle this situation more
> > gracefully. A local police force bought a bunch of
> > these devices for Linux based forensic work. They
> > are a bit disappointed at the moment.
> 
> So, now not only theory but also practice is involved, and
> we must do something.

If there *is* a partition table with one entry and it gets misparsed - we
have a real bug that has to be dealt with and your heuristics won't help.
If there is no partition table at all and in fact they have a filesystem
on the entire disk - let them use *entire* *disk*.  You can very well
read /dev/sd<letter>, mount it, whatever.  Here I do have a SCSI disk
that is not partitioned at all.  And guess what?  It works with no extra
efforts needed:

  Vendor: QUANTUM   Model: ATLAS10K3_18_SCA  Rev: 020W
  Type:   Direct-Access                      ANSI SCSI revision: 03
sym53c1010-33-0-<0,0>: tagged command queue depth set to 4
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
sym53c1010-33-0-<0,*>: FAST-20 WIDE SCSI 40.0 MB/s (50.0 ns, offset 31)
SCSI device sda: 35916548 512-byte hdwr sectors (18389 MB)
 sda: unknown partition table

al@satch:~/kernel/2.5$ mount | grep sda
/dev/sda on /mnt/sda type ext2 (rw)

Note that usb-storage looks like a SCSI host for the rest of kernel, so that's
exactly the same situation - device that is expected to be partitioned but in
reality isn't.

So what precisely are you trying to fix?
