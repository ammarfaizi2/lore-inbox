Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262866AbULRMPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262866AbULRMPW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 07:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262867AbULRMPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 07:15:22 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:3597 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S262866AbULRMPL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 07:15:11 -0500
Date: Sat, 18 Dec 2004 13:15:07 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 3TB disk hassles
Message-ID: <20041218121507.GB8886@pclin040.win.tue.nl>
References: <20041216145229.29167.qmail@web26502.mail.ukl.yahoo.com> <Pine.LNX.4.61.0412161703290.30336@yvahk01.tjqt.qr> <1103212832.21920.7.camel@localhost.localdomain> <20041218001254.GA8886@pclin040.win.tue.nl> <cq06vq$1t2$1@terminus.zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cq06vq$1t2$1@terminus.zytor.com>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: : kweetal.tue.nl 1074; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 18, 2004 at 03:08:42AM +0000, H. Peter Anvin wrote:
> Followup to:  <20041218001254.GA8886@pclin040.win.tue.nl>
> By author:    Andries Brouwer <aebr@win.tue.nl>
> In newsgroup: linux.dev.kernel
> > 
> > Yes, indeed.
> > 
> > One can use a standard DOS-type partition table, and pick a new type -
> > I reserved 88 for this purpose today - where type 88 indicates a
> > plaintext partition table found elsewhere on the disk.
> > Where is elsewhere? In the starting sector of the type 88 partition
> > (that can have length 1).
> > This allows one to have the initial part of the disk (at most 2 TB)
> > partitioned in old-fashioned manner.
> > 
> > The plaintext partition table is just a table with lines
> > 	<start> <size>
> > that one can edit with emacs or vi.
> > 
> > There is magic to recognize it, namely the line
> > 	"# Plaintext partition table"
> > and magic to indicate the end of the table, namely "# end".
> > 
> > That is all. If anybody wants it I can send the trivial code.
> > (Am using it now, but unfortunately I do not have 3 TB disks.)
> 
> First, what's wrong with the GUID partition table format?  Let's stick
> to standards as long as they work; especially for things that
> potentially affect multiple operating systems.
> 
> Second, several problems with this.  Sector 0 is the boot sector, so
> using it is a really bad choice.  (I'd reserve several sector for
> master boot code.)  In fact, rather than having a separate partition,
> why don't we just specify that a sector starting with "# Plaintext partition
> table" has to start within the first 64 sectors of the disk (it's
> common for DOS partition tables to have the first partition start at
> offset 63.)
> 
> Third, it ought to be possible to put more information than this,
> e.g. for raid detect.

Concerning third, I allow for labels and comments (after #), so anybody
can add any type of recognizable comments or pragmas. The header line
and closing line are examples of comments that already have significance.

Concerning second, I think you misunderstood something. Don't know why
you think I am using MBR - certainly not to put this plaintext table.
In fact MBR has a traditional DOS-type partition table that allows for
a boot setup in traditional ways in case utilities are used that only
understand the old ways. But type 88 describes a (very short) partition
that contains the plaintext partition table. Life is easy:
	# emacs partition_table
	# cat partition_table > /dev/sda2
and reboot or
	# blockdev --rereadpt /dev/sda

Concerning one, it is a somewhat complicated format that takes over
your disk, rather inconvenient. It seems to me that one needs a good
reason (like a BIOS that understands the format and is able to boot
from it) to choose it.

Andries
