Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319294AbSIFR3k>; Fri, 6 Sep 2002 13:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319295AbSIFR3k>; Fri, 6 Sep 2002 13:29:40 -0400
Received: from pc-80-195-6-65-ed.blueyonder.co.uk ([80.195.6.65]:11140 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S319294AbSIFR3i>; Fri, 6 Sep 2002 13:29:38 -0400
Date: Fri, 6 Sep 2002 18:34:15 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: linux-kernel@vger.kernel.org, Marius Gedminas <mgedmin@centras.lt>
Cc: ext2-devel@lists.sourceforge.net, Stephen Tweedie <sct@redhat.com>
Subject: Re: ext3 corruption on 2.4.18 (LVM, vt82c586b, no DMA)
Message-ID: <20020906183415.B7946@redhat.com>
References: <20020904102605.GB8576@gintaras>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020904102605.GB8576@gintaras>; from mgedmin@centras.lt on Wed, Sep 04, 2002 at 12:26:06PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Sep 04, 2002 at 12:26:06PM +0200, Marius Gedminas wrote:
> There's an old Compaq Deskpro 2000 (Pentium MMX 166 MHz, 384M RAM)
> that's being used as an Internet gateway (NAT) and FTP server for about
> 200 users.  It was previously running that other operating system, and I
> helped convert it to Linux (Debian 3.0).

> About 20 hours after mke2fs the first erros started cropping up:
> 
>   kernel: EXT3-fs error (device lvm(58,0)): ext3_add_entry: bad entry in directory #8568833: rec_len %% 4 != 0 - offset=0, inode=1104134607, rec_len=16847, name_len=207

Well, there are a couple of ext3 fixes that have just been merged into
Marcelo's bk tree, so you could try that and see if it helps.
However, I suspect it won't, because:

> Unfortunately I noticed this only two days later.  e2fsck found *lots*
> of errors, and it keeps restarting from the beginning for some reason.
> I'm starting to have doubts if it will ever finish.

This suggests that e2fsck is finding new corruption each time it is
scanning the disk.  That sounds as if a hardware or driver-level
problem is more likely.  What sorts of errors are you getting from the
fsck passes?

> Is this an unfortunate interaction between ext3 and LVM, or should I
> suspect flaky hardware?  RAM, disks, IDE cable?  There were problems
> with /dev/hdd earlier that hinted a broken cable (borken model name in
> hdparm -i), and the cable was replaced with a new one.

One thing that would help would be to try a surface scan which writes
stuff to the disk and verifies it.  The "badblocks" code from e2fsck
can do that, but the most effective form of "badblocks" for such a
case is highly destructive to your data, so it's only useful if you
don't need to preserve the data already on the filesystem.

> I gather from Configure.help that DMA is broken on Via VP2, but it is
> turned off here.

Unfortunately, if you disable UDMA mode, you also lose the checksums
between drive and controller which can detect cable data corruption.

Cheers,
 Stephen
