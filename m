Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281926AbRLFSZz>; Thu, 6 Dec 2001 13:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281916AbRLFSZq>; Thu, 6 Dec 2001 13:25:46 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:15375 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281921AbRLFSYW>; Thu, 6 Dec 2001 13:24:22 -0500
Subject: Re: Linux/Pro  -- clusters
To: torvalds@transmeta.com (Linus Torvalds)
Date: Thu, 6 Dec 2001 18:33:25 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0112060958450.10625-100000@penguin.transmeta.com> from "Linus Torvalds" at Dec 06, 2001 10:07:01 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16C3Kn-0002XC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Some of them are effectively turned off - the format timeout was increased
> to 2 hours to make sure that it basically never triggers.

Thats scsi_generic which thankfully puts most of the logic in user space.

> > Those devices aren't SCSI controllers, and they don't want to appear as one.
> 
> Don't think "SCSI" as in SCSI controllers. Think SCSI as in "fairly
> generic packet protocol that somehow infiltrated most things".

The scsi controller is akin to a network driver. The stuff that matters is
stuff like the scsi disk, scsi cd and scsi tape drivers. Scsi disk and CD
need to do a lot of error recovery (especially CD-ROM). Disk too has to 
because older scsi devices don't have the same kind of "the host is clueless
crap I'll have to try error recovery myself before reporting" mentality.

It would be nice if a lot of the CD error/recovery logic could be in the
cdrom libraries because the logic (close the door, lock the door, try
half speed, ..) is the same in scsi and ide.

> It's called "struct block_device" and "struct genhd". The pointers will
> have as many bits as pointers have on the architecture. Low-level drivers
> will not even see anything else eventually, there will be no "numbers".

For those of us who want to run a standards based operating system can
you do the 32bit dev_t. Otherwise some slightly fundamental things don't
work. You know boring stuff like ls, find, df, and other standard unix
commands. Those export a dev_t cookie. 

If you don't want to be able to run stuff like ls, just let me know and
I'll start another kernel tree 8)

Alan
